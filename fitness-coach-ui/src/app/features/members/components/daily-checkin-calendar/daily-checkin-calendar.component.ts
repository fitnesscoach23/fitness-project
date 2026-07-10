import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { forkJoin } from 'rxjs';
import {
  DailyCheckinApiService,
  DailyActivityMarker,
  DailyCheckinCalendar,
  DailyCheckinDay,
  DailyCheckinSummary
} from '../../../../core/services/daily-checkin-api.service';

interface CalendarCell {
  date: string;
  dayNumber: number | null;
  inMonth: boolean;
  entry: DailyCheckinDay | null;
}

interface DailyCheckinEditor {
  checkInDate: string;
  exerciseDone: boolean;
  workoutNotCompleted: boolean;
  stepTargetAchieved: boolean;
  travelWorkout: boolean;
  recoveryDay: boolean;
  activeOther: boolean;
  workoutVideoNotShared: boolean;
  stepsRecordNotShared: boolean;
  notActive: boolean;
  stepsCount: number | null;
  notes: string;
}

interface BulkDailyCheckinEditor {
  startDate: string;
  endDate: string;
  marker: DailyActivityMarker;
  value: boolean;
  noWorkout: boolean;
  noSteps: boolean;
  stepsCount: number | null;
  notes: string;
}

@Component({
  selector: 'app-daily-checkin-calendar',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './daily-checkin-calendar.component.html',
  styleUrls: ['./daily-checkin-calendar.component.scss']
})
export class DailyCheckinCalendarComponent implements OnChanges {
  @Input({ required: true }) memberId = '';
  @Input() activeStartDate = '';
  @Output() checkinsChanged = new EventEmitter<void>();

  readonly weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  readonly activityMarkers: { key: DailyActivityMarker; label: string; className: string }[] = [
    { key: 'exerciseDone', label: 'Workout Completed', className: 'workout-completed' },
    { key: 'workoutNotCompleted', label: 'Workout Not Completed', className: 'workout-not-completed' },
    { key: 'stepTargetAchieved', label: 'Step Target Achieved', className: 'step-target-achieved' },
    { key: 'travelWorkout', label: 'Travel Workout', className: 'travel-workout' },
    { key: 'recoveryDay', label: 'Recovery Day', className: 'recovery-day' },
    { key: 'activeOther', label: 'Active Other', className: 'active-other' },
    { key: 'workoutVideoNotShared', label: 'Workout Video Not Shared', className: 'workout-video-not-shared' },
    { key: 'stepsRecordNotShared', label: 'Steps Record Not Shared', className: 'steps-record-not-shared' },
    { key: 'notActive', label: 'Not Active', className: 'not-active' }
  ];
  readonly emptySummary: DailyCheckinSummary = {
    daysInMonth: 0,
    recordedDays: 0,
    activeDays: 0,
    exerciseDays: 0,
    totalSteps: 0
  };

  visibleMonth = this.getMonthKey(new Date());
  calendar: DailyCheckinCalendar | null = null;
  cells: CalendarCell[] = [];
  selectedEntry: DailyCheckinDay | null = null;
  editor: DailyCheckinEditor | null = null;
  loading = false;
  saving = false;
  deleting = false;
  bulkSaving = false;
  bulkEditor: BulkDailyCheckinEditor = this.createDefaultBulkEditor();
  error: string | null = null;
  bulkMessage: string | null = null;

