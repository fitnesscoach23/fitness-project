import { ChangeDetectorRef, Component, ElementRef, HostListener, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { CommonModule } from '@angular/common';
import { BillingApiService } from '../../../../core/api/billing-api.service';
import { FormsModule } from '@angular/forms';
import { CheckinApiService } from '../../../../core/services/checkin-api.service';
import { FormArray, FormBuilder, ReactiveFormsModule } from '@angular/forms';
import { environment } from '../../../../../environments/environment';
import { Chart, registerables } from 'chart.js';
import { forkJoin } from 'rxjs';
import { WorkoutApiService } from '../../../../core/services/workout-api.service';
import { DietApiService } from '../../../../core/services/diet-api.service';
import { ProgressCheckinApiService } from '../../../../core/services/progress-checkin-api.service';
import { ProgressCheckinPhotoApiService } from '../../../../core/api/progress-checkin-photo-api.service';
import { DailyCheckinCalendarComponent } from '../../components/daily-checkin-calendar/daily-checkin-calendar.component';
import {
  DailyCheckinApiService,
  DailyCheckinDay
} from '../../../../core/services/daily-checkin-api.service';
import { NotificationApiService } from '../../../../core/api/notification-api.service';

declare const XLSX: any;

type OverviewField = { key: string; label: string; asLink?: boolean };
type OverviewSection = { title: string; items: OverviewField[] };
type BodyMetricSourceField =
  | 'heightCm'
  | 'currentWeightKg'
  | 'gender'
  | 'age'
  | 'isLean'
  | 'activityFactor'
  | 'ibwKg'
  | 'bmi'
  | 'bmr'
  | 'tdee'
  | 'targetGoal'
  | 'targetCalorieFactor'
  | 'targetCalories'
  | 'proteinRda'
  | 'proteinGrams'
  | 'carbFactor'
  | 'carbsGrams'
  | 'fatsGrams'
  | 'auto';

type ComparisonEnhancementPreset = 'natural' | 'sharp' | 'defined' | 'custom';
type DietPlanTotals = { calories: number | null; protein: number | null; carbs: number | null; fats: number | null };
type DietItemViewModel = any & {
  displayFoodName: string;
  optionalAlternatives: string[];
};
type DietMealViewModel = {
  mealName: string;
  items: DietItemViewModel[];
};
export type WeeklyConsistencyTrend = 'improving' | 'declining' | 'stable';
type WeeklyScoreRating = {
  label: string;
  color: string;
  className: 'excellent' | 'good' | 'average' | 'needs-improvement';
};
type WeeklyConsistencyScore = {
  label: string;
  rangeLabel: string;
  completedWorkouts: number;
  plannedWorkouts: number;
  averageDailySteps: number;
  stepTarget: number;
  workoutCompliance: number;
  stepsCompliance: number;
  score: number;
  rating: string;
  ratingColor: string;
  ratingClass: WeeklyScoreRating['className'];
};

@Component({
  selector: 'app-member-profile',
  standalone: true,
  imports: [CommonModule, RouterLink, FormsModule, ReactiveFormsModule, DailyCheckinCalendarComponent],
  templateUrl: './member-profile.component.html',
  styleUrls: ['./member-profile.component.scss']
})
export class MemberProfileComponent implements OnInit {
  private readonly expirySoonDays = 7;
  @ViewChild('comparisonModal') comparisonModalRef?: ElementRef<HTMLDivElement>;
  @ViewChild('comparisonCapture') comparisonCaptureRef?: ElementRef<HTMLDivElement>;
  @ViewChild('weeklyReportCapture') weeklyReportCaptureRef?: ElementRef<HTMLDivElement>;

  member: any = null;
  loading = true;
  error: string | null = null;
  subscription: any = null;
  subscriptionHistory: any[] = [];
  subscriptionLoading = true;
  payments: any[] = [];
  confirmPaymentDates: Record<string, string> = {};
  paymentsLoading = true;
  paymentAmount: number | null = null;
  paymentActionLoading = false;
  paymentActionError: string | null = null;
  onlineAmount: number | null = null;
  onlinePaymentLoading = false;
  onlinePaymentResult: any = null;
  onlinePaymentError: string | null = null;
  checkins: any[] = [];
  checkinsLoading = true;
  checkinSubmitting = false;
  checkinError: string | null = null;
  editingCheckinId: string | null = null;
  checkinPhotosMap: { [checkinId: string]: any[] } = {};
  env = environment;
  uploadingPhotosMap: { [checkinId: string]: boolean } = {};
  workoutPlan: any = null;
  workoutLoading = true;
  allWorkoutPlans: any[] = [];
  assigningWorkout = false;
  assignWorkoutError: string | null = null;
  selectedWorkoutPlanId: string | null = null;
  activeWorkoutPlan: any = null;
  pastWorkoutPlans: any[] = [];
  weeklyConsistencyLoading = false;
  weeklyConsistencyError: string | null = null;
  currentWeekConsistency: WeeklyConsistencyScore | null = null;
  previousWeekConsistency: WeeklyConsistencyScore | null = null;
  weeklyConsistencyTrend: WeeklyConsistencyTrend = 'stable';
  weeklyScoreDifference = 0;
  weeklyManualFeedback = '';
  private weeklyFeedbackManuallyEdited = false;
  capturingWeeklyReport = false;
  sendingPaymentReminderWhatsApp = false;
  paymentReminderWhatsAppMessage: string | null = null;
  sendingWeeklyReportWhatsApp = false;
  weeklyReportWhatsAppMessage: string | null = null;
  sendingWorkoutPlanWhatsApp = false;
  workoutPlanWhatsAppMessage: string | null = null;
  dietPlan: any = null;
  dietLoading = true;
  groupedDietMeals: DietMealViewModel[] = [];
  dietWhatsAppMessageText = '';
  dietWhatsAppStatus: string | null = null;
  sendingDietWhatsApp = false;
  private dietPlanTotals: DietPlanTotals = { calories: null, protein: null, carbs: null, fats: null };
  private currentDietPlanSummaryText = 'NA';
  progressCheckins: any[] = [];
  progressCheckinsLoading = true;
  checkinPhotos: { [checkinId: string]: any[] } = {};
  draggedPhoto: { checkinId: string; index: number } | null = null;
  currentCheckin: any | null = null;
  previousCheckin: any | null = null;
  showProgressComparisonModal = false;
  isProgressComparisonMaximized = false;
  comparisonZoomLevel = 1;
  capturingComparison = false;
  sendingComparisonWhatsApp = false;
  comparisonWhatsAppMessage: string | null = null;
  comparisonEnhancementPreset: ComparisonEnhancementPreset = 'sharp';
  comparisonEnhancement = {
    contrast: 112,
    brightness: 103,
    saturate: 106,
    clarity: 8
  };
  activeSection: 'overview' | 'bodyMetrics' | 'billing' | 'progress' | 'dailyConsistency' | 'workout' | 'diet' = 'overview';
  totalPaid = 0;
  totalPending = 0;
  latestWeight = 0;
  weightChange = 0;
  avgDietAdherence = 0;
  avgSteps = 0;
  deletingMember = false;
  overrideActiveSince = '';
  overrideRenewalDate = '';
  overrideCycle: 'MONTHLY' | 'QUARTERLY' | 'YEARLY' = 'MONTHLY';
  autoCalculateRenewal = true;
  overrideMessage: string | null = null;
  bodyMetricsAutoCalc = true;
  bodyMetricsManualOverride = false;
  bodyMetricsSaving = false;
  bodyMetricsMessage: string | null = null;
  private readonly targetGoalMap: Record<string, string> = {
    'Fat Loss': 'FAT_LOSS',
    'Maintenance': 'MAINTENANCE',
    'Gaining': 'GAINING'
  };
  private readonly targetGoalReverseMap: Record<string, 'Fat Loss' | 'Maintenance' | 'Gaining'> = {
    FAT_LOSS: 'Fat Loss',
    MAINTENANCE: 'Maintenance',
    GAINING: 'Gaining'
  };
  bodyMetrics = {
    heightCm: null as number | null,
    currentWeightKg: null as number | null,
    gender: '' as string,
    age: null as number | null,
    isLean: false,
    activityFactor: 1.2,
    trainingHistory: 'Sedentary' as 'Sedentary' | 'Beginner' | 'Intermediate' | 'Advance',
    proteinRda: 1.0,
    carbFactor: 3.0,
    targetGoal: 'Fat Loss' as 'Fat Loss' | 'Maintenance' | 'Gaining',
    targetCalorieFactor: 11,
    ibwKg: null as number | null,
    bmi: null as number | null,
    bmr: null as number | null,
    tdee: null as number | null,
    targetCalories: null as number | null,
    proteinGrams: null as number | null,
    carbsGrams: null as number | null,
    fatsGrams: null as number | null
  };

  readonly activityOptions = [
    { label: 'Sedentary (1.2)', value: 1.2 },
    { label: 'Lightly Active (1.375)', value: 1.375 },
    { label: 'Moderately Active (1.55)', value: 1.55 },
    { label: 'Very Active (1.725)', value: 1.725 },
    { label: 'Extremely Active (1.9)', value: 1.9 }
  ];

  readonly trainingHistoryOptions = [
    { label: 'Sedentary (0.8-1.0 g/kg)', value: 1.0 },
    { label: 'Beginner/Females (1.0-1.3 g/kg)', value: 1.2 },
    { label: 'Intermediate (1.5-1.8 g/kg)', value: 1.6 },
    { label: 'Advance (1.6-2.0 g/kg)', value: 1.8 }
  ];

  readonly targetGoalOptions = [
    { label: 'Fat Loss (10-12 x IBW lbs)', value: 'Fat Loss', defaultFactor: 11, min: 10, max: 12 },
    { label: 'Maintenance (12-14 x IBW lbs)', value: 'Maintenance', defaultFactor: 13, min: 12, max: 14 },
    { label: 'Gaining (14-16 x IBW lbs)', value: 'Gaining', defaultFactor: 15, min: 14, max: 16 }
  ];
  readonly overviewSections: OverviewSection[] = [
    {
      title: 'Identity',
      items: [
        { key: 'dateOfBirth', label: 'Date of Birth' },
        { key: 'age', label: 'Age' },
        { key: 'country', label: 'Country' },
        { key: 'stateCityProvince', label: 'State/City/Province' }
      ]
    },
    {
      title: 'Body Metrics',
      items: [
        { key: 'heightCm', label: 'Height (cm)' },
        { key: 'currentWeightKg', label: 'Current Weight (kg)' }
      ]
    },
    {
      title: 'Goals',
      items: [
        { key: 'mainTrainingGoal', label: 'Main Training Goal' },
        { key: 'goal', label: 'Primary Goal (System)' },
        { key: 'previousWeightLoss', label: 'Reduced Weight Before?' },
        { key: 'weightRegain', label: 'Weight Regain Details' },
        { key: 'goalReward', label: 'Goal Reward' }
      ]
    },
    {
      title: 'Training Profile',
      items: [
        { key: 'priorTrainingExperience', label: 'Prior Training Experience' },
        { key: 'dailyTrainingCommitmentHours', label: 'Daily Training Commitment' },
        { key: 'preferredWorkoutTiming', label: 'Preferred Workout Timing' },
        { key: 'daysPerWeekTrain', label: 'Days/Week Can Train' },
        { key: 'personalTrainingBefore', label: 'Personal Training Before?' }
      ]
    },
    {
      title: 'Lifestyle',
      items: [
        { key: 'activityLevel', label: 'Activity Level' },
        { key: 'stressLevel', label: 'Stress Level' },
        { key: 'sleepHours', label: 'Sleep Hours/Night' },
        { key: 'alcoholConsumption', label: 'Alcohol Consumption' },
        { key: 'smokingHabits', label: 'Smoking Habits' },
        { key: 'supplementsPast', label: 'Supplements Used' },
        { key: 'steroidUsage', label: 'Steroid Usage' },
        { key: 'pastSportsActivity', label: 'Past Sports Activity' }
      ]
    },
    {
      title: 'Nutrition',
      items: [
        { key: 'foodPreference', label: 'Food Preference' },
        { key: 'currentDietPlan', label: 'Current Diet Plan' },
        { key: 'favoriteFoods', label: 'Favorite Foods' },
        { key: 'foodAllergies', label: 'Food Intolerances/Allergies' },
        { key: 'typicalDay', label: 'Typical Day' }
      ]
    },
    {
      title: 'Health',
      items: [
        { key: 'medicalCondition', label: 'Medical Condition' },
        { key: 'medicalConditionsDetailed', label: 'Medical Conditions (Detailed)' },
        { key: 'injuries', label: 'Past/Current Injuries' },
        { key: 'additionalInfo', label: 'Additional Information' }
      ]
    },
    {
      title: 'Movement Assessment',
      items: [
        { key: 'pushUp', label: 'Push Up' },
        { key: 'squat', label: 'Squat' },
        { key: 'rowBandDumbbell', label: 'Row (Band/Dumbbell)' },
        { key: 'overheadPressDumbbell', label: 'Overhead Press (Dumbbell)' },
        { key: 'hipHingeRdl', label: 'Hip Hinge (RDL)' }
      ]
    },
    {
      title: 'Progress Photo Links',
      items: [
        { key: 'frontView', label: 'Front View', asLink: true },
        { key: 'sideView', label: 'Side View', asLink: true },
        { key: 'backView', label: 'Back View', asLink: true }
      ]
    },
    {
      title: 'System Metadata',
      items: [
        { key: 'coachEmail', label: 'Coach Email' },
        { key: 'createdAt', label: 'Created At' },
        { key: 'updatedAt', label: 'Updated At' }
      ]
    }
  ];

  private buildGroupedDietMeals(): DietMealViewModel[] {
    const meals = this.dietPlan?.meals || [];
    const grouped = new Map<string, DietItemViewModel[]>();

    for (const meal of meals) {
      const mealName = (meal?.mealName || meal?.name || 'Other').trim();
      const key = mealName || 'Other';
      const items = (meal?.items || []).map((item: any) => {
        const parsed = this.parseDietItemFoodName(item?.foodName);
        return {
          ...item,
          displayFoodName: parsed.primaryFoodName,
          optionalAlternatives: parsed.optionalAlternatives
        };
      });

      if (!grouped.has(key)) {
        grouped.set(key, []);
      }

      grouped.get(key)!.push(...items);
    }

    return Array.from(grouped.entries()).map(([mealName, items]) => ({
      mealName,
      items
    }));
  }

  private refreshDietPlanViewModel(): void {
    this.groupedDietMeals = this.buildGroupedDietMeals();
    this.dietPlanTotals = this.calculateDietPlanTotals();
    this.currentDietPlanSummaryText = this.buildCurrentDietPlanSummary();
  }

  getDietItemDisplayName(foodName: any): string {
    return this.parseDietItemFoodName(foodName).primaryFoodName;
  }

  getDietItemOptionalAlternatives(foodName: any): string[] {
    return this.parseDietItemFoodName(foodName).optionalAlternatives;
  }

  private calculateDietPlanTotals(): DietPlanTotals {
    const items = this.groupedDietMeals.flatMap((meal) => meal.items || []);
    let calories = 0;
    let protein = 0;
    let carbs = 0;
    let fats = 0;
    let hasCalories = false;
    let hasProtein = false;
    let hasCarbs = false;
    let hasFats = false;

    items.forEach((item: any) => {
      const itemProtein = this.toNumberOrNull(item?.protein);
      const itemCarbs = this.toNumberOrNull(item?.carbs);
      const itemFats = this.toNumberOrNull(item?.fat ?? item?.fats);
      const itemCalories = this.toNumberOrNull(item?.calories);

      if (itemProtein != null) {
        protein += itemProtein;
        hasProtein = true;
      }

      if (itemCarbs != null) {
        carbs += itemCarbs;
        hasCarbs = true;
      }

      if (itemFats != null) {
        fats += itemFats;
        hasFats = true;
      }

      if (itemCalories != null) {
        calories += itemCalories;
        hasCalories = true;
      } else if (itemProtein != null || itemCarbs != null || itemFats != null) {
        calories += ((itemProtein ?? 0) * 4) + ((itemCarbs ?? 0) * 4) + ((itemFats ?? 0) * 9);
        hasCalories = true;
      }
    });

    return {
      calories: hasCalories ? this.roundTo(calories, 0) : null,
      protein: hasProtein ? this.roundTo(protein, 0) : null,
      carbs: hasCarbs ? this.roundTo(carbs, 0) : null,
      fats: hasFats ? this.roundTo(fats, 0) : null
    };
  }

  getMemberValue(key: string): any {
    return this.member?.[key];
  }

  hasMemberValue(key: string): boolean {
    const value = this.getMemberValue(key);

    if (value == null) return false;
    if (typeof value === 'string') return value.trim() !== '';
    return true;
  }

  formatMemberValue(value: any): string {
    if (value == null) return '-';
    if (typeof value === 'string') {
      const trimmed = value.trim();
      if (/^\d{4}-\d{2}-\d{2}T/.test(trimmed)) {
        const parsed = new Date(trimmed);
        if (!Number.isNaN(parsed.getTime())) {
          return new Intl.DateTimeFormat('en-IN', {
            dateStyle: 'medium',
            timeStyle: 'short'
          }).format(parsed);
        }
      }
      return trimmed || '-';
    }
    return String(value);
  }

  isExternalLink(value: any): boolean {
    return typeof value === 'string' && /^https?:\/\//i.test(value.trim());
  }

  setSection(section: typeof this.activeSection) {
    this.activeSection = section;

    if (section === 'progress') {
      setTimeout(() => this.renderWeightChart(), 0);
    }
  }

  private applyBodyMetrics(source: any) {
    if (!source) return;

    this.bodyMetrics.heightCm = this.toNumberOrNull(source.heightCm);
    this.bodyMetrics.currentWeightKg = this.toNumberOrNull(source.currentWeightKg);
    this.bodyMetrics.gender = source.gender ?? this.bodyMetrics.gender;
    this.bodyMetrics.age = this.toNumberOrNull(source.age);
    this.bodyMetrics.isLean = Boolean(source.isLean);
    this.bodyMetrics.activityFactor =
      this.toNumberOrNull(source.activityFactor) ?? this.bodyMetrics.activityFactor;
    this.bodyMetrics.proteinRda = this.toNumberOrNull(source.proteinRda) ?? this.bodyMetrics.proteinRda;
    this.bodyMetrics.carbFactor = this.toNumberOrNull(source.carbFactor) ?? this.bodyMetrics.carbFactor;
    this.bodyMetrics.targetGoal =
      this.targetGoalReverseMap[source.targetGoal] ?? source.targetGoal ?? this.bodyMetrics.targetGoal;
    this.bodyMetrics.targetCalorieFactor =
      this.toNumberOrNull(source.targetCalorieFactor) ?? this.bodyMetrics.targetCalorieFactor;
    this.bodyMetrics.ibwKg = this.toNumberOrNull(source.ibwKg);
    this.bodyMetrics.bmi = this.toNumberOrNull(source.bmi);
    this.bodyMetrics.bmr = this.toNumberOrNull(source.bmr);
    this.bodyMetrics.tdee = this.toNumberOrNull(source.tdee);
    this.bodyMetrics.targetCalories = this.toNumberOrNull(source.targetCalories);
    this.bodyMetrics.proteinGrams = this.toNumberOrNull(source.proteinGrams);
    this.bodyMetrics.carbsGrams = this.toNumberOrNull(source.carbsGrams);
    this.bodyMetrics.fatsGrams = this.toNumberOrNull(source.fatsGrams);
  }

  initializeBodyMetrics() {
    const storedMetrics = this.member?.bodyMetrics;
    if (storedMetrics) {
      this.applyBodyMetrics(storedMetrics);
      this.bodyMetricsManualOverride = this.inferBodyMetricsManualOverride(storedMetrics);
    } else {
      this.bodyMetrics.heightCm = this.toNumberOrNull(this.member?.heightCm);
      this.bodyMetrics.currentWeightKg = this.toNumberOrNull(this.member?.currentWeightKg);
      this.bodyMetrics.gender = this.member?.gender || '';
      this.bodyMetrics.age = this.toNumberOrNull(this.member?.age);
      this.bodyMetrics.isLean = false;
      this.bodyMetricsManualOverride = false;
    }

    if (this.bodyMetricsAutoCalc && !this.bodyMetricsManualOverride) {
      this.recalculateBodyMetrics('auto');
    }
  }

  onBodyMetricInput(field: BodyMetricSourceField) {
    if (!this.bodyMetricsAutoCalc) return;
    this.recalculateBodyMetrics(field);
  }

  toggleBodyMetricsManualOverride() {
    this.bodyMetricsManualOverride = !this.bodyMetricsManualOverride;

    if (!this.bodyMetricsManualOverride && this.bodyMetricsAutoCalc) {
      this.recalculateBodyMetrics('auto');
    }
  }

  recalculateBodyMetrics(sourceField: BodyMetricSourceField = 'auto') {
    const heightCm = this.toNumberOrNull(this.bodyMetrics.heightCm);
    let weightKg = this.toNumberOrNull(this.bodyMetrics.currentWeightKg);
    const age = this.bodyMetrics.age ?? null;
    const gender = (this.bodyMetrics.gender || '').toLowerCase();

    if (heightCm == null || heightCm <= 0) {
      this.bodyMetrics.ibwKg = null;
      this.bodyMetrics.bmi = null;
      this.bodyMetrics.bmr = null;
      this.bodyMetrics.tdee = null;
      this.bodyMetrics.targetCalories = null;
      this.bodyMetrics.proteinGrams = null;
      this.bodyMetrics.carbsGrams = null;
      this.bodyMetrics.fatsGrams = null;
      return;
    }

    const isSenior = age != null && age >= 50;
    let ibwKg = this.getAutoIbwKg(heightCm, gender, age, weightKg, this.bodyMetrics.isLean);
    const manualIbwKg = this.toNumberOrNull(this.bodyMetrics.ibwKg);
    if (sourceField === 'ibwKg' && manualIbwKg != null && manualIbwKg > 0) {
      ibwKg = manualIbwKg;
    }

    const heightM = heightCm / 100;
    const manualBmi = this.toNumberOrNull(this.bodyMetrics.bmi);
    let bmi = weightKg && heightM ? weightKg / (heightM * heightM) : null;
    if (sourceField === 'bmi' && manualBmi != null && manualBmi > 0 && heightM > 0) {
      bmi = manualBmi;
      weightKg = bmi * heightM * heightM;
      this.bodyMetrics.currentWeightKg = this.roundTo(weightKg, 1);
    }

    const autoBmr = this.getAutoBmr(ibwKg, gender, age);
    const manualBmr = this.toNumberOrNull(this.bodyMetrics.bmr);
    const bmr = sourceField === 'bmr' && manualBmr != null && manualBmr > 0 ? manualBmr : autoBmr;

    let activityFactor = this.toNumberOrNull(this.bodyMetrics.activityFactor) ?? 1.2;
    let tdee = bmr * activityFactor;
    const manualTdee = this.toNumberOrNull(this.bodyMetrics.tdee);
    if (sourceField === 'tdee' && manualTdee != null && manualTdee > 0 && bmr > 0) {
      tdee = manualTdee;
      activityFactor = manualTdee / bmr;
    } else {
      tdee = bmr * activityFactor;
    }

    const ibwLb = ibwKg * 2.20462;
    const autoTargetCalorieFactor = this.toNumberOrNull(this.bodyMetrics.targetCalorieFactor) ?? 0;
    const autoTargetCalories = ibwLb * autoTargetCalorieFactor;
    let targetCalorieFactor = autoTargetCalorieFactor;
    let targetCalories = autoTargetCalories;
    let proteinRda = this.toNumberOrNull(this.bodyMetrics.proteinRda) ?? 0;
    let proteinGrams = ibwKg * proteinRda;
    let carbFactor = this.toNumberOrNull(this.bodyMetrics.carbFactor) ?? 0;
    let carbsGrams = ibwKg * carbFactor;
    let fatsGrams = autoTargetCalories
      ? Math.max(0, (autoTargetCalories - (proteinGrams * 4 + carbsGrams * 4)) / 9)
      : 0;

    if (this.bodyMetricsManualOverride) {
      targetCalories = this.toNumberOrNull(this.bodyMetrics.targetCalories) ?? autoTargetCalories;
      proteinGrams = this.toNumberOrNull(this.bodyMetrics.proteinGrams) ?? proteinGrams;
      carbsGrams = this.toNumberOrNull(this.bodyMetrics.carbsGrams) ?? carbsGrams;
      fatsGrams = this.toNumberOrNull(this.bodyMetrics.fatsGrams) ?? fatsGrams;
    } else {
      const manualTargetCalories = this.toNumberOrNull(this.bodyMetrics.targetCalories);
      if (sourceField === 'targetCalories' && manualTargetCalories != null && manualTargetCalories >= 0) {
        targetCalories = manualTargetCalories;
        targetCalorieFactor = ibwLb > 0 ? manualTargetCalories / ibwLb : targetCalorieFactor;
      } else {
        targetCalories = ibwLb * targetCalorieFactor;
      }

      const manualProteinGrams = this.toNumberOrNull(this.bodyMetrics.proteinGrams);
      if (sourceField === 'proteinGrams' && manualProteinGrams != null && manualProteinGrams >= 0) {
        proteinGrams = manualProteinGrams;
        proteinRda = ibwKg > 0 ? manualProteinGrams / ibwKg : proteinRda;
      } else {
        proteinGrams = ibwKg * proteinRda;
      }

      const manualCarbsGrams = this.toNumberOrNull(this.bodyMetrics.carbsGrams);
      if (sourceField === 'carbsGrams' && manualCarbsGrams != null && manualCarbsGrams >= 0) {
        carbsGrams = manualCarbsGrams;
        carbFactor = ibwKg > 0 ? manualCarbsGrams / ibwKg : carbFactor;
      } else {
        carbsGrams = ibwKg * carbFactor;
      }

      fatsGrams = targetCalories
        ? Math.max(0, (targetCalories - (proteinGrams * 4 + carbsGrams * 4)) / 9)
        : 0;
      const manualFatsGrams = this.toNumberOrNull(this.bodyMetrics.fatsGrams);
      if (sourceField === 'fatsGrams' && manualFatsGrams != null && manualFatsGrams >= 0) {
        fatsGrams = manualFatsGrams;
        targetCalories = proteinGrams * 4 + carbsGrams * 4 + fatsGrams * 9;
        targetCalorieFactor = ibwLb > 0 ? targetCalories / ibwLb : targetCalorieFactor;
      }

      const normalizedTarget = this.normalizeTargetCaloriesForGoal(targetCalorieFactor, ibwLb);
      targetCalorieFactor = normalizedTarget.factor;
      targetCalories = normalizedTarget.calories;
    }

    this.bodyMetrics.ibwKg = this.roundTo(ibwKg, 1);
    this.bodyMetrics.bmi = bmi != null ? this.roundTo(bmi, 1) : null;
    this.bodyMetrics.bmr = this.roundTo(bmr, 0);
    this.bodyMetrics.activityFactor = this.roundTo(activityFactor, 3);
    this.bodyMetrics.tdee = this.roundTo(tdee, 0);
    this.bodyMetrics.targetCalorieFactor = this.roundTo(targetCalorieFactor, 2);
    this.bodyMetrics.proteinRda = this.roundTo(proteinRda, 2);
    this.bodyMetrics.carbFactor = this.roundTo(carbFactor, 2);
    this.bodyMetrics.targetCalories = this.roundTo(targetCalories, 0);
    this.bodyMetrics.proteinGrams = this.roundTo(proteinGrams, 0);
    this.bodyMetrics.carbsGrams = this.roundTo(carbsGrams, 0);
    this.bodyMetrics.fatsGrams = this.roundTo(fatsGrams, 0);
  }

  onGoalChange() {
    const goalConfig = this.targetGoalOptions.find((g) => g.value === this.bodyMetrics.targetGoal);
    if (goalConfig) {
      this.bodyMetrics.targetCalorieFactor = goalConfig.defaultFactor;
      if (this.bodyMetricsAutoCalc) {
        this.recalculateBodyMetrics('targetCalorieFactor');
      }
    }
  }

  onTrainingHistoryChange() {
    if (this.bodyMetricsAutoCalc) {
      this.recalculateBodyMetrics('proteinRda');
    }
  }

  saveBodyMetrics() {
    if (!this.member?.id) return;

    this.bodyMetricsSaving = true;
    this.bodyMetricsMessage = null;

    const heightCm = this.toNumberOrNull(this.bodyMetrics.heightCm);
    const currentWeightKg = this.toNumberOrNull(this.bodyMetrics.currentWeightKg);
    const age = this.toNumberOrNull(this.bodyMetrics.age);
    const activityFactor = this.toNumberOrNull(this.bodyMetrics.activityFactor);
    const proteinRda = this.toNumberOrNull(this.bodyMetrics.proteinRda);
    const carbFactor = this.toNumberOrNull(this.bodyMetrics.carbFactor);
    const rawTargetCalorieFactor = this.toNumberOrNull(this.bodyMetrics.targetCalorieFactor);
    const gender = (this.bodyMetrics.gender || '').trim();
    const targetGoal = this.targetGoalMap[this.bodyMetrics.targetGoal] ?? null;
    const ibwKg = this.toNumberOrNull(this.bodyMetrics.ibwKg);
    const ibwLb = ibwKg != null ? ibwKg * 2.20462 : 0;
    const normalizedTarget = this.normalizeTargetCaloriesForGoal(rawTargetCalorieFactor ?? 0, ibwLb);
    const targetCalorieFactor = normalizedTarget.factor;
    const targetCalories = this.bodyMetricsManualOverride
      ? (this.toNumberOrNull(this.bodyMetrics.targetCalories) ?? normalizedTarget.calories)
      : normalizedTarget.calories;

    if (!heightCm || !currentWeightKg || !age || !gender || !activityFactor || !proteinRda || !targetGoal || !targetCalorieFactor) {
      this.bodyMetricsMessage = 'Please fill all required fields before saving';
      this.bodyMetricsSaving = false;
      return;
    }
    if (activityFactor <= 0) {
      this.bodyMetricsMessage = 'Activity factor must be greater than 0';
      this.bodyMetricsSaving = false;
      return;
    }
    if (proteinRda <= 0) {
      this.bodyMetricsMessage = 'Protein RDA must be greater than 0';
      this.bodyMetricsSaving = false;
      return;
    }
    if (targetCalorieFactor <= 0) {
      this.bodyMetricsMessage = 'Target calorie factor must be greater than 0';
      this.bodyMetricsSaving = false;
      return;
    }

    const payload = {
      heightCm,
      currentWeightKg,
      gender,
      age: Math.round(age),
      isLean: !!this.bodyMetrics.isLean,
      activityFactor,
      proteinRda,
      carbFactor,
      targetGoal,
      targetCalorieFactor,
      ibwKg: this.toNumberOrNull(this.bodyMetrics.ibwKg),
      bmi: this.toNumberOrNull(this.bodyMetrics.bmi),
      bmr: this.toNumberOrNull(this.bodyMetrics.bmr),
      tdee: this.toNumberOrNull(this.bodyMetrics.tdee),
      targetCalories,
      proteinGrams: this.toNumberOrNull(this.bodyMetrics.proteinGrams),
      carbsGrams: this.toNumberOrNull(this.bodyMetrics.carbsGrams),
      fatsGrams: this.toNumberOrNull(this.bodyMetrics.fatsGrams)
    };

    this.bodyMetrics.targetCalorieFactor = this.roundTo(targetCalorieFactor, 2);
    if (!this.bodyMetricsManualOverride) {
      this.bodyMetrics.targetCalories = this.roundTo(targetCalories, 0);
    }

    this.memberApi.updateBodyMetrics(this.member.id, payload).subscribe({
      next: (res: any) => {
        const metrics = res?.bodyMetrics ?? res;
        if (metrics) {
          this.applyBodyMetrics(metrics);
          this.bodyMetricsManualOverride =
            this.bodyMetricsManualOverride || this.inferBodyMetricsManualOverride(metrics);
        }
        if (this.bodyMetricsAutoCalc && !this.bodyMetricsManualOverride) {
          this.recalculateBodyMetrics('auto');
        }
        if (this.member) {
          this.member.bodyMetrics = metrics ?? payload;
        }
        this.bodyMetricsMessage = 'Body metrics saved';
        this.bodyMetricsSaving = false;
      },
      error: (err) => {
        this.bodyMetricsMessage = err?.error?.message || 'Failed to save body metrics';
        this.bodyMetricsSaving = false;
      }
    });
  }

  private roundTo(value: number, decimals: number) {
    const factor = Math.pow(10, decimals);
    return Math.round(value * factor) / factor;
  }

  private getAutoIbwKg(
    heightCm: number,
    gender: string,
    age: number | null,
    weightKg: number | null,
    isLean: boolean
  ): number {
    const isSenior = age != null && age >= 50;
    let ibwKg = heightCm - 105;

    if (isSenior) {
      ibwKg = heightCm - 100;
    } else if (gender === 'female') {
      ibwKg = heightCm - 107;
    }

    if (isLean && weightKg != null && weightKg > 0) {
      return weightKg;
    }

    return ibwKg;
  }

  private getAutoBmr(ibwKg: number, gender: string, age: number | null): number {
    const isSenior = age != null && age >= 50;
    if (!isSenior && gender === 'female') {
      return ibwKg * 22.5;
    }

    return ibwKg * 24;
  }

  private normalizeTargetCaloriesForGoal(
    factor: number,
    ibwLb: number
  ): { factor: number; calories: number } {
    const goalConfig = this.targetGoalOptions.find((g) => g.value === this.bodyMetrics.targetGoal);
    if (!goalConfig) {
      return {
        factor,
        calories: ibwLb > 0 ? ibwLb * factor : 0
      };
    }

    const clampedFactor = Math.min(goalConfig.max, Math.max(goalConfig.min, factor));
    return {
      factor: clampedFactor,
      calories: ibwLb > 0 ? ibwLb * clampedFactor : 0
    };
  }

  private inferBodyMetricsManualOverride(source: any): boolean {
    if (!source) return false;
    if (typeof source.manualOverride === 'boolean') {
      return source.manualOverride;
    }

    const heightCm = this.toNumberOrNull(source.heightCm);
    const currentWeightKg = this.toNumberOrNull(source.currentWeightKg);
    const age = this.toNumberOrNull(source.age);
    const gender = String(source.gender || '').toLowerCase();
    const isLean = Boolean(source.isLean);
    const targetGoal = this.targetGoalReverseMap[source.targetGoal] ?? source.targetGoal ?? this.bodyMetrics.targetGoal;
    const proteinRda = this.toNumberOrNull(source.proteinRda);
    const carbFactor = this.toNumberOrNull(source.carbFactor);
    const targetCalorieFactor = this.toNumberOrNull(source.targetCalorieFactor);
    const savedTargetCalories = this.toNumberOrNull(source.targetCalories);
    const savedProteinGrams = this.toNumberOrNull(source.proteinGrams);
    const savedCarbsGrams = this.toNumberOrNull(source.carbsGrams);
    const savedFatsGrams = this.toNumberOrNull(source.fatsGrams);

    if (
      heightCm == null ||
      currentWeightKg == null ||
      age == null ||
      !gender ||
      proteinRda == null ||
      carbFactor == null ||
      targetCalorieFactor == null
    ) {
      return false;
    }

    const ibwKg = this.getAutoIbwKg(heightCm, gender, age, currentWeightKg, isLean);
    const ibwLb = ibwKg * 2.20462;
    const goalConfig = this.targetGoalOptions.find((g) => g.value === targetGoal);
    const normalizedFactor = goalConfig
      ? Math.min(goalConfig.max, Math.max(goalConfig.min, targetCalorieFactor))
      : targetCalorieFactor;
    const autoTargetCalories = ibwLb > 0 ? ibwLb * normalizedFactor : 0;
    const autoProteinGrams = ibwKg * proteinRda;
    const autoCarbsGrams = ibwKg * carbFactor;
    const autoFatsGrams = autoTargetCalories
      ? Math.max(0, (autoTargetCalories - (autoProteinGrams * 4 + autoCarbsGrams * 4)) / 9)
      : 0;

    return (
      this.hasMeaningfulDifference(savedTargetCalories, autoTargetCalories, 1) ||
      this.hasMeaningfulDifference(savedProteinGrams, autoProteinGrams, 1) ||
      this.hasMeaningfulDifference(savedCarbsGrams, autoCarbsGrams, 1) ||
      this.hasMeaningfulDifference(savedFatsGrams, autoFatsGrams, 1)
    );
  }

  private hasMeaningfulDifference(
    current: number | null,
    expected: number | null,
    tolerance: number
  ): boolean {
    if (current == null || expected == null) return false;
    return Math.abs(current - expected) > tolerance;
  }

  private toNumberOrNull(value: any): number | null {
    const num = Number(value);
    return Number.isFinite(num) ? num : null;
  }

  constructor(
    private route: ActivatedRoute,
    private memberApi: MemberApiService,
    private billingApi: BillingApiService,
    private cdr: ChangeDetectorRef,
    private checkinApi : CheckinApiService,
    private fb : FormBuilder,
    private workoutApi: WorkoutApiService,
    private router: Router,
    private dietApi: DietApiService,
    private dailyCheckinApi: DailyCheckinApiService,
    private progressCheckinApi: ProgressCheckinApiService,
    private photoApi : ProgressCheckinPhotoApiService,
    private notificationApi: NotificationApiService
  ) {

    Chart.register(...registerables);
  }

  checkinForm = this.fb.group({
  checkInDate: [''],
  weight: [null],
  compliance: [5],
  energy: [5],
  notes: [''],
  measurements: this.fb.array([])
});

get measurements() {
  return this.checkinForm.get('measurements') as FormArray;
}

addMeasurement() {
  this.measurements.push(
    this.fb.group({
      name: [''],
      value: [null]
    })
  );
}

removeMeasurement(index: number) {
  this.measurements.removeAt(index);
}
  ngOnInit() {
  const memberId = this.route.snapshot.paramMap.get('memberId');

  if (memberId) {
    this.loadMember(memberId);
  } else {
    this.error = 'Invalid member id';
    this.loading = false;
  }
}

  loadMember(id: string) {
  this.memberApi.getMemberById(id).subscribe({
    next: (res: any) => {
      this.member = res;
      this.initializeBodyMetrics();
      this.loadSubscriptionOverride();
      this.loading = false;
      this.loadSubscription();
      this.loadCheckins();
      this.loadWorkout();
      this.loadAllWorkoutPlans();
      this.loadDiet();
      this.loadProgressCheckins();
    },
    error: () => {
      this.error = 'Failed to load member';
      this.loading = false;
    }
  });
}

loadCheckins() {
  this.checkinApi.getCheckins(this.member.id).subscribe({
    next: (res: any[]) => {
      this.checkins = [...(res || [])];
      this.checkinsLoading = false;

      // 🔥 load photos per check-in
      this.checkins.forEach(c => {
        this.loadCheckinPhotos(c.id);
      });

    },
    error: () => {
      this.checkinsLoading = false;
    }
  });
}



loadSubscription() {
  this.billingApi.getSubscription(this.member.id).subscribe({
    next: (res: any[]) => {

      // API returns array → take first
      this.subscriptionHistory = Array.isArray(res) ? res : [];
      this.subscription = this.subscriptionHistory.length ? this.subscriptionHistory[0] : null;
      const originalStartDate = this.getOriginalSubscriptionStartDate();
      this.overrideActiveSince = this.getMemberCreatedDate() || this.normalizeDateInput(originalStartDate || '');
      if (!this.overrideRenewalDate && this.subscription?.endDate) {
        this.overrideRenewalDate = this.normalizeDateInput(this.subscription.endDate);
      }

      this.subscriptionLoading = false;
      this.loadPayments();
    },
    error: () => {
      this.subscriptionLoading = false;
    }
  });
}

get displayedActiveSince(): string {
  return this.getMemberCreatedDate() || this.getOriginalSubscriptionStartDate() || this.subscription?.startDate || '-';
}

get displayedRenewalDate(): string {
  return this.overrideRenewalDate || this.subscription?.endDate || '-';
}

get displayedCurrentPlan(): string {
  const planName = String(this.subscription?.planName || '').trim();
  if (planName) return planName;

  const cycle = String(this.overrideCycle || this.subscription?.cycle || '').toUpperCase();
  if ((this.overrideActiveSince || this.overrideRenewalDate) && cycle) {
    return this.getCycleLabel(cycle);
  }

  return 'No Plan';
}

get renewalDaysRemaining(): number | null {
  if (!this.displayedRenewalDate || this.displayedRenewalDate === '-') return null;

  const renewal = new Date(`${this.displayedRenewalDate.slice(0, 10)}T00:00:00`);
  if (Number.isNaN(renewal.getTime())) return null;

  const now = new Date();
  const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
  const diffMs = renewal.getTime() - today.getTime();

  return Math.ceil(diffMs / (1000 * 60 * 60 * 24));
}

get renewalDaysRemainingLabel(): string {
  const days = this.renewalDaysRemaining;
  if (days == null) return '-';
  if (days < 0) return `${Math.abs(days)} day(s) overdue`;
  if (days === 0) return 'Due today';
  return `${days} day(s) left`;
}

get memberExpiringSoon(): boolean {
  const days = this.renewalDaysRemaining;
  return days != null && days >= 0 && days <= this.expirySoonDays;
}

get memberExpired(): boolean {
  const days = this.renewalDaysRemaining;
  return days != null && days < 0;
}

onOverrideActiveSinceChange() {
  if (this.autoCalculateRenewal) {
    this.applyCycleToRenewal();
  }
}

onOverrideCycleChange() {
  if (this.autoCalculateRenewal) {
    this.applyCycleToRenewal();
  }
}

saveSubscriptionOverride() {
  this.overrideMessage = null;

  const activeSince = this.getMemberCreatedDate() || this.overrideActiveSince;
  this.overrideActiveSince = activeSince;

  if (!activeSince) {
    this.overrideMessage = 'Member creation date is required';
    return;
  }

  if (this.autoCalculateRenewal) {
    this.applyCycleToRenewal();
  }

  if (!this.overrideRenewalDate) {
    this.overrideMessage = 'Renewal Date is required';
    return;
  }

  const payload = {
    activeSince,
    renewalDate: this.overrideRenewalDate,
    cycle: this.overrideCycle,
    autoCalculate: this.autoCalculateRenewal
  };

  localStorage.setItem(this.getOverrideStorageKey(), JSON.stringify(payload));
  this.overrideMessage = 'Subscription override saved';
}

clearSubscriptionOverride() {
  localStorage.removeItem(this.getOverrideStorageKey());
  this.overrideMessage = 'Subscription override cleared';
  this.overrideCycle = 'MONTHLY';
  this.autoCalculateRenewal = true;
  this.overrideActiveSince = this.getMemberCreatedDate();
  this.overrideRenewalDate = this.subscription?.endDate
    ? this.normalizeDateInput(this.subscription.endDate)
    : '';
}

private applyCycleToRenewal() {
  if (!this.overrideActiveSince) return;

  const cycleMonths =
    this.overrideCycle === 'MONTHLY'
      ? 1
      : this.overrideCycle === 'QUARTERLY'
      ? 3
      : 12;

  const start = new Date(`${this.overrideActiveSince}T00:00:00`);
  if (Number.isNaN(start.getTime())) return;
  start.setMonth(start.getMonth() + cycleMonths);
  this.overrideRenewalDate = start.toISOString().slice(0, 10);
}

private getCycleLabel(cycle: string): string {
  if (cycle === 'QUARTERLY') return 'Quarterly';
  if (cycle === 'YEARLY') return 'Yearly';
  return 'Monthly';
}

private getOverrideStorageKey() {
  return `member_subscription_override_${this.member?.id}`;
}

private loadSubscriptionOverride() {
  const raw = localStorage.getItem(this.getOverrideStorageKey());
  if (!raw) return;

  try {
    const parsed = JSON.parse(raw);
    this.overrideActiveSince = this.getMemberCreatedDate();
    this.overrideRenewalDate = parsed.renewalDate || '';
    this.overrideCycle = parsed.cycle || 'MONTHLY';
    this.autoCalculateRenewal = parsed.autoCalculate ?? true;
  } catch {
    // ignore invalid local storage payload
  }
}

private normalizeDateInput(value: string): string {
  const parsed = new Date(value);
  if (Number.isNaN(parsed.getTime())) return '';
  return parsed.toISOString().slice(0, 10);
}

private getMemberCreatedDate(): string {
  return this.normalizeDateInput(this.member?.createdAt || this.member?.activeSince || '');
}

  loadPayments() {
    this.paymentsLoading = true;
    this.billingApi.getPaymentHistory(this.member.id).subscribe({
      next: (res: any[]) => {
        this.payments = [...(res || [])];
        this.initializeConfirmPaymentDates();
        this.calculatePaymentSummary();
        this.paymentsLoading = false;
        this.cdr.detectChanges();
    },
    error: () => {
      this.paymentsLoading = false;
    }
  });
}

startManualPayment() {

  if (!this.paymentAmount) return;

  this.paymentActionLoading = true;
  this.paymentActionError = null;

  this.billingApi
    .startManualPayment(this.member.id, this.paymentAmount)
    .subscribe({
      next: () => {
        this.paymentActionLoading = false;
        this.paymentAmount = null;

        // refresh payments
        this.paymentsLoading = true;
        this.loadPayments();
      },
      error: () => {
        this.paymentActionLoading = false;
        this.paymentActionError = 'Failed to start payment';
      }
    });
}

confirmPayment(paymentId: string) {

  this.billingApi.confirmPayment(
    paymentId,
    this.confirmPaymentDates[paymentId] || this.getTodayDateInput()
  ).subscribe({
    next: () => {
      // refresh everything
      this.subscriptionLoading = true;
      this.paymentsLoading = true;

      this.loadSubscription();
    }
  });
}

trackByPaymentId(index: number, payment: any): string {
  return payment.id;
}

startOnlinePayment() {
  if (!this.onlineAmount) return;

  this.onlinePaymentLoading = true;
  this.onlinePaymentError = null;
  this.onlinePaymentResult = null;

  this.billingApi
    .startOnlinePayment(this.member.id, this.onlineAmount)
    .subscribe({
      next: (res: any) => {
        this.onlinePaymentLoading = false;
        this.onlinePaymentResult = res;
        this.onlineAmount = null;

        this.openRazorpayCheckout(res);
      },
      error: () => {
        this.onlinePaymentLoading = false;
        this.onlinePaymentError = 'Failed to start online payment';
      }
    });
}


openRazorpayCheckout(order: any) {
  const options = {
    key: order.razorpayKeyId,
    amount: order.amount, // paise
    currency: order.currency,
    name: 'Fitness Coach',
    description: 'Subscription Payment',
    order_id: order.razorpayOrderId,

    handler: () => {
      // Payment success will be handled by webhook
      // Just inform user & refresh later
      alert('Payment completed. Updating status shortly.');

      // Optional soft refresh
      setTimeout(() => {
        this.paymentsLoading = true;
        this.subscriptionLoading = true;
        this.loadPayments();
        this.loadSubscription();
      }, 3000);
    },

    prefill: {
      email: this.member.email,
      contact: this.member.phone
    },

    theme: {
      color: '#2563eb'
    }
  };

  const rzp = new Razorpay(options);
  rzp.open();
}

calculatePaymentSummary() {
  this.totalPaid = this.payments
    .filter(p => p.status === 'SUCCESS')
    .reduce((sum, p) => sum + p.amount, 0);

  this.totalPending = this.payments
    .filter(p => p.status === 'PENDING')
    .reduce((sum, p) => sum + p.amount, 0);
}

submitCheckin() {

  if (this.checkinForm.invalid) return;

  this.checkinSubmitting = true;
  this.checkinError = null;

  const payload = {
    memberId: this.member.id,
    ...this.checkinForm.value
  };

  const request$ = this.editingCheckinId
    ? this.checkinApi.updateCheckin(this.editingCheckinId, payload)
    : this.checkinApi.createCheckin(payload);

  request$.subscribe({
    next: () => {
      this.checkinSubmitting = false;

      // reset edit mode
      this.editingCheckinId = null;

      // reset form
      this.checkinForm.reset({
        compliance: 5,
        energy: 5
      });
      this.measurements.clear();

      // refresh list
      this.checkinsLoading = true;
      // this.loadCheckins();
    },
    error: () => {
      this.checkinSubmitting = false;
      this.checkinError = 'Failed to save check-in';
    }
  });
}


editCheckin(c: any) {

  this.editingCheckinId = c.id;

  // reset measurements first
  this.measurements.clear();

  // patch main fields
  this.checkinForm.patchValue({
    checkInDate: c.checkInDate,
    weight: c.weight,
    compliance: c.compliance,
    energy: c.energy,
    notes: c.notes
  });

  // patch measurements
  if (c.measurements?.length) {
    c.measurements.forEach((m: any) => {
      this.measurements.push(
        this.fb.group({
          name: [m.name],
          value: [m.value]
        })
      );
    });
  }

  // scroll to form (optional UX polish)
  window.scrollTo({ top: 0, behavior: 'smooth' });
}

cancelEdit() {
  this.editingCheckinId = null;
  this.checkinForm.reset({
    compliance: 5,
    energy: 5
  });
  this.measurements.clear();
}

loadCheckinPhotos(checkInId: string) {
  this.photoApi.list(checkInId).subscribe({
    next: res => {
      this.checkinPhotos[checkInId] = res || [];
    },
    error: () => {
      this.checkinPhotos[checkInId] = [];
    }
  });
}


// onPhotosSelected(checkinId: string, event: Event) {
//   const input = event.target as HTMLInputElement;
//   if (!input.files || input.files.length === 0) return;

//   const files = Array.from(input.files);
//   this.uploadingPhotosMap[checkinId] = true;

//   this.checkinApi.uploadCheckinPhotos(checkinId, files).subscribe({
//     next: () => {
//       this.uploadingPhotosMap[checkinId] = false;

//       // 🔄 refresh photos for this check-in only
//       this.loadCheckinPhotos(checkinId);

//       // reset input
//       input.value = '';
//     },
//     error: () => {
//       this.uploadingPhotosMap[checkinId] = false;
//       alert('Failed to upload photos');
//     }
//   });
// }

getCheckinPhotoUrl(fileName: string): string {
  return this.photoApi.getPhotoUrl(fileName);
}

getSortedCheckins() {
  return [...this.checkins].sort(
    (a, b) => new Date(a.checkInDate).getTime() - new Date(b.checkInDate).getTime()
  );
}

renderCharts() {
  const sorted = this.getSortedCheckins();

  if (sorted.length === 0) return;

  const labels = sorted.map(c => c.checkInDate);
  const weights = sorted.map(c => c.weight);
  const compliance = sorted.map(c => c.compliance);
  const energy = sorted.map(c => c.energy);

  // Weight Chart
  new Chart('weightChart', {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Weight (kg)',
          data: weights,
          borderColor: '#2563eb',
          tension: 0.3
        }
      ]
    }
  });

  // Compliance & Energy Chart
  new Chart('scoreChart', {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Compliance',
          data: compliance,
          borderColor: '#16a34a',
          tension: 0.3
        },
        {
          label: 'Energy',
          data: energy,
          borderColor: '#f97316',
          tension: 0.3
        }
      ]
    }
  });
}

