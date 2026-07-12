import { CommonModule } from '@angular/common';
import { ChangeDetectorRef, Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { catchError, forkJoin, map, Observable, of, switchMap } from 'rxjs';
import { MemberApiService } from '../../../../core/api/member-api.service';
import {
  DailyCheckinApiService,
  DailyCheckinDay
} from '../../../../core/services/daily-checkin-api.service';
import { WorkoutApiService } from '../../../../core/services/workout-api.service';

type LeaderboardPlace = 1 | 2 | 3;

type WeeklyLeaderboardEntry = {
  place: LeaderboardPlace;
  memberName: string;
  weeklyScore: number;
  workoutCompliance: number;
  stepsCompliance: number;
  completedWorkouts: number;
  plannedWorkouts: number;
  averageDailySteps: number;
  stepTarget: number;
};

type MemberWeeklyScore = Omit<WeeklyLeaderboardEntry, 'place'>;

@Component({
  selector: 'app-weekly-consistency-leaderboard',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './weekly-consistency-leaderboard.component.html',
  styleUrls: ['./weekly-consistency-leaderboard.component.scss']
})
export class WeeklyConsistencyLeaderboardComponent implements OnInit {
  @ViewChild('leaderboardCapture') leaderboardCaptureRef?: ElementRef<HTMLDivElement>;

  threshold = 85;
  readonly defaultThreshold = 85;
  readonly motivationalFooter =
    'Congratulations to this week\'s Consistency Champions! Keep showing up. Everyone else, let\'s aim for next week\'s leaderboard.';

  leaderboard: WeeklyLeaderboardEntry[] = [];
  weekRangeLabel = '';
  loading = false;
  error: string | null = null;
  exporting = false;

  constructor(
    private memberApi: MemberApiService,
    private workoutApi: WorkoutApiService,
    private dailyCheckinApi: DailyCheckinApiService,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.generateLeaderboard();
  }

  generateLeaderboard(): void {
    const cleanThreshold = this.normalizeThreshold(this.threshold);
    this.threshold = cleanThreshold;

    const today = this.startOfDay(new Date());
    const weekStart = this.addDays(this.getSundayWeekStart(today), -7);
    const weekEnd = this.addDays(weekStart, 6);
    const workoutMakeupEnd = this.addDays(weekEnd, 1);
    const monthKeys = this.getMonthKeysBetween(weekStart, workoutMakeupEnd);

    this.weekRangeLabel = `${this.formatShortDate(weekStart)} - ${this.formatShortDate(weekEnd)}`;
    this.loading = true;
    this.error = null;
    this.leaderboard = [];

    this.memberApi.getMembers().pipe(
      switchMap((members) => {
        const activeMembers = (members || []).filter((member) => this.isActiveMember(member));

        if (!activeMembers.length) {
          return of([]);
        }

        return forkJoin(
          activeMembers.map((member) =>
            this.buildMemberWeeklyScore(member, weekStart, weekEnd, monthKeys).pipe(
              catchError(() => of(null))
            )
          )
        );
      }),
      map((scores) => this.rankQualifyingScores(scores, cleanThreshold))
    ).subscribe({
      next: (entries) => {
        this.leaderboard = entries;
        this.loading = false;
      },
      error: () => {
        this.leaderboard = [];
        this.loading = false;
        this.error = 'Unable to generate the leaderboard right now.';
      }
    });
  }

  async exportAsImage(): Promise<void> {
    const captureElement = this.leaderboardCaptureRef?.nativeElement;
    if (!captureElement || this.exporting) return;

    this.exporting = true;
    this.cdr.detectChanges();

    try {
      const html2canvas = (await import('html2canvas')).default;
      const canvas = await html2canvas(captureElement, {
        backgroundColor: '#f8fafc',
        scale: Math.min(window.devicePixelRatio || 1, 3),
        useCORS: true,
        allowTaint: false,
        scrollX: 0,
        scrollY: 0,
        windowWidth: captureElement.scrollWidth,
        windowHeight: captureElement.scrollHeight
      });

      const link = document.createElement('a');
      link.download = this.getExportFileName();
      link.href = canvas.toDataURL('image/png');
      link.click();
    } catch {
      alert('Unable to export leaderboard image. Please try again.');
    } finally {
      this.exporting = false;
      this.cdr.detectChanges();
    }
  }

  getMedalLabel(place: LeaderboardPlace): string {
    if (place === 1) return '1st Place';
    if (place === 2) return '2nd Place';
    return '3rd Place';
  }

  getPlaceClass(place: LeaderboardPlace): string {
    if (place === 1) return 'gold';
    if (place === 2) return 'silver';
    return 'bronze';
  }

  trackByPlace(_index: number, entry: WeeklyLeaderboardEntry): number {
    return entry.place;
  }

  private buildMemberWeeklyScore(
    member: any,
    weekStart: Date,
    weekEnd: Date,
    monthKeys: string[]
  ): Observable<MemberWeeklyScore | null> {
    const memberId = String(member?.id || '');

    if (!memberId) {
      return of(null);
    }

    const workout$ = this.workoutApi.getWorkoutPlan(memberId).pipe(
      catchError(() => of(null))
    );
    const calendars$ = forkJoin(
      monthKeys.map((month) =>
        this.dailyCheckinApi.getMemberCalendar(memberId, month).pipe(
          catchError(() => of({ days: [] }))
        )
      )
    );

    return forkJoin({ workout: workout$, calendars: calendars$ }).pipe(
      map(({ workout, calendars }) => {
        const activeWorkoutPlan = this.resolveActiveWorkoutPlan(workout);
        const days = calendars.flatMap((calendar: any) => calendar.days || []);
        return this.calculateMemberWeeklyScore(member, activeWorkoutPlan, days, weekStart, weekEnd);
      })
    );
  }

  private calculateMemberWeeklyScore(
    member: any,
    activeWorkoutPlan: any,
    days: DailyCheckinDay[],
    weekStart: Date,
    weekEnd: Date
  ): MemberWeeklyScore {
    const dateKeys = this.getDateKeysBetween(weekStart, weekEnd);
    const entriesByDate = new Map(days.map((day) => [day.checkInDate, day]));
    const weekEntries = dateKeys.map((date) => entriesByDate.get(date) || null);

    const totalSteps = weekEntries.reduce((sum, entry) => sum + Math.max(0, Number(entry?.stepsCount || 0)), 0);
    const averageDailySteps = dateKeys.length ? totalSteps / dateKeys.length : 0;
    const plannedWorkouts = Array.isArray(activeWorkoutPlan?.days) ? activeWorkoutPlan.days.length : 0;
    const completedWorkouts = this.countCompletedWorkoutsWithMakeup(entriesByDate, weekStart, weekEnd, plannedWorkouts);
    const stepTarget = Math.max(0, Number(activeWorkoutPlan?.targetStepsCount || 0));
    const workoutCompliance = this.calculateWorkoutCompliance(completedWorkouts, plannedWorkouts);
    const stepsCompliance = this.calculateStepsCompliance(averageDailySteps, stepTarget);
    const weeklyScore = (workoutCompliance * 0.7) + (stepsCompliance * 0.3);

    return {
      memberName: String(member?.fullName || 'Member').trim() || 'Member',
      weeklyScore: this.roundTo(weeklyScore, 0),
      workoutCompliance: this.roundTo(workoutCompliance, 0),
      stepsCompliance: this.roundTo(stepsCompliance, 0),
      completedWorkouts,
      plannedWorkouts,
      averageDailySteps: this.roundTo(averageDailySteps, 0),
      stepTarget
    };
  }

  private rankQualifyingScores(
    scores: Array<MemberWeeklyScore | null>,
    threshold: number
  ): WeeklyLeaderboardEntry[] {
    return scores
      .filter((score): score is MemberWeeklyScore => Boolean(score) && score!.weeklyScore >= threshold)
      .sort((a, b) => {
        if (b.weeklyScore !== a.weeklyScore) return b.weeklyScore - a.weeklyScore;
        if (b.workoutCompliance !== a.workoutCompliance) return b.workoutCompliance - a.workoutCompliance;
        return b.stepsCompliance - a.stepsCompliance;
      })
      .slice(0, 3)
      .map((score, index) => ({
        ...score,
        place: (index + 1) as LeaderboardPlace
      }));
  }

  private countCompletedWorkoutsWithMakeup(
    entriesByDate: Map<string, DailyCheckinDay>,
    start: Date,
    end: Date,
    plannedWorkouts: number
  ): number {
    const workoutDates = this.getDateKeysBetween(start, this.addDays(end, 1));
    const completed = workoutDates.filter((date) => Boolean(entriesByDate.get(date)?.exerciseDone)).length;
    return plannedWorkouts > 0 ? Math.min(completed, plannedWorkouts) : completed;
  }

  private resolveActiveWorkoutPlan(workout: any): any {
    if (Array.isArray(workout)) {
      return workout.find((plan) => plan?.status === 'ACTIVE') || workout[0] || null;
    }

    return workout || null;
  }

  private isActiveMember(member: any): boolean {
    return String(member?.status || 'ACTIVE').toUpperCase() !== 'INACTIVE';
  }

  private calculateWorkoutCompliance(completedWorkouts: number, plannedWorkouts: number): number {
    return plannedWorkouts > 0
      ? Math.min(100, (Math.max(0, completedWorkouts) / plannedWorkouts) * 100)
      : 0;
  }

  private calculateStepsCompliance(averageDailySteps: number, stepTarget: number): number {
    return stepTarget > 0
      ? Math.min(100, (Math.max(0, averageDailySteps) / stepTarget) * 100)
      : 0;
  }

  private normalizeThreshold(value: number): number {
    const parsed = Number(value);
    if (!Number.isFinite(parsed)) return this.defaultThreshold;
    return Math.min(100, Math.max(0, Math.round(parsed)));
  }

  private startOfDay(value: Date): Date {
    return new Date(value.getFullYear(), value.getMonth(), value.getDate());
  }

  private getSundayWeekStart(value: Date): Date {
    const date = this.startOfDay(value);
    return this.addDays(date, -date.getDay());
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

  private roundTo(value: number, decimals: number): number {
    const factor = 10 ** decimals;
    return Math.round((value + Number.EPSILON) * factor) / factor;
  }

  private getExportFileName(): string {
    const range = String(this.weekRangeLabel || 'Previous-Week')
      .replace(/[<>:"/\\|?*\x00-\x1F\x7F]+/g, '-')
      .replace(/\s+/g, '-')
      .replace(/-+/g, '-')
      .replace(/^-|-$/g, '') || 'Previous-Week';

    return `Weekly-Consistency-Leaderboard-${range}.png`;
  }
}
