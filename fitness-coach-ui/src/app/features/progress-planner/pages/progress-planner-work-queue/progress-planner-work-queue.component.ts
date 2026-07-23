import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ProgressPlannerApiService } from '../../../../core/api/progress-planner-api.service';

type PlannerFilter =
  | 'ALL'
  | 'WORKOUT'
  | 'DIET'
  | 'STEPS'
  | 'RECOVERY'
  | 'PHASE_REVIEW'
  | 'HIGH_PRIORITY'
  | 'OVERDUE'
  | 'NO_CHANGE_REQUIRED';

@Component({
  selector: 'app-progress-planner-work-queue',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './progress-planner-work-queue.component.html',
  styleUrls: ['./progress-planner-work-queue.component.scss']
})
export class ProgressPlannerWorkQueueComponent implements OnInit {
  rows: any[] = [];
  loading = true;
  error: string | null = null;
  activeFilter: PlannerFilter = 'ALL';

  readonly filters: { label: string; value: PlannerFilter }[] = [
    { label: 'All', value: 'ALL' },
    { label: 'Workout', value: 'WORKOUT' },
    { label: 'Diet', value: 'DIET' },
    { label: 'Steps', value: 'STEPS' },
    { label: 'Recovery', value: 'RECOVERY' },
    { label: 'Phase Review', value: 'PHASE_REVIEW' },
    { label: 'High Priority', value: 'HIGH_PRIORITY' },
    { label: 'Overdue', value: 'OVERDUE' },
    { label: 'No Change Required', value: 'NO_CHANGE_REQUIRED' }
  ];

  constructor(private progressPlannerApi: ProgressPlannerApiService) {}

  ngOnInit(): void {
    this.loadQueue();
  }

  loadQueue(): void {
    this.loading = true;
    this.error = null;
    this.progressPlannerApi.getWorkQueue().subscribe({
      next: (rows) => {
        this.rows = rows || [];
        this.loading = false;
      },
      error: () => {
        this.error = 'Unable to load progress planner queue.';
        this.loading = false;
      }
    });
  }

  get filteredRows(): any[] {
    if (this.activeFilter === 'ALL') return this.rows;
    if (this.activeFilter === 'OVERDUE') return this.rows.filter((row) => row.overdue);
    if (this.activeFilter === 'HIGH_PRIORITY') return this.rows.filter((row) => row.priority === 'HIGH');
    if (this.activeFilter === 'PHASE_REVIEW') return this.rows.filter((row) => row.recommendationType === 'Phase Review');
    if (this.activeFilter === 'NO_CHANGE_REQUIRED') return this.rows.filter((row) => row.recommendationType === 'No Change Required');

    return this.rows.filter((row) =>
      String(row.recommendationType || '').toUpperCase().includes(this.activeFilter.replace('_', ' '))
    );
  }

  postpone(row: any): void {
    row.localStatus = 'Postponed locally';
  }

  markReviewed(row: any): void {
    row.localStatus = 'Reviewed locally';
  }

  formatDate(value: string | null | undefined): string {
    if (!value) return '-';
    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return '-';
    return new Intl.DateTimeFormat('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    }).format(parsed);
  }

  trackByMember(_index: number, row: any): string {
    return row?.phaseId || row?.memberId || String(_index);
  }
}
