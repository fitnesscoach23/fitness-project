import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { environment } from '../../../environments/environment';

export type NotificationChannel = 'EMAIL' | 'SMS' | 'WHATSAPP';
export type NotificationType =
  | 'WELCOME'
  | 'PAYMENT_REMINDER'
  | 'PAYMENT_SUCCESS'
  | 'PAYMENT_FAILED'
  | 'CHECKIN_REMINDER'
  | 'CHECKIN_RECEIVED'
  | 'WEEKLY_CONSISTENCY_REPORT'
  | 'PROGRESS_COMPARISON'
  | 'WORKOUT_PLAN'
  | 'DIET_PLAN'
  | 'GENERIC';
export type NotificationStatus = 'PENDING' | 'SENT' | 'FAILED';

export interface SendNotificationPayload {
  memberId: string;
  channel: NotificationChannel;
  type: NotificationType;
  recipient: string;
  subject?: string;
  message: string;
  imageDataUrl?: string;
  imageFileName?: string;
  documentDataUrl?: string;
  documentFileName?: string;
  templateParameters?: string[];
}

export interface NotificationListItem {
  id: string;
  memberId: string;
  channel: NotificationChannel;
  type: NotificationType;
  recipient: string;
  subject?: string | null;
  message: string;
  status: NotificationStatus;
  errorMessage?: string | null;
  provider?: string | null;
  providerMessageId?: string | null;
  createdAt: string;
  updatedAt: string;
}

@Injectable({
  providedIn: 'root'
})
export class NotificationApiService {
  constructor(private http: HttpClient) {}

  send(payload: SendNotificationPayload) {
    return this.http.post<{ id: string; status: NotificationStatus }>(
      `${environment.notificationApi}/notifications/send`,
      payload
    );
  }

  getById(notificationId: string) {
    return this.http.get<NotificationListItem>(
      `${environment.notificationApi}/notifications/${notificationId}`
    );
  }

  getAll(filters?: {
    memberId?: string | null;
    channel?: NotificationChannel | null;
    status?: NotificationStatus | null;
  }) {
    let params = new HttpParams();
    if (filters?.memberId) {
      params = params.set('memberId', filters.memberId);
    }
    if (filters?.channel) {
      params = params.set('channel', filters.channel);
    }
    if (filters?.status) {
      params = params.set('status', filters.status);
    }

    return this.http.get<NotificationListItem[]>(
      `${environment.notificationApi}/notifications`,
      { params }
    );
  }
}