renderWeightChart() {
  if (this.progressCheckins.length === 0) return;

  const canvas = document.getElementById('weightChart') as HTMLCanvasElement | null;
  if (!canvas) return;

  const existing = Chart.getChart(canvas);
  if (existing) {
    existing.destroy();
  }

  const sorted = [...this.progressCheckins].sort(
    (a, b) =>
      this.getCheckinDateValue(a.submittedAt) -
      this.getCheckinDateValue(b.submittedAt)
  );

  const labels = sorted.map(c => this.formatProgressCheckinDate(c.submittedAt));
  const weights = sorted.map(c => c.weight);

  new Chart(canvas, {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: 'Weight (kg)',
          data: weights,
          borderWidth: 2,
          tension: 0.3
        }
      ]
    }
  });
}


loadWorkout() {
  this.workoutLoading = true;

  this.workoutApi.getWorkoutPlan(this.member.id).subscribe({
    next: res => {
      // Case 1: backend returns list
      if (Array.isArray(res)) {
        this.activeWorkoutPlan = res.find(p => p.status === 'ACTIVE') || null;
        this.pastWorkoutPlans = res.filter(p => p.status !== 'ACTIVE');
      }
      // Case 2: backend returns single active plan
      else {
        this.activeWorkoutPlan = res;
        this.pastWorkoutPlans = [];
      }
      this.activeWorkoutPlan = this.buildWorkoutPlanViewModel(this.activeWorkoutPlan);

      this.workoutLoading = false;
      this.loadWeeklyConsistency();
    },
    error: () => {
      this.activeWorkoutPlan = null;
      this.pastWorkoutPlans = [];
      this.currentWeekConsistency = null;
      this.previousWeekConsistency = null;
      this.workoutLoading = false;
    }
  });
}

