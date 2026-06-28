import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { BillingApiService } from '../../../../core/api/billing-api.service';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { NotificationApiService } from '../../../../core/api/notification-api.service';
import { DailyCheckinApiService } from '../../../../core/services/daily-checkin-api.service';
import { DietApiService } from '../../../../core/services/diet-api.service';
import { ProgressCheckinApiService } from '../../../../core/services/progress-checkin-api.service';
import { WorkoutApiService } from '../../../../core/services/workout-api.service';
import { DashboardComponent } from '../dashboard/dashboard.component';

@Component({
  selector: 'app-check-in-center',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './check-in-center.component.html',
  styleUrls: ['../dashboard/dashboard.component.scss', './check-in-center.component.scss']
})
export class CheckInCenterComponent extends DashboardComponent {
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
}
