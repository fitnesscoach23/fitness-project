import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';

export type CoachingPhaseStatus =
  | 'PLANNED'
  | 'ACTIVE'
  | 'REVIEW_SOON'
  | 'CHANGE_RECOMMENDED'
  | 'COMPLETED'
  | 'PAUSED';

export type CoachingPhasePayload = {
  phaseNumber?: number | null;
  phaseName: string;
  goal?: string | null;
  startDate: string;
  plannedEndDate?: string | null;
  status?: CoachingPhaseStatus;
  workoutPlanId?: string | null;
  dietPlanId?: string | null;
  calorieTarget?: number | null;
  proteinTarget?: number | null;
  carbTarget?: number | null;
  fatTarget?: number | null;
  stepTarget?: number | null;
  plannedWorkoutDays?: number | null;
  phaseNotes?: string | null;
  coachReason: string;
};

export type PhaseLifecyclePayload = {
  actionDate?: string | null;
  reason: string;
  coachNotes?: string | null;
};

@Injectable({ providedIn: 'root' })
export class ProgressPlannerApiService {
  constructor(private http: HttpClient) {}

  getOverview(memberId: string) {
    return this.http.get<any>(`${environment.memberApi}/members/${memberId}/progress-planner`);
  }

  createPhase(memberId: string, payload: CoachingPhasePayload) {
    return this.http.post<any>(`${environment.memberApi}/members/${memberId}/phases`, payload);
  }

  updatePhase(memberId: string, phaseId: string, payload: CoachingPhasePayload) {
    return this.http.put<any>(`${environment.memberApi}/members/${memberId}/phases/${phaseId}`, payload);
  }

  completePhase(memberId: string, phaseId: string, payload: PhaseLifecyclePayload) {
    return this.http.post<any>(`${environment.memberApi}/members/${memberId}/phases/${phaseId}/complete`, payload);
  }

  pausePhase(memberId: string, phaseId: string, payload: PhaseLifecyclePayload) {
    return this.http.post<any>(`${environment.memberApi}/members/${memberId}/phases/${phaseId}/pause`, payload);
  }

  getWorkQueue() {
    return this.http.get<any[]>(`${environment.memberApi}/members/progress-planner/work-queue`);
  }
}