loadWeeklyConsistency() {
  if (!this.member?.id) return;

  const today = this.startOfDay(new Date());
  const currentWeekStart = this.getWeekStart(today);
  const previousWeekStart = this.addDays(currentWeekStart, -7);
  const previousWeekEnd = this.addDays(currentWeekStart, -1);
  const ranges = [
    { start: currentWeekStart, end: today },
    { start: previousWeekStart, end: previousWeekEnd }
  ];
  const monthKeys = Array.from(new Set(
    ranges.flatMap((range) => this.getMonthKeysBetween(range.start, range.end))
  ));

  this.weeklyConsistencyLoading = true;
  this.weeklyConsistencyError = null;

  forkJoin(monthKeys.map((month) => this.dailyCheckinApi.getMemberCalendar(this.member.id, month)))
    .subscribe({
      next: (calendars) => {
        const days = calendars.flatMap((calendar) => calendar.days || []);
        this.currentWeekConsistency = this.buildWeeklyConsistencyScore(
          'Current week',
          currentWeekStart,
          today,
          days
        );
        this.previousWeekConsistency = this.buildWeeklyConsistencyScore(
          'Previous week',
          previousWeekStart,
          previousWeekEnd,
          days
        );
        this.weeklyConsistencyTrend = this.getWeeklyConsistencyTrend(
          this.currentWeekConsistency?.score,
          this.previousWeekConsistency?.score
        );
        this.weeklyScoreDifference = this.getWeeklyScoreDifference(
          this.currentWeekConsistency?.score,
          this.previousWeekConsistency?.score
        );
        this.syncGeneratedCoachFeedback();
        this.weeklyConsistencyLoading = false;
      },
      error: () => {
        this.currentWeekConsistency = null;
        this.previousWeekConsistency = null;
        this.weeklyConsistencyLoading = false;
        this.weeklyConsistencyError = 'Failed to load weekly consistency';
      }
    });
}