  constructor(private dailyCheckinApi: DailyCheckinApiService) {}

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['memberId'] && this.memberId) {
      this.loadCalendar();
      return;
    }

    if (changes['activeStartDate']) {
      this.bulkEditor = this.createDefaultBulkEditor();
      this.closeEditor();
      if (this.calendar) {
        this.cells = this.buildCells(this.calendar.days || []);
      }
    }
  }

  get summary(): DailyCheckinSummary {
    if (!this.cells.length) return this.emptySummary;

    const trackedCells = this.cells.filter((cell) => cell.inMonth && this.isTrackableDate(cell.date));
    return {
      daysInMonth: trackedCells.length,
      recordedDays: trackedCells.filter((cell) => Boolean(cell.entry)).length,
      activeDays: trackedCells.filter((cell) => this.isEntryActive(cell.entry)).length,
      exerciseDays: trackedCells.filter((cell) => Boolean(cell.entry?.exerciseDone)).length,
      totalSteps: trackedCells.reduce((sum, cell) => sum + Math.max(0, Number(cell.entry?.stepsCount || 0)), 0)
    };
  }

  get visibleMonthLabel(): string {
    const [year, month] = this.visibleMonth.split('-').map(Number);
    return new Intl.DateTimeFormat('en-IN', {
      month: 'long',
      year: 'numeric'
    }).format(new Date(year, month - 1, 1));
  }

  get bulkSelectedDaysCount(): number {
    return this.getDateKeysBetween(this.bulkEditor.startDate, this.bulkEditor.endDate).length;
  }

  previousMonth(): void {
    this.shiftMonth(-1);
  }

  nextMonth(): void {
    this.shiftMonth(1);
  }

  selectDay(cell: CalendarCell): void {
    if (!cell.inMonth || !cell.date || !this.isTrackableDate(cell.date)) return;

    this.selectedEntry = cell.entry;
    this.editor = {
      checkInDate: cell.date,
      exerciseDone: Boolean(cell.entry?.exerciseDone),
      workoutNotCompleted: Boolean(cell.entry?.workoutNotCompleted),
      stepTargetAchieved: Boolean(cell.entry?.stepTargetAchieved),
      travelWorkout: Boolean(cell.entry?.travelWorkout),
      recoveryDay: Boolean(cell.entry?.recoveryDay),
      activeOther: Boolean(cell.entry?.activeOther),
      workoutVideoNotShared: Boolean(cell.entry?.workoutVideoNotShared),
      stepsRecordNotShared: Boolean(cell.entry?.stepsRecordNotShared),
      notActive: Boolean(cell.entry?.notActive),
      stepsCount: cell.entry?.stepsCount ?? null,
      notes: cell.entry?.notes || ''
    };
    this.error = null;
  }

  useSelectedDateAsBulkStart(): void {
    if (!this.editor?.checkInDate) return;
    this.bulkEditor.startDate = this.editor.checkInDate;
    if (!this.bulkEditor.endDate || this.bulkEditor.endDate < this.bulkEditor.startDate) {
      this.bulkEditor.endDate = this.bulkEditor.startDate;
    }
    this.bulkMessage = null;
  }

  useSelectedDateAsBulkEnd(): void {
    if (!this.editor?.checkInDate) return;
    this.bulkEditor.endDate = this.editor.checkInDate;
    if (!this.bulkEditor.startDate || this.bulkEditor.startDate > this.bulkEditor.endDate) {
      this.bulkEditor.startDate = this.bulkEditor.endDate;
    }
    this.bulkMessage = null;
  }

  closeEditor(): void {
    this.editor = null;
    this.selectedEntry = null;
    this.error = null;
  }

  saveSelectedDay(): void {
    if (!this.editor || !this.memberId) return;

    const stepsCount = Math.max(0, Number(this.editor.stepsCount || 0));
    this.saving = true;
    this.error = null;
    this.dailyCheckinApi.upsertDailyCheckin({
      memberId: this.memberId,
      checkInDate: this.editor.checkInDate,
      exerciseDone: this.editor.exerciseDone,
      workoutNotCompleted: this.editor.workoutNotCompleted,
      stepTargetAchieved: this.editor.stepTargetAchieved,
      travelWorkout: this.editor.travelWorkout,
      recoveryDay: this.editor.recoveryDay,
      activeOther: this.editor.activeOther,
      workoutVideoNotShared: this.editor.workoutVideoNotShared,
      stepsRecordNotShared: this.editor.stepsRecordNotShared,
      notActive: this.editor.notActive && stepsCount === 0,
      stepsCount,
      notes: this.editor.notes.trim() || null
    }).subscribe({
      next: () => {
        this.saving = false;
        this.checkinsChanged.emit();
        this.closeEditor();
        this.loadCalendar();
      },
      error: () => {
        this.saving = false;
        this.error = 'Failed to save daily check-in';
      }
    });
  }

  applyBulkUpdate(): void {
    if (!this.memberId || this.bulkSaving) return;

    const dateKeys = this.getDateKeysBetween(this.bulkEditor.startDate, this.bulkEditor.endDate);
    if (!dateKeys.length) {
      this.error = 'Select a valid start and end date for bulk update';
      return;
    }

    const noWorkoutText = this.bulkEditor.noWorkout ? ', mark no workout' : '';
    const noStepsText = this.bulkEditor.noSteps ? ', mark no steps' : '';
    const confirmed = window.confirm(
      `${this.bulkEditor.value ? 'Add' : 'Remove'} ${this.getMarkerLabel(this.bulkEditor.marker)}${noWorkoutText}${noStepsText} for ${dateKeys.length} day${dateKeys.length === 1 ? '' : 's'}?`
    );
    if (!confirmed) return;

    const entriesByDate = new Map((this.calendar?.days || []).map((day) => [day.checkInDate, day]));
    const bulkSteps = this.bulkEditor.stepsCount == null
      ? null
      : Math.max(0, Number(this.bulkEditor.stepsCount || 0));
    const notes = this.bulkEditor.notes.trim();

    this.bulkSaving = true;
    this.error = null;
    this.bulkMessage = null;

    forkJoin(dateKeys.map((checkInDate) => {
      const existing = entriesByDate.get(checkInDate);
      const addingActiveMarker = this.isActiveMarker(this.bulkEditor.marker) && this.bulkEditor.value;
      const bulkHasPositiveSteps = bulkSteps != null && bulkSteps > 0;
      const bulkNotActive = addingActiveMarker || bulkHasPositiveSteps
        ? false
        : this.getBulkMarkerValue(existing, 'notActive');
      const exerciseDone = bulkNotActive || this.bulkEditor.noWorkout
        ? false
        : this.getBulkMarkerValue(existing, 'exerciseDone');
      const workoutNotCompleted = exerciseDone
        ? false
        : (this.bulkEditor.noWorkout || this.getBulkMarkerValue(existing, 'workoutNotCompleted'));
      const stepTargetAchieved = bulkNotActive || this.bulkEditor.noSteps
        ? false
        : this.getBulkMarkerValue(existing, 'stepTargetAchieved');
      const travelWorkout = bulkNotActive ? false : this.getBulkMarkerValue(existing, 'travelWorkout');
      const recoveryDay = bulkNotActive ? false : this.getBulkMarkerValue(existing, 'recoveryDay');
      const activeOther = bulkNotActive ? false : this.getBulkMarkerValue(existing, 'activeOther');
      const workoutVideoNotShared = this.getBulkMarkerValue(existing, 'workoutVideoNotShared');
      const stepsRecordNotShared = this.getBulkMarkerValue(existing, 'stepsRecordNotShared');
      const provisionalStepsCount = this.bulkEditor.noSteps || bulkNotActive
        ? 0
        : (bulkSteps ?? Math.max(0, Number(existing?.stepsCount || 0)));
      const finalNotActive = bulkNotActive && provisionalStepsCount === 0 && !exerciseDone && !stepTargetAchieved
        && !travelWorkout
        && !recoveryDay
        && !activeOther;
      const stepsCount = finalNotActive ? 0 : provisionalStepsCount;

      return this.dailyCheckinApi.upsertDailyCheckin({
        memberId: this.memberId,
        checkInDate,
        exerciseDone,
        workoutNotCompleted,
        stepTargetAchieved,
        travelWorkout,
        recoveryDay,
        activeOther,
        workoutVideoNotShared,
        stepsRecordNotShared,
        notActive: finalNotActive,
        stepsCount,
        notes: notes || existing?.notes || null
      });
    })).subscribe({
      next: () => {
        this.bulkSaving = false;
        this.bulkMessage = `Updated ${dateKeys.length} day${dateKeys.length === 1 ? '' : 's'} successfully`;
        this.checkinsChanged.emit();
        this.closeEditor();
        this.loadCalendar();
      },
      error: () => {
        this.bulkSaving = false;
        this.error = 'Failed to bulk update daily check-ins';
      }
    });
  }

  deleteSelectedDay(): void {
    if (!this.selectedEntry?.id) return;

    const confirmed = window.confirm('Delete this daily check-in entry?');
    if (!confirmed) return;

    this.deleting = true;
    this.error = null;
    this.dailyCheckinApi.deleteDailyCheckin(this.selectedEntry.id).subscribe({
      next: () => {
        this.deleting = false;
        this.checkinsChanged.emit();
        this.closeEditor();
        this.loadCalendar();
      },
      error: () => {
        this.deleting = false;
        this.error = 'Failed to delete daily check-in';
      }
    });
  }

  getCellClass(cell: CalendarCell): string {
    if (!cell.inMonth) return 'empty';
    if (!this.isTrackableDate(cell.date)) return 'not-tracked';
    if (!cell.entry) return 'no-entry';
    return this.isEntryActive(cell.entry) ? 'active-day' : 'no-activity';
  }

  isCellDisabled(cell: CalendarCell): boolean {
    return !cell.inMonth || !this.isTrackableDate(cell.date);
  }

  isTrackableDate(date: string): boolean {
    return !this.activeStartDate || date >= this.activeStartDate;
  }

  getMarkerLabel(marker: DailyActivityMarker): string {
    return this.activityMarkers.find((option) => option.key === marker)?.label || '';
  }

  getEntryMarkers(entry: DailyCheckinDay | null): { label: string; className: string }[] {
    if (!entry) return [];
    return this.activityMarkers
      .filter((marker) => Boolean(entry[marker.key]))
      .map((marker) => ({ label: marker.label, className: marker.className }));
  }

  isEntryActive(entry: DailyCheckinDay | null): boolean {
    if (!entry) return false;
    return Boolean(
      entry.exerciseDone
      || entry.stepTargetAchieved
      || entry.travelWorkout
      || entry.recoveryDay
      || entry.activeOther
      || Number(entry.stepsCount || 0) > 0
    );
  }

  getMarkerChecked(marker: DailyActivityMarker): boolean {
    return Boolean(this.editor?.[marker]);
  }

  onEditorMarkerChanged(marker: DailyActivityMarker): void {
    if (!this.editor) return;

    if (marker === 'notActive' && this.editor.notActive) {
      this.editor.exerciseDone = false;
      this.editor.workoutNotCompleted = false;
      this.editor.stepTargetAchieved = false;
      this.editor.travelWorkout = false;
      this.editor.recoveryDay = false;
      this.editor.activeOther = false;
      this.editor.stepsCount = 0;
      return;
    }

    if (marker === 'exerciseDone' && this.editor.exerciseDone) {
      this.editor.workoutNotCompleted = false;
    }

    if (marker === 'workoutNotCompleted' && this.editor.workoutNotCompleted) {
      this.editor.exerciseDone = false;
    }

    if (this.isActiveMarker(marker) && this.editor[marker]) {
      this.editor.notActive = false;
    }
  }

  onEditorStepsChanged(): void {
    if (!this.editor) return;

    if (Number(this.editor.stepsCount || 0) > 0) {
      this.editor.notActive = false;
    }
  }

  formatCellSteps(entry: DailyCheckinDay | null): string {
    if (!entry || !entry.stepsCount) return '';
    return new Intl.NumberFormat('en-IN').format(entry.stepsCount);
  }

  private loadCalendar(): void {
    if (!this.memberId) return;

    this.loading = true;
    this.error = null;
    this.dailyCheckinApi.getMemberCalendar(this.memberId, this.visibleMonth).subscribe({
      next: (res) => {
        this.calendar = res;
        this.cells = this.buildCells(res.days || []);
        this.loading = false;
      },
      error: () => {
        this.calendar = null;
        this.cells = this.buildCells([]);
        this.loading = false;
        this.error = 'Failed to load daily check-ins';
      }
    });
  }

  private shiftMonth(offset: number): void {
    const [year, month] = this.visibleMonth.split('-').map(Number);
    this.visibleMonth = this.getMonthKey(new Date(year, month - 1 + offset, 1));
    this.bulkEditor = this.createDefaultBulkEditor();
    this.closeEditor();
    this.loadCalendar();
  }

  private buildCells(days: DailyCheckinDay[]): CalendarCell[] {
    const byDate = new Map(days.map((day) => [day.checkInDate, day]));
    const [year, month] = this.visibleMonth.split('-').map(Number);
    const firstDay = new Date(year, month - 1, 1);
    const daysInMonth = new Date(year, month, 0).getDate();
    const cells: CalendarCell[] = [];

    for (let i = 0; i < firstDay.getDay(); i += 1) {
      cells.push({ date: '', dayNumber: null, inMonth: false, entry: null });
    }

    for (let day = 1; day <= daysInMonth; day += 1) {
      const date = `${this.visibleMonth}-${String(day).padStart(2, '0')}`;
      cells.push({
        date,
        dayNumber: day,
        inMonth: true,
        entry: byDate.get(date) || null
      });
    }

    while (cells.length % 7 !== 0) {
      cells.push({ date: '', dayNumber: null, inMonth: false, entry: null });
    }

    return cells;
  }

  private getMonthKey(value: Date): string {
    const year = value.getFullYear();
    const month = String(value.getMonth() + 1).padStart(2, '0');
    return `${year}-${month}`;
  }

  private createDefaultBulkEditor(): BulkDailyCheckinEditor {
    const [year, month] = this.visibleMonth.split('-').map(Number);
    const firstDate = `${this.visibleMonth}-01`;
    const lastDate = `${this.visibleMonth}-${String(new Date(year, month, 0).getDate()).padStart(2, '0')}`;
    const startDate = this.activeStartDate && this.activeStartDate > firstDate && this.activeStartDate <= lastDate
      ? this.activeStartDate
      : firstDate;

    return {
      startDate,
      endDate: lastDate,
      marker: 'activeOther',
      value: true,
      noWorkout: false,
      noSteps: false,
      stepsCount: null,
      notes: ''
    };
  }

  private getDateKeysBetween(startDate: string, endDate: string): string[] {
    if (!startDate || !endDate || startDate > endDate) return [];

    const keys: string[] = [];
    const cursor = this.parseDateKey(startDate);
    const last = this.parseDateKey(endDate);

    if (!cursor || !last) return [];

    while (cursor <= last) {
      const dateKey = this.getDateKey(cursor);
      if (this.isTrackableDate(dateKey)) {
        keys.push(dateKey);
      }
      cursor.setDate(cursor.getDate() + 1);
    }

    return keys;
  }

  private parseDateKey(value: string): Date | null {
    const [year, month, day] = value.split('-').map(Number);
    if (!year || !month || !day) return null;
    return new Date(year, month - 1, day);
  }

  private getDateKey(value: Date): string {
    const month = String(value.getMonth() + 1).padStart(2, '0');
    const day = String(value.getDate()).padStart(2, '0');
    return `${value.getFullYear()}-${month}-${day}`;
  }

  private getBulkMarkerValue(entry: DailyCheckinDay | undefined, marker: DailyActivityMarker): boolean {
    if (this.bulkEditor.marker === marker) {
      return this.bulkEditor.value;
    }
    return Boolean(entry?.[marker]);
  }

  private isActiveMarker(marker: DailyActivityMarker): boolean {
    return marker !== 'notActive'
      && marker !== 'workoutNotCompleted'
      && marker !== 'workoutVideoNotShared'
      && marker !== 'stepsRecordNotShared';
  }
}
