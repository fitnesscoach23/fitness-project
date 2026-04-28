package com.coach.diet_review.service;

import com.coach.diet_review.dto.DietReviewRequest;
import com.coach.diet_review.dto.MacroGapDto;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class DietReviewPromptFactory {

    public DietReviewPrompt buildPrompt(String coachEmail, DietReviewRequest request, List<MacroGapDto> macroGaps) {
        StringBuilder builder = new StringBuilder();
        builder.append("Coach email: ").append(coachEmail).append('\n');
        builder.append("Member id: ").append(request.memberId()).append('\n');
        builder.append("Target totals: calories=").append(request.targetTotals().calories())
                .append(", protein=").append(request.targetTotals().protein())
                .append(", carbs=").append(request.targetTotals().carbs())
                .append(", fat=").append(request.targetTotals().fat())
                .append('\n');
        builder.append("Current totals: calories=").append(request.currentTotals().calories())
                .append(", protein=").append(request.currentTotals().protein())
                .append(", carbs=").append(request.currentTotals().carbs())
                .append(", fat=").append(request.currentTotals().fat())
                .append('\n');
        builder.append("Macro gaps: ").append(macroGaps).append('\n');
        builder.append("Rows:\n");

        request.rows().forEach(row -> builder.append("- mealType=").append(row.mealType())
                .append(", foodName=").append(row.foodName())
                .append(", quantity=").append(row.quantity()).append(' ').append(row.unit())
                .append(", protein=").append(row.protein())
                .append(", carbs=").append(row.carbs())
                .append(", fat=").append(row.fat())
                .append(", calories=").append(row.calories())
                .append('\n'));

        builder.append("""
                Return JSON with:
                {
                  "summary": "short paragraph",
                  "suggestions": ["3 to 5 concise coach-friendly suggestions"],
                  "rowSuggestions": [
                    {"mealType": "...", "foodName": "...", "suggestion": "..."}
                  ]
                }
                Keep it concise, practical, and non-medical.
                """);

        return new DietReviewPrompt(builder.toString());
    }
}