private buildWeeklyConsistencyScore(
  label: string,
  start: Date,
  end: Date,
  days: DailyCheckinDay[]
): WeeklyConsistencyScore {
  const dateKeys = this.getDateKeysBetween(start, end);
  const entriesByDate = new Map(days.map((day) => [day.checkInDate, day]));
  const weekEntries = dateKeys.map((date) => entriesByDate.get(date) || null);
  const completedWorkouts = weekEntries.filter((entry) => Boolean(entry?.exerciseDone)).length;
  const totalSteps = weekEntries.reduce((sum, entry) => sum + Math.max(0, Number(entry?.stepsCount || 0)), 0);
  const averageDailySteps = dateKeys.length ? totalSteps / dateKeys.length : 0;
  const plannedWorkouts = this.getPlannedWorkoutsPerWeek();
  const stepTarget = Math.max(0, Number(this.activeWorkoutPlan?.targetStepsCount || 0));
  const workoutCompliance = this.calculateWorkoutCompliance(completedWorkouts, plannedWorkouts);
  const stepsCompliance = this.calculateStepsCompliance(averageDailySteps, stepTarget);
  const score = this.calculateWeeklyScore(workoutCompliance, stepsCompliance);
  const rating = this.getScoreRating(score);

  return {
    label,
    rangeLabel: `${this.formatShortDate(start)} - ${this.formatShortDate(end)}`,
    completedWorkouts,
    plannedWorkouts,
    averageDailySteps: this.roundTo(averageDailySteps, 0),
    stepTarget,
    workoutCompliance: this.roundTo(workoutCompliance, 1),
    stepsCompliance: this.roundTo(stepsCompliance, 1),
    score: this.roundTo(score, 0),
    rating: rating.label,
    ratingColor: rating.color,
    ratingClass: rating.className
  };
}

