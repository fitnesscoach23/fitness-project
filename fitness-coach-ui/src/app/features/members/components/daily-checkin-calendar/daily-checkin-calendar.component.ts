import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Input, OnChanges, Output, SimpleChanges } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { forkJoin } from 'rxjs';
import {
  DailyCheckinApiService,
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
  stepsCount: number | null;
  notes: string;
}

type BulkStatus = 'ACTIVE' | 'INACTIVE';

interface BulkDailyCheckinEditor {
  startDate: string;
  endDate: string;
  status: BulkStatus;
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
  @Output() checkinsChanged = new EventEmitter<void>();

  readonly weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
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
    }
  }

  get summary(): DailyCheckinSummary {
    return this.calendar?.summary || this.emptySummary;
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
    if (!cell.inMonth || !cell.date) return;

    this.selectedEntry = cell.entry;
    this.editor = {
      checkInDate: cell.date,
      exerciseDone: Boolean(cell.entry?.exerciseDone),
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

    this.saving = true;
    this.error = null;
    this.dailyCheckinApi.upsertDailyCheckin({
      memberId: this.memberId,
      checkInDate: this.editor.checkInDate,
      exerciseDone: this.editor.exerciseDone,
      stepsCount: Math.max(0, Number(this.editor.stepsCount || 0)),
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

    const confirmed = window.confirm(
      `Update ${dateKeys.length} day${dateKeys.length === 1 ? '' : 's'} to ${this.bulkEditor.status.toLowerCase()}?`
    );
    if (!confirmed) return;

    const entriesByDate = new Map((this.calendar?.days || []).map((day) => [day.checkInDate, day]));
    const markActive = this.bulkEditor.status === 'ACTIVE';
    const bulkSteps = this.bulkEditor.stepsCount == null
      ? null
      : Math.max(0, Number(this.bulkEditor.stepsCount || 0));
    const notes = this.bulkEditor.notes.trim();

    this.bulkSaving = true;
    this.error = null;
    this.bulkMessage = null;

    forkJoin(dateKeys.map((checkInDate) => {
      const existing = entriesByDate.get(checkInDate);
      const stepsCount = markActive
        ? (bulkSteps ?? Math.max(0, Number(existing?.stepsCount || 0)))
        : 0;

      return this.dailyCheckinApi.upsertDailyCheckin({
        memberId: this.memberId,
        checkInDate,
        exerciseDone: markActive,
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
    if (!cell.entry) return 'no-entry';
    return cell.entry.active ? 'active-day' : 'inactive-day';
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

    return {
      startDate: firstDate,
      endDate: lastDate,
      status: 'ACTIVE',
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
      keys.push(this.getDateKey(cursor));
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
}
