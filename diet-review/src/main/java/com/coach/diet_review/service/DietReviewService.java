package com.coach.diet_review.service;

import com.coach.diet_review.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DietReviewService {

    private static final String REVIEW_DISCLAIMER = "AI review is advisory only. Coaches should validate recommendations against the member's medical needs, allergies, preferences, and training phase.";

    private final OpenAiDietReviewClient openAiDietReviewClient;
    private final DietReviewPromptFactory promptFactory;

    public DietReviewResponse review(String coachEmail, DietReviewRequest request) {
        List<MacroGapDto> macroGaps = buildMacroGaps(request.targetTotals(), request.currentTotals());
        GeneratedDietReview fallbackReview = buildFallbackReview(request, macroGaps);
        Optional<GeneratedDietReview> openAiReview = openAiDietReviewClient
                .review(promptFactory.buildPrompt(coachEmail, request, macroGaps));
        GeneratedDietReview generatedReview = openAiReview.orElse(fallbackReview);

        return new DietReviewResponse(
                request.memberId(),
                generatedReview.summary(),
                macroGaps,
                generatedReview.suggestions(),
                generatedReview.rowSuggestions(),
                REVIEW_DISCLAIMER,
                openAiReview.isPresent() ? "OPENAI" : "RULE_BASED"
        );
    }

    private List<MacroGapDto> buildMacroGaps(DietMacroTotalsDto targetTotals, DietMacroTotalsDto currentTotals) {
        return List.of(
                createGap("calories", targetTotals.calories(), currentTotals.calories()),
                createGap("protein", targetTotals.protein(), currentTotals.protein()),
                createGap("carbs", targetTotals.carbs(), currentTotals.carbs()),
                createGap("fat", targetTotals.fat(), currentTotals.fat())
        );
    }

    private MacroGapDto createGap(String metric, Integer target, Integer current) {
        int difference = current - target;
        String status = difference == 0 ? "ON_TARGET" : difference > 0 ? "ABOVE_TARGET" : "BELOW_TARGET";
        return new MacroGapDto(metric, target, current, difference, status);
    }

    private GeneratedDietReview buildFallbackReview(DietReviewRequest request, List<MacroGapDto> macroGaps) {
        List<String> suggestions = new ArrayList<>();

        macroGaps.forEach(gap -> suggestions.add(buildMacroSuggestion(gap)));

        findLargestCalorieRow(request.rows()).ifPresent(row -> suggestions.add(
                "Review portion size for " + row.foodName() + " in " + row.mealType() + " because it contributes the largest calorie share in this draft."
        ));

        List<RowSuggestionDto> rowSuggestions = request.rows().stream()
                .sorted(Comparator.comparingInt(DietReviewRowDto::calories).reversed())
                .limit(3)
                .map(this::buildRowSuggestion)
                .toList();

        String summary = buildSummary(macroGaps);
        return new GeneratedDietReview(summary, deduplicate(suggestions), rowSuggestions);
    }

    private String buildSummary(List<MacroGapDto> macroGaps) {
        long onTargetCount = macroGaps.stream().filter(gap -> "ON_TARGET".equals(gap.status())).count();
        if (onTargetCount == macroGaps.size()) {
            return "Current totals are aligned with the target macros, so the main opportunity is improving meal composition and distribution across the day.";
        }

        return "Current totals are close enough for coaching review, but the plan still needs a few macro adjustments before it cleanly matches the target profile.";
    }

    private String buildMacroSuggestion(MacroGapDto gap) {
        int absoluteDifference = Math.abs(gap.difference());

        return switch (gap.status()) {
            case "ABOVE_TARGET" -> "Reduce " + gap.metric() + " by about " + absoluteDifference + " to bring the plan closer to target totals.";
            case "BELOW_TARGET" -> "Increase " + gap.metric() + " by about " + absoluteDifference + " using foods that fit the member's preferences and digestion tolerance.";
            default -> "Keep " + gap.metric() + " roughly where it is because it is already on target.";
        };
    }

    private Optional<DietReviewRowDto> findLargestCalorieRow(List<DietReviewRowDto> rows) {
        return rows.stream().max(Comparator.comparingInt(DietReviewRowDto::calories));
    }

    private RowSuggestionDto buildRowSuggestion(DietReviewRowDto row) {
        String suggestion;
        if (row.protein() < 10) {
            suggestion = "Protein looks light for this item, so consider pairing it with a lean protein source if this meal is meant to support satiety or recovery.";
        } else if (row.fat() > row.protein()) {
            suggestion = "Fat is relatively high versus protein here, so check whether portion size or ingredient choice is pushing calories up faster than expected.";
        } else if (row.carbs() > row.protein() * 3) {
            suggestion = "Carbs dominate this item, so consider balancing it with more protein or fiber if steadier energy is the goal.";
        } else {
            suggestion = "This row looks fairly balanced, so focus mainly on how it fits the surrounding meals and daily totals.";
        }

        return new RowSuggestionDto(row.mealType(), row.foodName(), suggestion);
    }

    private List<String> deduplicate(List<String> suggestions) {
        return suggestions.stream().distinct().toList();
    }
}