private getPlannedWorkoutsPerWeek(): number {
  return Array.isArray(this.activeWorkoutPlan?.days) ? this.activeWorkoutPlan.days.length : 0;
}

calculateWorkoutCompliance(completedWorkouts: number, plannedWorkouts: number): number {
  return plannedWorkouts > 0
    ? Math.min(100, (Math.max(0, completedWorkouts) / plannedWorkouts) * 100)
    : 0;
}

calculateStepsCompliance(averageDailySteps: number, stepTarget: number): number {
  return stepTarget > 0
    ? Math.min(100, (Math.max(0, averageDailySteps) / stepTarget) * 100)
    : 0;
}

calculateWeeklyScore(workoutCompliance: number, stepsCompliance: number): number {
  return (workoutCompliance * 0.7) + (stepsCompliance * 0.3);
}

getScoreRating(score: number | null | undefined): WeeklyScoreRating {
  const value = Number(score || 0);
  if (value >= 90) return { label: 'Excellent', color: '#16a34a', className: 'excellent' };
  if (value >= 80) return { label: 'Good', color: '#2563eb', className: 'good' };
  if (value >= 70) return { label: 'Average', color: '#f97316', className: 'average' };
  return { label: 'Needs Improvement', color: '#dc2626', className: 'needs-improvement' };
}

getTrend(
  currentScore: number | null | undefined,
  previousScore: number | null | undefined
): WeeklyConsistencyTrend {
  if (currentScore == null || previousScore == null) return 'stable';
  const difference = currentScore - previousScore;
  if (difference >= 5) return 'improving';
  if (difference <= -5) return 'declining';
  return 'stable';
}

getWeeklyConsistencyTrendLabel(): string {
  if (this.weeklyConsistencyTrend === 'improving') return 'Improving';
  if (this.weeklyConsistencyTrend === 'declining') return 'Declining';
  return 'Stable';
}

getWeeklyConsistencyTrendSymbol(): string {
  if (this.weeklyConsistencyTrend === 'improving') return '↑';
  if (this.weeklyConsistencyTrend === 'declining') return '↓';
  return '→';
}

private getWeeklyConsistencyTrend(
  currentScore: number | null | undefined,
  previousScore: number | null | undefined
): WeeklyConsistencyTrend {
  return this.getTrend(currentScore, previousScore);
}

getWeeklyTrendDifferenceLabel(): string {
  if (this.weeklyConsistencyTrend === 'stable') return 'Stable';
  const prefix = this.weeklyScoreDifference > 0 ? '+' : '';
  return `${prefix}${this.weeklyScoreDifference} points`;
}

generateNextWeekFocus(week: WeeklyConsistencyScore | null = this.currentWeekConsistency): string {
  if (!week) return 'Review consistency once this week has check-ins.';

  if (week.workoutCompliance < 80 && week.stepsCompliance < 80) {
    return 'Complete workouts and hit step target more consistently.';
  }

  if (week.workoutCompliance >= 90 && week.stepsCompliance >= 90) {
    return 'Maintain the same consistency next week.';
  }

  if (week.workoutCompliance < week.stepsCompliance) {
    return 'Complete all planned workouts.';
  }

  if (week.stepsCompliance < week.workoutCompliance) {
    return 'Improve daily step consistency.';
  }

  return 'Keep workouts and steps consistent next week.';
}

getMissedWorkouts(week: WeeklyConsistencyScore | null = this.currentWeekConsistency): number {
  if (!week) return 0;
  return Math.max(0, week.plannedWorkouts - week.completedWorkouts);
}

generateCoachFeedback(
  current: WeeklyConsistencyScore | null = this.currentWeekConsistency,
  previous: WeeklyConsistencyScore | null = this.previousWeekConsistency,
  trend: WeeklyConsistencyTrend = this.weeklyConsistencyTrend
): string {
  if (!current) return '';

  const messages: string[] = [];

  if (current.score >= 90) {
    messages.push('Excellent work this week! You stayed highly consistent with your workouts and steps. Keep maintaining this momentum next week. 🔥');
  } else if (current.score >= 80) {
    messages.push('Good work this week 👍 You are staying consistent overall. The main focus next week is to improve the weaker area and push the score above 90.');
  } else if (current.score >= 70) {
    messages.push('Decent effort this week. You are moving in the right direction, but there is room to improve consistency. Let’s focus on completing planned workouts and hitting steps more regularly.');
  } else {
    messages.push('Consistency was below target this week. Before changing the plan, let’s focus on completing workouts and improving daily activity. Small actions done consistently will drive results.');
  }

  if (previous) {
    if (trend === 'declining') {
      messages.push('Your score has dropped compared to last week, so let’s identify what affected consistency and improve next week.');
    } else if (trend === 'improving') {
      messages.push('Great improvement compared to last week. Keep building on this progress.');
    }
  }

  if (current.workoutCompliance < 80) {
    messages.push('Priority: Complete all scheduled workouts.');
  }

  if (current.stepsCompliance < 80) {
    messages.push('Priority: Improve daily step count consistency.');
  }

  return messages.join(' ');
}

getCoachAction(score: number | null | undefined = this.currentWeekConsistency?.score): { label: string; className: string } {
  const value = Number(score || 0);
  if (value >= 85) return { label: 'No action needed', className: 'no-action' };
  if (value >= 70) return { label: 'Send encouragement', className: 'encouragement' };
  return { label: 'Follow-up recommended', className: 'follow-up' };
}

onWeeklyFeedbackChanged(): void {
  this.weeklyFeedbackManuallyEdited = true;
}

regenerateWeeklyFeedback(): void {
  this.weeklyManualFeedback = this.generateCoachFeedback();
  this.weeklyFeedbackManuallyEdited = false;
}

private getWeeklyScoreDifference(
  currentScore: number | null | undefined,
  previousScore: number | null | undefined
): number {
  if (currentScore == null || previousScore == null) return 0;
  return this.roundTo(currentScore - previousScore, 0);
}

private syncGeneratedCoachFeedback(): void {
  if (this.weeklyFeedbackManuallyEdited) return;
  this.weeklyManualFeedback = this.generateCoachFeedback();
}

private getWeekStart(value: Date): Date {
  const date = this.startOfDay(value);
  const day = date.getDay();
  const mondayOffset = day === 0 ? -6 : 1 - day;
  return this.addDays(date, mondayOffset);
}

private startOfDay(value: Date): Date {
  return new Date(value.getFullYear(), value.getMonth(), value.getDate());
}

private addDays(value: Date, days: number): Date {
  const date = new Date(value);
  date.setDate(date.getDate() + days);
  return date;
}

private getMonthKeysBetween(start: Date, end: Date): string[] {
  const keys: string[] = [];
  const cursor = new Date(start.getFullYear(), start.getMonth(), 1);
  const last = new Date(end.getFullYear(), end.getMonth(), 1);

  while (cursor <= last) {
    keys.push(this.getMonthKey(cursor));
    cursor.setMonth(cursor.getMonth() + 1);
  }

  return keys;
}

private getDateKeysBetween(start: Date, end: Date): string[] {
  const keys: string[] = [];
  let cursor = this.startOfDay(start);
  const last = this.startOfDay(end);

  while (cursor <= last) {
    keys.push(this.getDateKey(cursor));
    cursor = this.addDays(cursor, 1);
  }

  return keys;
}

private getMonthKey(value: Date): string {
  const year = value.getFullYear();
  const month = String(value.getMonth() + 1).padStart(2, '0');
  return `${year}-${month}`;
}

private getDateKey(value: Date): string {
  const month = String(value.getMonth() + 1).padStart(2, '0');
  const day = String(value.getDate()).padStart(2, '0');
  return `${value.getFullYear()}-${month}-${day}`;
}

private formatShortDate(value: Date): string {
  return new Intl.DateTimeFormat('en-IN', {
    day: '2-digit',
    month: 'short'
  }).format(value);
}


loadAllWorkoutPlans() {
  this.workoutApi.getAllWorkoutPlans().subscribe({
    next: res => {
      this.allWorkoutPlans = res || [];
    }
  });
}

assignWorkoutPlan() {

  if (!this.selectedWorkoutPlanId) return;

  this.assigningWorkout = true;
  this.assignWorkoutError = null;

  this.workoutApi
    .assignWorkoutPlan(this.selectedWorkoutPlanId, this.member.id)
    .subscribe({
      next: () => {
        this.assigningWorkout = false;
        this.selectedWorkoutPlanId = null;

        // 🔄 refresh workout plan
        this.loadWorkout();
      },
      error: () => {
        this.assigningWorkout = false;
        this.assignWorkoutError = 'Failed to assign workout plan';
      }
    });
}

goToCreateWorkout() {
  console.log('Navigating to create workout', this.member.id);

  this.router.navigate([
    '/members',
    this.member.id,
    'workouts',
    'create'
  ]);
}

loadDiet() {
  this.dietLoading = true;

  this.dietApi.getDietPlanByMember(this.member.id).subscribe({
    next: res => {
      this.dietPlan = res;
      this.refreshDietPlanViewModel();
      this.loadSavedDietWhatsAppMessage();
      this.dietLoading = false;
    },
    error: () => {
      this.dietPlan = null;
      this.refreshDietPlanViewModel();
      this.loadSavedDietWhatsAppMessage();
      this.dietLoading = false;
    }
  });
}

private loadSavedDietWhatsAppMessage(): void {
  if (!this.member?.id) return;

  const saved = localStorage.getItem(this.getDietWhatsAppStorageKey(this.member.id));
  this.dietWhatsAppMessageText = saved || this.getDefaultDietWhatsAppMessage();
}

saveDietWhatsAppMessage(): void {
  if (!this.member?.id) return;

  localStorage.setItem(
    this.getDietWhatsAppStorageKey(this.member.id),
    this.dietWhatsAppMessageText.trim()
  );
  this.dietWhatsAppStatus = 'Diet message saved.';
}

