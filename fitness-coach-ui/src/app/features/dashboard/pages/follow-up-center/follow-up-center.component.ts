import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { BillingApiService } from '../../../../core/api/billing-api.service';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { NotificationApiService } from '../../../../core/api/notification-api.service';
import { DailyCheckinApiService } from '../../../../core/services/daily-checkin-api.service';
import { DietApiService } from '../../../../core/services/diet-api.service';
import { ProgressCheckinApiService } from '../../../../core/services/progress-checkin-api.service';
import { WorkoutApiService } from '../../../../core/services/workout-api.service';
import { DashboardComponent } from '../dashboard/dashboard.component';

type FollowUpSortColumn =
  | 'fullName'
  | 'weeklyScore'
  | 'trend'
  | 'daysSinceActivity'
  | 'status'
  | 'lastActivityDate';

type SortDirection = 'asc' | 'desc';

@Component({
  selector: 'app-follow-up-center',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './follow-up-center.component.html',
  styleUrls: ['../dashboard/dashboard.component.scss', './follow-up-center.component.scss']
})
export class FollowUpCenterComponent extends DashboardComponent {
  sortColumn: FollowUpSortColumn = 'status';
  sortDirection: SortDirection = 'asc';

  constructor(
    memberApi: MemberApiService,
    billingApi: BillingApiService,
    workoutApi: WorkoutApiService,
    dietApi: DietApiService,
    progressCheckinApi: ProgressCheckinApiService,
    notificationApi: NotificationApiService,
    dailyCheckinApi: DailyCheckinApiService
  ) {
    super(
      memberApi,
      billingApi,
      workoutApi,
      dietApi,
      progressCheckinApi,
      notificationApi,
      dailyCheckinApi
    );
  }

  get sortedFollowUpRows(): any[] {
    const direction = this.sortDirection === 'asc' ? 1 : -1;

    return [...this.followUpRows].sort((first, second) => {
      const firstValue = this.getSortValue(first, this.sortColumn);
      const secondValue = this.getSortValue(second, this.sortColumn);

      if (typeof firstValue === 'number' && typeof secondValue === 'number') {
        return (firstValue - secondValue) * direction;
      }

      return String(firstValue).localeCompare(String(secondValue), undefined, {
        sensitivity: 'base',
        numeric: true
      }) * direction;
    });
  }

  sortBy(column: FollowUpSortColumn): void {
    if (this.sortColumn === column) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
      return;
    }

    this.sortColumn = column;
    this.sortDirection = column === 'fullName' ? 'asc' : 'desc';
  }

  getSortLabel(column: FollowUpSortColumn): string {
    if (this.sortColumn !== column) return 'Sort';
    return this.sortDirection === 'asc' ? 'Sorted ascending' : 'Sorted descending';
  }

  getSortIndicator(column: FollowUpSortColumn): string {
    if (this.sortColumn !== column) return '';
    return this.sortDirection === 'asc' ? '↑' : '↓';
  }

  private getSortValue(row: any, column: FollowUpSortColumn): string | number {
    if (column === 'weeklyScore') return Number(row?.weeklyScore ?? -1);
    if (column === 'daysSinceActivity') {
      return row?.daysSinceActivity == null ? Number.MAX_SAFE_INTEGER : Number(row.daysSinceActivity);
    }
    if (column === 'lastActivityDate') {
      const parsed = new Date(row?.lastActivityDate || '').getTime();
      return Number.isNaN(parsed) ? 0 : parsed;
    }
    if (column === 'trend') return this.getTrendRank(row?.trend);
    if (column === 'status') return this.getStatusRank(row?.status);

    return String(row?.fullName || '');
  }

  private getStatusRank(status: string): number {
    if (status === 'RE_ENGAGEMENT_NEEDED') return 1;
    if (status === 'FOLLOW_UP_RECOMMENDED') return 2;
    if (status === 'NEEDS_CHECK_IN') return 3;
    if (status === 'ON_TRACK') return 4;
    return 5;
  }

  private getTrendRank(trend: string): number {
    if (trend === 'down') return 1;
    if (trend === 'stable') return 2;
    if (trend === 'up') return 3;
    return 4;
  }
}
