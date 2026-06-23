import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { forkJoin, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { MemberApiService } from '../../../../core/api/member-api.service';
import {
  DailyCheckinApiService,
  DailyCheckinDay
} from '../../../../core/services/daily-checkin-api.service';

type ActivityFilter = 'pending' | 'all' | 'activeOnly';

type ActivityEntryRow = {
  memberId: string;
  fullName: string;
  email: string;
  status: string;
  existingEntry: DailyCheckinDay | null;
  workoutCompleted: boolean;
  stepsCount: number | null;
  notes: string;
  saving: boolean;
  saved: boolean;
  error: string | null;
};

@Component({
  selector: 'app-activity-entry',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './activity-entry.component.html',
  styleUrls: ['./activity-entry.component.scss']
})
export class ActivityEntryComponent implements OnInit {
  selectedDate = this.getDateKey(this.addDays(new Date(), -1));
  filter: ActivityFilter = 'activeOnly';
  rows: ActivityEntryRow[] = [];
  loading = true;
  savingAll = false;
  message = '';

  constructor(
    private memberApi: MemberApiService,
    private dailyCheckinApi: DailyCheckinApiService
  ) {}

  ngOnInit(): void {
    this.loadRows();
  }

  get filteredRows(): ActivityEntryRow[] {
    if (this.filter === 'pending') {
      return this.rows.filter((row) => this.isActiveMember(row) && !row.existingEntry);
    }

    if (this.filter === 'activeOnly') {
      return this.rows.filter((row) => this.isActiveMember(row));
    }

    return this.rows;
  }

  get pendingCount(): number {
    return this.rows.filter((row) => this.isActiveMember(row) && !row.existingEntry).length;
  }

  get recordedCount(): number {
    return this.rows.length - this.pendingCount;
  }

  onDateChanged(): void {
    this.loadRows();
  }

  setFilter(filter: ActivityFilter): void {
    this.filter = filter;
  }

  loadRows(): void {
    this.loading = true;
    this.message = '';

    this.memberApi.getMembers().subscribe({
      next: (members: any[]) => {
        const sortedMembers = [...(members || [])].sort((a, b) =>
          String(a.fullName || '').localeCompare(String(b.fullName || ''))
        );
        const month = this.selectedDate.slice(0, 7);

        if (!sortedMembers.length) {
          this.rows = [];
          this.loading = false;
          return;
        }

        forkJoin(
          sortedMembers.map((member) =>
            this.dailyCheckinApi.getMemberCalendar(member.id, month).pipe(
              catchError(() => of(null))
            )
          )
        ).subscribe({
          next: (calendars) => {
            this.rows = sortedMembers.map((member, index) => {
              const days = calendars[index]?.days || [];
              const existingEntry = days.find((day) => day.checkInDate === this.selectedDate) || null;

              return {
                memberId: member.id,
                fullName: member.fullName || '-',
                email: member.email || '',
                status: String(member.status || 'ACTIVE').toUpperCase(),
                existingEntry,
                workoutCompleted: Boolean(existingEntry?.exerciseDone),
                stepsCount: existingEntry?.stepsCount ?? null,
                notes: existingEntry?.notes || '',
                saving: false,
                saved: false,
                error: null
              };
            });
            this.loading = false;
          },
          error: () => {
            this.rows = [];
            this.loading = false;
            this.message = 'Failed to load daily activity entries.';
          }
        });
      },
      error: () => {
        this.rows = [];
        this.loading = false;
        this.message = 'Failed to load members.';
      }
    });
  }

  saveRow(row: ActivityEntryRow): void {
    if (row.saving) return;

    row.saving = true;
    row.saved = false;
    row.error = null;

    const payload = this.buildPayload(row);
    this.dailyCheckinApi.upsertDailyCheckin(payload).subscribe({
      next: (saved) => {
        row.existingEntry = saved;
        row.workoutCompleted = Boolean(saved.exerciseDone);
        row.stepsCount = saved.stepsCount ?? null;
        row.notes = saved.notes || '';
        row.saving = false;
        row.saved = true;
      },
      error: () => {
        row.saving = false;
        row.error = 'Save failed';
      }
    });
  }

  saveAll(): void {
    const rows = this.filteredRows;
    if (!rows.length || this.savingAll) return;

    this.savingAll = true;
    this.message = '';
    rows.forEach((row) => {
      row.saving = true;
      row.saved = false;
      row.error = null;
    });

    forkJoin(rows.map((row) =>
      this.dailyCheckinApi.upsertDailyCheckin(this.buildPayload(row)).pipe(
        catchError(() => of(null))
      )
    )).subscribe((results) => {
      results.forEach((saved, index) => {
        const row = rows[index];
        row.saving = false;
        if (saved) {
          row.existingEntry = saved;
          row.workoutCompleted = Boolean(saved.exerciseDone);
          row.stepsCount = saved.stepsCount ?? null;
          row.notes = saved.notes || '';
          row.saved = true;
        } else {
          row.error = 'Save failed';
        }
      });

      const failed = rows.filter((row) => row.error).length;
      this.savingAll = false;
      this.message = failed
        ? `Saved ${rows.length - failed} entries. ${failed} failed.`
        : `Saved ${rows.length} activity entries.`;
    });
  }

  isActiveMember(row: ActivityEntryRow): boolean {
    return row.status !== 'INACTIVE';
  }

  private buildPayload(row: ActivityEntryRow) {
    const stepsCount = Math.max(0, Number(row.stepsCount || 0));
    const hasWorkout = Boolean(row.workoutCompleted);
    const hasSteps = stepsCount > 0;
    const existing = row.existingEntry;
    const hasOtherActiveMarker = Boolean(
      existing?.travelWorkout
      || existing?.recoveryDay
      || existing?.activeOther
    );

    return {
      memberId: row.memberId,
      checkInDate: this.selectedDate,
      exerciseDone: hasWorkout,
      stepsCount,
      stepTargetAchieved: hasSteps,
      travelWorkout: Boolean(existing?.travelWorkout),
      recoveryDay: Boolean(existing?.recoveryDay),
      activeOther: Boolean(existing?.activeOther),
      notActive: !hasWorkout && !hasSteps && !hasOtherActiveMarker,
      notes: row.notes.trim() || null
    };
  }

  private addDays(value: Date, days: number): Date {
    const date = new Date(value);
    date.setDate(date.getDate() + days);
    return date;
  }

  private getDateKey(value: Date): string {
    const month = String(value.getMonth() + 1).padStart(2, '0');
    const day = String(value.getDate()).padStart(2, '0');
    return `${value.getFullYear()}-${month}-${day}`;
  }
}