generateDietWhatsAppMessage(): void {
  this.dietWhatsAppMessageText = this.getDefaultDietWhatsAppMessage();
  this.dietWhatsAppStatus = 'Diet message generated from current plan.';
}

sendDietPlanWhatsApp(): void {
  if (!this.member?.id || this.sendingDietWhatsApp) return;

  const recipient = this.getMemberWhatsAppRecipient();
  if (!recipient) {
    this.dietWhatsAppStatus = 'Add a phone number for this member before sending WhatsApp updates.';
    return;
  }

  const message = this.dietWhatsAppMessageText.trim();
  if (!message) {
    this.dietWhatsAppStatus = 'Add diet message text before sending.';
    return;
  }

  this.saveDietWhatsAppMessage();
  this.sendingDietWhatsApp = true;
  this.dietWhatsAppStatus = 'Sending diet plan on WhatsApp...';

  this.notificationApi.send({
    memberId: this.member.id,
    channel: 'WHATSAPP',
    type: 'DIET_PLAN',
    recipient,
    message,
    templateParameters: [message]
  }).subscribe({
    next: (res) => {
      this.sendingDietWhatsApp = false;
      this.dietWhatsAppStatus = res.status === 'SENT'
        ? 'Diet plan sent on WhatsApp.'
        : 'Diet plan send failed. Check notification history for Meta error details.';
    },
    error: () => {
      this.sendingDietWhatsApp = false;
      this.dietWhatsAppStatus = 'Unable to send diet plan on WhatsApp.';
    }
  });
}

private getDietWhatsAppStorageKey(memberId: string): string {
  return `member:${memberId}:diet-whatsapp-message`;
}

private getDefaultDietWhatsAppMessage(): string {
  const name = this.member?.fullName || 'Member';
  const sections: string[] = [
    `🥗 Diet Plan for ${name}`,
    `💧 Hydration First\n\nDrink plenty of water throughout the day 🚰\n\nAim for at least 4 litres daily`
  ];

  const mealSections = this.groupedDietMeals
    .filter((meal) => meal.items?.length)
    .map((meal) => this.buildDietWhatsAppMealSection(meal));

  if (mealSections.length) {
    sections.push(...mealSections);
  } else if (this.dietPlan?.notes?.trim()) {
    sections.push(this.dietPlan.notes.trim());
  }

  sections.push(this.buildDietWhatsAppNutritionSection());
  sections.push(this.buildDietWhatsAppFinalNotes());
  sections.push(this.buildDietWhatsAppQuickRules());

  return sections.filter(Boolean).join('\n\n');
}

private buildDietWhatsAppMealSection(meal: DietMealViewModel): string {
  const mealName = String(meal.mealName || 'Meal').trim();
  const items = meal.items || [];
  const lines: string[] = [];

  for (const item of items) {
    const primaryLine = this.formatDietWhatsAppFoodLine(item.displayFoodName || item.foodName, item);
    if (primaryLine) {
      lines.push(primaryLine);
    }

    for (const alternative of item.optionalAlternatives || []) {
      const alternativeLine = this.formatDietWhatsAppFoodLine(alternative, item);
      if (alternativeLine) {
        lines.push(alternativeLine);
      }
    }
  }

  const hasAlternatives = items.some((item) => item.optionalAlternatives?.length);
  const intro = hasAlternatives ? '\n\nChoose one option 👇\n' : '';

  return `${this.getDietMealIcon(mealName)} ${mealName}${intro}\n${lines.join('\n')}`.trim();
}

private formatDietWhatsAppFoodLine(foodName: string, item: any): string {
  const food = String(foodName || '').trim();
  if (!food) return '';

  const quantity = this.formatDietWhatsAppQuantity(item);
  return `${this.getDietFoodIcon(food)} ${quantity ? `${quantity} ` : ''}${food}`.trim();
}

private formatDietWhatsAppQuantity(item: any): string {
  const quantity = item?.quantity ?? '';
  const unit = String(item?.unit || '').trim();

  if (quantity === '' || quantity == null) {
    return '';
  }

  return `${quantity}${unit}`.replace(/\s+/g, ' ').trim();
}

private buildDietWhatsAppNutritionSection(): string {
  const totals = this.dietPlanTotals;

  return [
    '📊 Daily Nutrition',
    '',
    `🔥 Calories: ${this.formatDietMacro(totals.calories, 'kcal')}`,
    `🥩 Protein: ${this.formatDietMacro(totals.protein, 'g')}`,
    `🍚 Carbohydrates: ${this.formatDietMacro(totals.carbs, 'g')}`,
    `🥜 Fats: ${this.formatDietMacro(totals.fats, 'g')}`
  ].join('\n');
}

private buildDietWhatsAppFinalNotes(): string {
  return [
    '💬 Final Notes',
    '',
    '✨ Include a protein source in every main meal',
    '✨ Maintain portion accuracy',
    '✨ Hit daily step target consistently',
    '✨ Recover well 💪',
    '',
    '👉 Consistency > Perfection 🚀'
  ].join('\n');
}

private buildDietWhatsAppQuickRules(): string {
  return [
    '⚡ Quick Rules',
    '',
    '✔️ 60g Rice = 60g Wheat Flour = 60g Daliya',
    '✔️ 2 Brown Bread ≈ 60g Rice',
    '✔️ 50g Dal ≈ 50g Rajma ≈ 50g Chole',
    '✔️ 100g Chicken Breast ≈ 6 Egg Whites ≈ 50g Soya Chunks',
    '✔️ 100g Paneer ≈ 3 Whole Eggs',
    '✔️ Total Oil Intake ≈ 15g/day',
    '✔️ 1 Apple ≈ 1 Banana ≈ 100-120g Mango ≈ 150g Papaya ≈ 250-300g Watermelon ≈ 150g Pineapple'
  ].join('\n');
}

private formatDietMacro(value: number | null, suffix: string): string {
  if (value == null || !Number.isFinite(Number(value))) {
    return '-';
  }

  return `${value} ${suffix}`;
}

private getDietMealIcon(mealName: string): string {
  const value = mealName.toLowerCase();
  if (value.includes('pre')) return '☕';
  if (value.includes('breakfast')) return '🌅';
  if (value.includes('lunch')) return '🍛';
  if (value.includes('snack') || value.includes('evening')) return '☕';
  if (value.includes('dinner')) return '🌙';
  return '🥗';
}

private getDietFoodIcon(foodName: string): string {
  const value = foodName.toLowerCase();
  if (value.includes('coffee')) return '☕';
  if (value.includes('apple')) return '🍎';
  if (value.includes('banana')) return '🍌';
  if (value.includes('mango')) return '🥭';
  if (value.includes('pineapple')) return '🍍';
  if (value.includes('watermelon')) return '🍉';
  if (value.includes('egg')) return '🥚';
  if (value.includes('chicken')) return '🍗';
  if (value.includes('rice')) return '🍚';
  if (value.includes('roti') || value.includes('wheat') || value.includes('flour')) return '🫓';
  if (value.includes('dal') || value.includes('rajma') || value.includes('chole')) return '🥘';
  if (value.includes('curd') || value.includes('oats') || value.includes('poha') || value.includes('upma')) return '🥣';
  if (value.includes('paneer')) return '🧀';
  if (value.includes('spinach')) return '🥬';
  if (value.includes('vegetable')) return '🥗';
  if (value.includes('oil')) return '🫒';
  if (value.includes('almond') || value.includes('cashew') || value.includes('nut')) return '🌰';
  return '•';
}

goToCreateDiet() {
  console.log('Navigating to create diet', this.member.id);

  this.router.navigate([
    '/members',
    this.member.id,
    'diet',
    'create'
  ]);
}

exportWorkoutPlanToExcel() {
  const exportFile = this.buildWorkoutPlanExport();
  if (!exportFile) return;

  XLSX.writeFile(exportFile.workbook, exportFile.fileName);
}

private buildWorkoutPlanExport(): { workbook: any; fileName: string } | null {
  if (!this.activeWorkoutPlan) {
    alert('No active workout plan found to export.');
    return null;
  }

  if (typeof XLSX === 'undefined') {
    alert('Excel exporter not loaded. Please refresh and try again.');
    return null;
  }

  const dateLabel = new Intl.DateTimeFormat('en-GB').format(new Date());
  const videoCells: Array<{ rowIndex: number; colIndex: number; url: string }> = [];
  const rows: any[][] = [
    [`Exercise Plan for ${this.member?.fullName || 'Member'} (${dateLabel})`],
    [`Target Steps: ${this.activeWorkoutPlan?.targetStepsCount != null ? this.activeWorkoutPlan.targetStepsCount : '-'}`],
    [`Notes: ${this.activeWorkoutPlan?.notes?.trim() || '-'}`],
    ['Daily 10 mins General Warmup + 1-2 light sets of first exercise'],
    ['Section', 'Exercise', 'Sets', 'Reps', 'Video']
  ];

  this.activeWorkoutPlan.days?.forEach((day: any, dayIndex: number) => {
    if (dayIndex > 0) {
      rows.push(['', '', '', '', '']);
    }

    rows.push([day.dayName || `Day ${dayIndex + 1}`, '', '', '', '']);

    const groupedExercises = this.groupExercisesForExport(day.exercises || []);

    groupedExercises.forEach((exercise, exIndex) => {
      const repsValues = exercise.sets
        .map((s: any) => s?.reps)
        .filter((v: any) => v != null && v !== '');
      const uniqueReps = Array.from(new Set(repsValues));
      const numericSetNumbers = exercise.sets
        .map((s: any) => Number(s?.setNumber))
        .filter((n: number) => Number.isFinite(n) && n > 0);
      const derivedSetCount = numericSetNumbers.length
        ? Math.max(...numericSetNumbers)
        : exercise.sets.length;

      rows.push([
        exIndex + 1,
        exercise.name || '',
        derivedSetCount || '',
        uniqueReps.length === 1 ? uniqueReps[0] : uniqueReps.join(', '),
        exercise.videoUrl ? 'Open Video' : ''
      ]);

      if (exercise.videoUrl) {
        videoCells.push({
          rowIndex: rows.length - 1,
          colIndex: 4,
          url: exercise.videoUrl
        });
      }
    });
  });

  const ws = XLSX.utils.aoa_to_sheet(rows);

  videoCells.forEach(({ rowIndex, colIndex, url }) => {
    const cellRef = XLSX.utils.encode_cell({ r: rowIndex, c: colIndex });
    ws[cellRef] = {
      t: 's',
      v: 'Open Video',
      l: { Target: url, Tooltip: 'Open workout video' }
    };
  });

  ws['!merges'] = [
    { s: { r: 0, c: 0 }, e: { r: 0, c: 4 } },
    { s: { r: 1, c: 0 }, e: { r: 1, c: 4 } },
    { s: { r: 2, c: 0 }, e: { r: 2, c: 4 } }
  ];
  ws['!cols'] = [
    { wch: 16 },
    { wch: 36 },
    { wch: 10 },
    { wch: 14 },
    { wch: 54 }
  ];

  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, 'Sheet 1');
  const fileName = `Exercise-Plan-${(this.member?.fullName || 'Member').replace(/\s+/g, '-')}.xlsx`;
  return { workbook: wb, fileName };
}

private groupExercisesForExport(exercises: any[]): Array<{ name: string; videoUrl: string | null; sets: any[] }> {
  const grouped = new Map<string, { name: string; videoUrl: string | null; sets: any[] }>();

  (exercises || []).forEach((exercise: any) => {
    const name = (exercise?.name || '').trim();
    const videoUrl = this.getWorkoutVideoUrl(exercise);
    const key = `${name}__${videoUrl || ''}`;

    if (!grouped.has(key)) {
      grouped.set(key, { name, videoUrl, sets: [] });
    }

    const bucket = grouped.get(key)!;
    const sets = Array.isArray(exercise?.sets) ? exercise.sets : [];
    bucket.sets.push(...sets);
  });

  return Array.from(grouped.values()).map((item) => ({
    ...item,
    sets: item.sets.sort((a: any, b: any) => (a?.setNumber || 0) - (b?.setNumber || 0))
  }));
}

getWorkoutVideoUrl(exercise: any): string | null {
  const raw = (exercise?.videoUrl || '').trim();
  if (!raw) return null;
  if (/^https?:\/\//i.test(raw)) return raw;
  return `https://${raw}`;
}

private buildWorkoutPlanViewModel(plan: any): any {
  if (!plan) return null;

  return {
    ...plan,
    days: (plan.days || []).map((day: any) => ({
      ...day,
      exercises: (day.exercises || []).map((exercise: any) => ({
        ...exercise,
        displayVideoUrl: this.getWorkoutVideoUrl(exercise),
        sets: exercise?.sets || []
      }))
    }))
  };
}

exportDietPlanToExcel() {
  if (!this.dietPlan) {
    alert('No diet plan found to export.');
    return;
  }

  if (typeof XLSX === 'undefined') {
    alert('Excel exporter not loaded. Please refresh and try again.');
    return;
  }

  const dateLabel = new Intl.DateTimeFormat('en-GB').format(new Date());
  const rows: any[][] = [
    [`Diet Plan for ${this.member?.fullName || 'Member'} (${dateLabel})`],
    [this.dietPlan?.title || 'Diet Plan'],
    ['Meal', 'Food', 'Qty', 'Unit', 'Calories']
  ];

  this.groupedDietMeals.forEach((mealGroup: any, mealIndex: number) => {
    if (mealIndex > 0) rows.push(['', '', '', '', '']);

    mealGroup.items?.forEach((item: any, itemIndex: number) => {
      rows.push([
        itemIndex === 0 ? mealGroup.mealName : '',
        item.displayFoodName || this.getDietItemDisplayName(item.foodName),
        item.quantity ?? '',
        item.unit || '',
        item.calories ?? ''
      ]);
    });
  });

  const ws = XLSX.utils.aoa_to_sheet(rows);
  ws['!merges'] = [
    { s: { r: 0, c: 0 }, e: { r: 0, c: 4 } },
    { s: { r: 1, c: 0 }, e: { r: 1, c: 4 } }
  ];
  ws['!cols'] = [
    { wch: 18 },
    { wch: 30 },
    { wch: 10 },
    { wch: 10 },
    { wch: 12 }
  ];

  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, 'Sheet 1');
  const fileName = `Diet-Plan-${(this.member?.fullName || 'Member').replace(/\s+/g, '-')}.xlsx`;
  XLSX.writeFile(wb, fileName);
}

deleteMember() {
  if (!this.member?.id) return;

  const confirmed = window.confirm(
    `Delete member "${this.member.fullName}"?\n\nThis action cannot be undone.`
  );

  if (!confirmed) return;

  this.deletingMember = true;

  this.memberApi.deleteMember(this.member.id).subscribe({
    next: () => {
      this.router.navigate(['/members']);
    },
    error: () => {
      this.deletingMember = false;
      alert('Failed to delete member');
    }
  });
}


loadProgressCheckins() {
  this.progressCheckinsLoading = true;

  this.progressCheckinApi
    .getCheckinsByMember(this.member.id)
    .subscribe({
      next: res => {
        // newest first
        this.progressCheckins = (res || []).sort(
          (a, b) =>
            this.getCheckinDateValue(b.submittedAt) -
            this.getCheckinDateValue(a.submittedAt)
        );
        this.calculateProgressSummary();
        this.progressCheckinsLoading = false;
        this.progressCheckins.forEach(c => {
        this.loadCheckinPhotos(c.id);
        });
        this.prepareComparison();

        if (this.activeSection === 'progress') {
          setTimeout(() => this.renderWeightChart(), 0);
        }
      },
      error: () => {
        this.progressCheckins = [];
        this.progressCheckinsLoading = false;
      }
    });
}

getPhotoUrl(fileName: string) {
  return this.photoApi.getPhotoUrl(fileName);
}

  prepareComparison() {
    if (!this.progressCheckins || this.progressCheckins.length === 0) return;

  const sorted = [...this.progressCheckins].sort(
    (a, b) =>
      this.getCheckinDateValue(b.submittedAt) -
      this.getCheckinDateValue(a.submittedAt)
  );

  this.currentCheckin = sorted[0] || null;
  this.previousCheckin = sorted[1] || null;
}

  getDelta(current?: number, previous?: number): string {
    if (current == null || previous == null) return '-';

  const diff = current - previous;

  if (diff > 0) return `+${diff}`;
  if (diff < 0) return `${diff}`;
  return '0';
}

getPhotoByType(checkinId: string, type: 'FRONT' | 'SIDE' | 'BACK'): string | null {
  const photos = this.checkinPhotos[checkinId];
  if (!photos || photos.length === 0) return null;

  const photo = photos.find((p: any) => p.type === type);
  return photo ? photo.fileName : null;
}

onPhotoDragStart(checkinId: string, index: number): void {
  this.draggedPhoto = { checkinId, index };
}

onPhotoDragOver(event: DragEvent): void {
  event.preventDefault();
}

onPhotoDrop(checkinId: string, targetIndex: number): void {
  if (!this.draggedPhoto || this.draggedPhoto.checkinId !== checkinId) return;

  const photos = this.checkinPhotos[checkinId];
  if (!photos?.length) return;

  const { index: sourceIndex } = this.draggedPhoto;
  if (sourceIndex === targetIndex || sourceIndex < 0 || targetIndex < 0) {
    this.draggedPhoto = null;
    return;
  }

  const reordered = [...photos];
  const [movedPhoto] = reordered.splice(sourceIndex, 1);
  reordered.splice(targetIndex, 0, movedPhoto);
  this.checkinPhotos[checkinId] = reordered;
  this.draggedPhoto = null;
}

onPhotoDragEnd(): void {
  this.draggedPhoto = null;
}

openProgressComparison() {
  if (!this.currentCheckin || !this.previousCheckin) return;
  this.showProgressComparisonModal = true;
  this.isProgressComparisonMaximized = false;
  this.comparisonZoomLevel = 1;
  this.applyComparisonEnhancementPreset(this.comparisonEnhancementPreset);
}

closeProgressComparison() {
  if (document.fullscreenElement) {
    document.exitFullscreen().catch(() => undefined);
  }
  this.showProgressComparisonModal = false;
  this.isProgressComparisonMaximized = false;
  this.comparisonZoomLevel = 1;
}

toggleProgressComparisonMaximize() {
  const modalElement = this.comparisonModalRef?.nativeElement;
  if (!modalElement) return;

  if (document.fullscreenElement) {
    document.exitFullscreen().catch(() => undefined);
    this.isProgressComparisonMaximized = false;
    return;
  }

  modalElement.requestFullscreen().then(() => {
    this.isProgressComparisonMaximized = true;
  }).catch(() => {
    this.isProgressComparisonMaximized = false;
  });
}

zoomInComparison() {
  this.comparisonZoomLevel = Math.min(2.5, this.roundTo(this.comparisonZoomLevel + 0.25, 2));
}

zoomOutComparison() {
  this.comparisonZoomLevel = Math.max(0.5, this.roundTo(this.comparisonZoomLevel - 0.25, 2));
}

resetComparisonZoom() {
  this.comparisonZoomLevel = 1;
}

applyComparisonEnhancementPreset(preset: ComparisonEnhancementPreset) {
  this.comparisonEnhancementPreset = preset;

  const presets: Record<ComparisonEnhancementPreset, typeof this.comparisonEnhancement> = {
    natural: { contrast: 100, brightness: 100, saturate: 100, clarity: 0 },
    sharp: { contrast: 112, brightness: 103, saturate: 106, clarity: 8 },
    defined: { contrast: 122, brightness: 101, saturate: 110, clarity: 14 },
    custom: this.comparisonEnhancement
  };

  this.comparisonEnhancement = { ...presets[preset] };
}

onComparisonEnhancementChanged() {
  this.comparisonEnhancementPreset = 'custom';
}

resetComparisonEnhancement() {
  this.applyComparisonEnhancementPreset('sharp');
}

get comparisonPhotoFilter(): string {
  const { contrast, brightness, saturate, clarity } = this.comparisonEnhancement;
  const shadowStrength = this.roundTo(clarity / 100, 2);

  return [
    `contrast(${contrast}%)`,
    `brightness(${brightness}%)`,
    `saturate(${saturate}%)`,
    clarity > 0 ? `drop-shadow(0 0 ${clarity / 2}px rgba(15, 23, 42, ${shadowStrength}))` : ''
  ].filter(Boolean).join(' ');
}

async captureProgressComparison() {
  const captureElement = this.comparisonCaptureRef?.nativeElement;
  if (!captureElement || this.capturingComparison) return;

  this.capturingComparison = true;
  const previousZoom = this.comparisonZoomLevel;
  this.comparisonZoomLevel = 1;
  this.cdr.detectChanges();

  try {
    const link = document.createElement('a');
    link.download = this.getProgressComparisonFileName();
    link.href = await this.captureComparisonImageDataUrl(captureElement);
    link.click();
  } catch {
    alert('Unable to capture screenshot. Please wait for photos to load and try again.');
  } finally {
    this.comparisonZoomLevel = previousZoom;
    this.capturingComparison = false;
    this.cdr.detectChanges();
  }
}

async sendProgressComparisonWhatsApp(): Promise<void> {
  const captureElement = this.comparisonCaptureRef?.nativeElement;
  if (!captureElement || !this.member?.id || this.sendingComparisonWhatsApp) return;

  const recipient = this.getMemberWhatsAppRecipient();
  if (!recipient) {
    this.comparisonWhatsAppMessage = 'Add a phone number for this member before sending WhatsApp updates.';
    return;
  }

  this.sendingComparisonWhatsApp = true;
  this.comparisonWhatsAppMessage = 'Preparing high-resolution comparison image...';
  const previousZoom = this.comparisonZoomLevel;
  this.comparisonZoomLevel = 1;
  this.cdr.detectChanges();

  try {
    const imageDataUrl = await this.captureComparisonImageDataUrl(captureElement);

    this.notificationApi.send({
      memberId: this.member.id,
      channel: 'WHATSAPP',
      type: 'PROGRESS_COMPARISON',
      recipient,
      message: this.buildProgressComparisonWhatsAppText(),
      templateParameters: this.getProgressComparisonTemplateParameters(),
      imageDataUrl,
      imageFileName: this.getProgressComparisonFileName()
    }).subscribe({
      next: () => {
        this.sendingComparisonWhatsApp = false;
        this.comparisonWhatsAppMessage = 'Progress comparison sent on WhatsApp.';
      },
      error: () => {
        this.sendingComparisonWhatsApp = false;
        this.comparisonWhatsAppMessage = 'Unable to send progress comparison on WhatsApp.';
      }
    });
  } catch {
    this.sendingComparisonWhatsApp = false;
    this.comparisonWhatsAppMessage = 'Unable to create progress comparison image.';
  } finally {
    this.comparisonZoomLevel = previousZoom;
    this.cdr.detectChanges();
  }
}

private async captureComparisonImageDataUrl(captureElement: HTMLElement): Promise<string> {
  await this.waitForComparisonImages(captureElement);
  const html2canvas = (await import('html2canvas')).default;

  const canvas = await html2canvas(captureElement, {
    backgroundColor: '#fffefb',
    scale: Math.min(window.devicePixelRatio || 1, 3),
    useCORS: true,
    allowTaint: false,
    scrollX: 0,
    scrollY: 0,
    windowWidth: captureElement.scrollWidth,
    windowHeight: captureElement.scrollHeight
  });

  return canvas.toDataURL('image/png');
}

private async captureWeeklyReportImageDataUrl(captureElement: HTMLElement): Promise<string> {
  const html2canvas = (await import('html2canvas')).default;

  const canvas = await html2canvas(captureElement, {
    backgroundColor: '#ffffff',
    scale: Math.min(window.devicePixelRatio || 1, 3),
    useCORS: true,
    allowTaint: false,
    scrollX: 0,
    scrollY: 0,
    windowWidth: captureElement.scrollWidth,
    windowHeight: captureElement.scrollHeight
  });

  return canvas.toDataURL('image/png');
}

async captureWeeklyReport() {
  const captureElement = this.weeklyReportCaptureRef?.nativeElement;
  if (!captureElement || this.capturingWeeklyReport || !this.currentWeekConsistency) return;

  this.capturingWeeklyReport = true;
  this.cdr.detectChanges();

  try {
    const link = document.createElement('a');
    link.download = this.getWeeklyReportFileName();
    link.href = await this.captureWeeklyReportImageDataUrl(captureElement);
    link.click();
  } catch {
    alert('Unable to export weekly report image. Please try again.');
  } finally {
    this.capturingWeeklyReport = false;
    this.cdr.detectChanges();
  }
}

sendPaymentReminderWhatsApp(): void {
  if (!this.member?.id || this.sendingPaymentReminderWhatsApp) return;

  const recipient = this.getMemberWhatsAppRecipient();
  if (!recipient) {
    this.paymentReminderWhatsAppMessage = 'Add a phone number for this member before sending WhatsApp updates.';
    return;
  }

  this.paymentReminderWhatsAppMessage = 'Use Dashboard > Billing Attention Center to send the payment reminder with the approved image template.';
}

async sendWeeklyReportWhatsApp(): Promise<void> {
  const captureElement = this.weeklyReportCaptureRef?.nativeElement;
  if (!captureElement || !this.member?.id || this.sendingWeeklyReportWhatsApp || !this.currentWeekConsistency) return;

  const recipient = this.getMemberWhatsAppRecipient();
  if (!recipient) {
    this.weeklyReportWhatsAppMessage = 'Add a phone number for this member before sending WhatsApp updates.';
    return;
  }

  this.sendingWeeklyReportWhatsApp = true;
  this.weeklyReportWhatsAppMessage = 'Preparing high-resolution consistency image...';

  try {
    const imageDataUrl = await this.captureWeeklyReportImageDataUrl(captureElement);

    this.notificationApi.send({
      memberId: this.member.id,
      channel: 'WHATSAPP',
      type: 'WEEKLY_CONSISTENCY_REPORT',
      recipient,
      message: this.buildWeeklyReportWhatsAppText(),
      templateParameters: this.getWeeklyReportTemplateParameters(),
      imageDataUrl,
      imageFileName: this.getWeeklyReportFileName()
    }).subscribe({
      next: () => {
        this.sendingWeeklyReportWhatsApp = false;
        this.weeklyReportWhatsAppMessage = 'Weekly report sent on WhatsApp.';
      },
      error: () => {
        this.sendingWeeklyReportWhatsApp = false;
        this.weeklyReportWhatsAppMessage = 'Unable to send weekly report on WhatsApp.';
      }
    });
  } catch {
    this.sendingWeeklyReportWhatsApp = false;
    this.weeklyReportWhatsAppMessage = 'Unable to create weekly report image.';
  }
}

sendWorkoutPlanWhatsApp(): void {
  if (!this.member?.id || this.sendingWorkoutPlanWhatsApp) return;

  const recipient = this.getMemberWhatsAppRecipient();
  if (!recipient) {
    this.workoutPlanWhatsAppMessage = 'Add a phone number for this member before sending WhatsApp updates.';
    return;
  }

  const exportFile = this.buildWorkoutPlanExport();
  if (!exportFile) return;

  this.sendingWorkoutPlanWhatsApp = true;
  this.workoutPlanWhatsAppMessage = 'Preparing workout plan Excel...';

  try {
    const base64 = XLSX.write(exportFile.workbook, { bookType: 'xlsx', type: 'base64' });
    const documentDataUrl = `data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,${base64}`;

    this.notificationApi.send({
      memberId: this.member.id,
      channel: 'WHATSAPP',
      type: 'WORKOUT_PLAN',
      recipient,
      message: this.buildWorkoutPlanWhatsAppText(),
      templateParameters: this.getWorkoutPlanTemplateParameters(),
      documentDataUrl,
      documentFileName: exportFile.fileName
    }).subscribe({
      next: () => {
        this.sendingWorkoutPlanWhatsApp = false;
        this.workoutPlanWhatsAppMessage = 'Workout plan sent on WhatsApp.';
      },
      error: () => {
        this.sendingWorkoutPlanWhatsApp = false;
        this.workoutPlanWhatsAppMessage = 'Unable to send workout plan on WhatsApp.';
      }
    });
  } catch {
    this.sendingWorkoutPlanWhatsApp = false;
    this.workoutPlanWhatsAppMessage = 'Unable to prepare workout plan Excel.';
  }
}

private getMemberWhatsAppRecipient(): string | null {
  const phone = String(this.member?.phone || '').trim();
  return phone || null;
}

private getFirstName(value: string): string {
  return String(value || 'there').trim().split(/\s+/)[0] || 'there';
}

private buildPaymentReminderWhatsAppText(): string {
  const name = this.member?.fullName || 'there';
  const amount = this.totalPending > 0 ? ` Pending amount: Rs ${this.totalPending}.` : '';
  const renewal = this.displayedRenewalDate && this.displayedRenewalDate !== '-'
    ? ` Renewal date: ${this.displayedRenewalDate}.`
    : '';

  return `Hi ${name}, this is a quick payment reminder from your fitness coach.${amount}${renewal} Please complete it when convenient.`;
}

private buildWeeklyReportWhatsAppText(): string {
  const current = this.currentWeekConsistency;
  if (!current) {
    return '';
  }

  const feedback = this.weeklyManualFeedback.trim()
    || this.generateCoachFeedback(current, this.previousWeekConsistency, this.weeklyConsistencyTrend);

  return [
    `Hi ${this.member?.fullName || 'there'}, here is your weekly consistency report.`,
    `Week: ${current.rangeLabel}`,
    `Score: ${current.score}/100 (${current.rating})`,
    `Workouts: ${current.completedWorkouts}/${current.plannedWorkouts}`,
    `Average steps: ${Math.round(current.averageDailySteps)} / ${Math.round(current.stepTarget)}`,
    `Focus: ${this.generateNextWeekFocus(current)}`,
    `Coach feedback: ${feedback}`
  ].join('\n');
}

private getWeeklyReportTemplateParameters(): string[] {
  const current = this.currentWeekConsistency;
  if (!current) {
    return [];
  }

  const feedback = this.weeklyManualFeedback.trim()
    || this.generateCoachFeedback(current, this.previousWeekConsistency, this.weeklyConsistencyTrend);

  return [
    this.getFirstName(this.member?.fullName || 'there'),
    current.rangeLabel,
    `${current.score}/100 (${current.rating})`,
    `${current.completedWorkouts}/${current.plannedWorkouts}`,
    `${Math.round(current.averageDailySteps)} / ${Math.round(current.stepTarget)}`,
    this.generateNextWeekFocus(current),
    feedback
  ];
}

private buildProgressComparisonWhatsAppText(): string {
  return [
    `Hi ${this.member?.fullName || 'there'}, here is your progress comparison update.`,
    `Current check-in: ${this.formatProgressCheckinDate(this.currentCheckin?.submittedAt)}`,
    `Previous check-in: ${this.formatProgressCheckinDate(this.previousCheckin?.submittedAt)}`,
    `Weight change: ${this.getComparisonDelta('weight')}`,
    `Steps change: ${this.getComparisonDelta('stepsAvg')}`,
    `Coach notes: ${this.getComparisonNotes(this.currentCheckin)}`
  ].join('\n');
}

private getProgressComparisonTemplateParameters(): string[] {
  const weightChange = this.getComparisonDelta('weight');

  return [
    this.getFirstName(this.member?.fullName || 'there'),
    this.formatProgressCheckinDate(this.currentCheckin?.submittedAt),
    this.formatProgressCheckinDate(this.previousCheckin?.submittedAt),
    weightChange === '-' ? '-' : `${weightChange} kg`,
    this.getComparisonDelta('stepsAvg'),
    this.getComparisonNotes(this.currentCheckin)
  ];
}

private buildWorkoutPlanWhatsAppText(): string {
  const targetSteps = this.activeWorkoutPlan?.targetStepsCount != null
    ? ` Target steps: ${Math.round(this.activeWorkoutPlan.targetStepsCount)}.`
    : '';
  const title = this.activeWorkoutPlan?.title ? ` Plan: ${this.activeWorkoutPlan.title}.` : '';

  return `Hi ${this.member?.fullName || 'there'}, your workout plan is attached.${title}${targetSteps} Please follow it as discussed.`;
}

private getWorkoutPlanTemplateParameters(): string[] {
  return [this.getFirstName(this.member?.fullName || 'there')];
}

@HostListener('document:fullscreenchange')
onFullscreenChange() {
  this.isProgressComparisonMaximized = !!document.fullscreenElement;
}

get canCompareProgress(): boolean {
  return !!this.currentCheckin && !!this.previousCheckin;
}

get currentDietPlanSummary(): string {
  return this.currentDietPlanSummaryText;
}

private buildCurrentDietPlanSummary(): string {
  const totals = this.dietPlanTotals;
  const calories = totals.calories;
  const carbs = totals.carbs;
  const protein = totals.protein;
  const fats = totals.fats;

  const macroParts = [
    carbs != null ? `${carbs}g Carbs` : null,
    protein != null ? `${protein}g Protein` : null,
    fats != null ? `${fats}g Fats` : null
  ].filter((value): value is string => !!value);

  if (calories != null && macroParts.length) {
    return `${calories} Calories (${macroParts.join(', ')})`;
  }

  if (this.dietPlan?.title) {
    return this.dietPlan.title;
  }

  return 'NA';
}

trackByWorkoutDay(_index: number, day: any): any {
  return day?.id || day?.dayName || _index;
}

trackByWorkoutExercise(_index: number, exercise: any): any {
  return exercise?.id || `${exercise?.name || ''}-${exercise?.videoUrl || ''}-${_index}`;
}

trackByWorkoutSet(_index: number, set: any): any {
  return set?.id || set?.setNumber || _index;
}

trackByDietMeal(_index: number, meal: DietMealViewModel): string {
  return meal.mealName;
}

trackByDietItem(_index: number, item: DietItemViewModel): any {
  return item?.id || `${item?.displayFoodName || item?.foodName || ''}-${item?.quantity || ''}-${_index}`;
}

getComparisonValue(checkin: any, field: 'weight' | 'stepsAvg' | 'dietAdherence' | 'energy' | 'exerciseRating'): string {
  const value = field === 'exerciseRating'
    ? (checkin?.exerciseRating ?? checkin?.energy)
    : checkin?.[field];

  if (value == null || value === '') return 'NA';
  if (field === 'weight') return `${value} kg`;
  return `${value}`;
}

getComparisonDelta(field: 'weight' | 'stepsAvg' | 'dietAdherence' | 'energy' | 'exerciseRating'): string {
  if (!this.currentCheckin || !this.previousCheckin) return 'NA';

  const current = Number(
    field === 'exerciseRating'
      ? (this.currentCheckin?.exerciseRating ?? this.currentCheckin?.energy)
      : this.currentCheckin?.[field]
  );
  const previous = Number(
    field === 'exerciseRating'
      ? (this.previousCheckin?.exerciseRating ?? this.previousCheckin?.energy)
      : this.previousCheckin?.[field]
  );
  if (!Number.isFinite(current) || !Number.isFinite(previous)) return 'NA';

  const diff = this.roundToTwo(current - previous);
  const prefix = diff > 0 ? '+' : '';
  const suffix = field === 'weight' ? ' kg' : '';
  return `${prefix}${diff}${suffix}`;
}

getComparisonNotes(checkin: any): string {
  const notes = String(checkin?.notes || '').trim();
  return notes || 'NA';
}

calculateProgressSummary() {
  if (!this.progressCheckins?.length) return;

  const sorted = [...this.progressCheckins]
    .sort((a, b) => this.getCheckinDateValue(a.submittedAt) - this.getCheckinDateValue(b.submittedAt));

  const last = sorted[sorted.length - 1];
  const previous = sorted.length > 1 ? sorted[sorted.length - 2] : null;

  this.latestWeight = last.weight || 0;
  this.weightChange = this.roundToTwo((last.weight || 0) - (previous?.weight || 0));

  const validDiet = sorted.filter(c => c.dietAdherence);
  const validSteps = sorted.filter(c => c.stepsAvg != null);

  this.avgDietAdherence =
    validDiet.reduce((sum, c) => sum + c.dietAdherence, 0) / (validDiet.length || 1);

  this.avgSteps = this.roundToTwo(
    validSteps.reduce((sum, c) => sum + c.stepsAvg, 0) / (validSteps.length || 1)
  );
}

formatProgressCheckinDate(value: string | null | undefined): string {
  if (!value) return '-';

  const parsed = new Date(value);
  if (Number.isNaN(parsed.getTime())) return '-';

  return new Intl.DateTimeFormat('en-IN', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
  }).format(parsed);
}

private getCheckinDateValue(value: string | null | undefined): number {
  if (!value) return 0;

  const parsed = new Date(value);
  return Number.isNaN(parsed.getTime()) ? 0 : parsed.getTime();
}

private roundToTwo(value: number): number {
  return Math.round((value + Number.EPSILON) * 100) / 100;
}

private async waitForComparisonImages(element: HTMLElement): Promise<void> {
  const images = Array.from(element.querySelectorAll('img')) as HTMLImageElement[];
  await Promise.all(images.map((image) => {
    if (image.complete && image.naturalWidth > 0) {
      return Promise.resolve();
    }

    if (typeof image.decode === 'function') {
      return image.decode().catch(() => undefined);
    }

    return new Promise<void>((resolve) => {
      image.onload = () => resolve();
      image.onerror = () => resolve();
    });
  }));
}

private getProgressComparisonFileName(): string {
  const memberName = String(this.member?.fullName || 'Member')
    .replace(/[<>:"/\\|?*\x00-\x1F\x7F]+/g, '-')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '') || 'Member';
  const currentDate = this.formatProgressCheckinDate(this.currentCheckin?.submittedAt).replace(/\s+/g, '-');
  const previousDate = this.formatProgressCheckinDate(this.previousCheckin?.submittedAt).replace(/\s+/g, '-');

  return `Progress-Comparison-${memberName}-${currentDate}-vs-${previousDate}.png`;
}

private getWeeklyReportFileName(): string {
  const memberName = String(this.member?.fullName || 'Member')
    .replace(/[<>:"/\\|?*\x00-\x1F\x7F]+/g, '-')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '') || 'Member';
  const rangeLabel = String(this.currentWeekConsistency?.rangeLabel || 'Current-Week')
    .replace(/[<>:"/\\|?*\x00-\x1F\x7F]+/g, '-')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '') || 'Current-Week';

  return `Weekly-Consistency-${memberName}-${rangeLabel}.png`;
}

private initializeConfirmPaymentDates(): void {
  const today = this.getTodayDateInput();
  const nextDates: Record<string, string> = {};

  (this.payments || []).forEach((payment) => {
    if (payment?.status === 'PENDING' && payment?.mode === 'MANUAL') {
      nextDates[payment.id] = this.normalizeDateInput(payment.paymentDate) || today;
    }
  });

  this.confirmPaymentDates = nextDates;
}

private getTodayDateInput(): string {
  return new Date().toISOString().slice(0, 10);
}

private getOriginalSubscriptionStartDate(): string | null {
  if (!this.subscriptionHistory.length) {
    return this.subscription?.startDate || null;
  }

  const startDates = this.subscriptionHistory
    .map((item) => String(item?.startDate || '').trim())
    .filter(Boolean)
    .sort();

  return startDates[0] || null;
}

private parseDietItemFoodName(foodName: any): { primaryFoodName: string; optionalAlternatives: string[] } {
  const rawValue = String(foodName || '').trim();
  const match = rawValue.match(/^(.*?)(?:\s*\[\[OPT:(.*?)\]\])?$/);
  const primaryFoodName = String(match?.[1] || rawValue).trim();
  const optionalAlternatives = String(match?.[2] || '')
    .split('|')
    .map((item) => item.trim())
    .filter((item, index, list) => !!item && list.findIndex((entry) => entry.toLowerCase() === item.toLowerCase()) === index);

  return {
    primaryFoodName,
    optionalAlternatives
  };
}

}
