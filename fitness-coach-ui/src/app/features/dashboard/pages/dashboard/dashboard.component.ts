import { Component, ElementRef, inject, OnInit, ViewChild } from '@angular/core';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { BillingApiService } from '../../../../core/api/billing-api.service';
import { catchError, forkJoin, map, of } from 'rxjs';
import { WorkoutApiService } from '../../../../core/services/workout-api.service';
import { DietApiService } from '../../../../core/services/diet-api.service';
import { ProgressCheckinApiService } from '../../../../core/services/progress-checkin-api.service';
import { NotificationApiService } from '../../../../core/api/notification-api.service';
import { environment } from '../../../../../environments/environment';
import { DailyCheckinApiService, DailyCheckinDay } from '../../../../core/services/daily-checkin-api.service';

type DueSoonMember = {
  id: string;
  fullName: string;
  email: string;
  phone: string;
  planName: string;
  activeSince: string;
  renewalDate: string;
  daysRemaining: number;
  totalPending: number;
  amountSource: string;
};

type CheckinReminderRow = {
  id: string;
  fullName: string;
  email: string;
  phone: string;
  cadenceDays: number;
  lastCheckinDate: string;
  nextCheckinDate: string;
  daysUntilDue: number;
  checkinCount: number;
  cadenceConfigured: boolean;
  latestCheckin: any | null;
  previousCheckin: any | null;
  latestWeight: number | null;
  weightDelta: number | null;
  latestSteps: number | null;
  stepsDelta: number | null;
  latestDietAdherence: number | null;
  latestEnergy: number | null;
  latestExerciseRating: number | null;
  latestNotes: string;
};

type PendingReviewRow = {
  memberId: string;
  fullName: string;
  email: string;
  checkinDate: string;
  status: string;
};

type FollowUpPriority = 'ON_TRACK' | 'NEEDS_CHECK_IN' | 'FOLLOW_UP_RECOMMENDED' | 'RE_ENGAGEMENT_NEEDED';

type FollowUpRequiredRow = {
  id: string;
  fullName: string;
  phone: string;
  weeklyScore: number;
  previousWeeklyScore: number | null;
  trend: 'up' | 'down' | 'stable';
  daysSinceActivity: number | null;
  lastActivityDate: string;
  status: FollowUpPriority;
  statusLabel: string;
  generatedMessage: string;
  sending: boolean;
  sendStatus: string;
};

type FollowUpSummary = {
  onTrack: number;
  needsCheckIn: number;
  followUpRecommended: number;
  reEngagementNeeded: number;
};

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  @ViewChild('checkinReminderSnapshot') checkinReminderSnapshot?: ElementRef<HTMLElement>;
  @ViewChild('billingSnapshot') billingSnapshot?: ElementRef<HTMLElement>;

  private readonly dueSoonDays = 7;
  private readonly router = inject(Router);

  totalMembers = 0;
  loading = true;
  kpiLoading = true;
  activePlanCount = 0;
  activeWorkoutPlanCount = 0;
  activeDietPlanCount = 0;
  monthlyRevenue = 0;
  revenueTrendLabel = 'No revenue last month';
  weeklyCheckinCount = 0;
  pendingReviewCount = 0;
  pendingReviewRows: PendingReviewRow[] = [];
  dueSoonMembers: DueSoonMember[] = [];
  selectedDueMember: DueSoonMember | null = null;
  snapshotDraftAmount: number | null = null;
  snapshotDraftRenewalDate = '';
  dueSoonLoading = true;
  members: any[] = [];
  checkinReminderRows: CheckinReminderRow[] = [];
  checkinReminderLoading = true;
  checkinCadenceMemberId = '';
  checkinCadenceDays = 7;
  activeSmartPanel: 'checkins' | 'billing' = 'checkins';
  selectedCheckinMember: CheckinReminderRow | null = null;
  checkinShareStatus = '';
  billingShareStatus = '';
  sendingCheckinWhatsApp = false;
  sendingBillingWhatsApp = false;
  followUpRows: FollowUpRequiredRow[] = [];
  followUpLoading = true;
  followUpSummary: FollowUpSummary = {
    onTrack: 0,
    needsCheckIn: 0,
    followUpRecommended: 0,
    reEngagementNeeded: 0
  };

  constructor(
    private memberApi: MemberApiService,
    private billingApi: BillingApiService,
    private workoutApi: WorkoutApiService,
    private dietApi: DietApiService,
    private progressCheckinApi: ProgressCheckinApiService,
    private notificationApi: NotificationApiService,
    private dailyCheckinApi: DailyCheckinApiService
  ) {}

  ngOnInit() {
    this.loadStats();
  }

  loadStats() {
    this.memberApi.getMembers().subscribe({
      next: (res: any) => {
        const members = res || [];
        const activeMembers = members.filter((member: any) => this.isActiveMember(member));
        this.members = activeMembers;
        this.totalMembers = activeMembers.length || 0;
        if (
          this.checkinCadenceMemberId &&
          !activeMembers.some((member: any) => member.id === this.checkinCadenceMemberId)
        ) {
          this.checkinCadenceMemberId = '';
        }
        if (!this.checkinCadenceMemberId && activeMembers.length) {
          this.checkinCadenceMemberId = activeMembers[0].id;
          this.checkinCadenceDays = this.getStoredCheckinCadenceDays(activeMembers[0].id) || 7;
        }
        this.loading = false;
        this.loadDueSoonBilling(activeMembers);
        this.loadDashboardKpis(activeMembers);
      },
      error: () => {
        this.loading = false;
        this.kpiLoading = false;
        this.dueSoonLoading = false;
        this.checkinReminderLoading = false;
        this.followUpLoading = false;
      }
    });
  }

  formatCurrency(value: number): string {
    return new Intl.NumberFormat('en-IN', {
      style: 'currency',
      currency: 'INR',
      maximumFractionDigits: 0
    }).format(value || 0);
  }

  formatDate(value: string): string {
    if (!value || value === '-') return '-';

    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return '-';

    return new Intl.DateTimeFormat('en-IN', {
      day: '2-digit',
      month: 'short',
      year: 'numeric'
    }).format(parsed);
  }

  getBillingAttentionLabel(daysRemaining: number): string {
    if (!Number.isFinite(daysRemaining)) return '-';
    if (daysRemaining < 0) return `${Math.abs(daysRemaining)} day${Math.abs(daysRemaining) === 1 ? '' : 's'} overdue`;
    if (daysRemaining === 0) return 'Due today';
    return `${daysRemaining} day${daysRemaining === 1 ? '' : 's'} left`;
  }

  isOverdue(daysRemaining: number): boolean {
    return Number.isFinite(daysRemaining) && daysRemaining < 0;
  }

  selectDueMember(member: DueSoonMember): void {
    this.selectedDueMember = member;
    this.snapshotDraftAmount = member.totalPending;
    this.snapshotDraftRenewalDate = this.normalizeDateInput(member.renewalDate);
  }

  clearSelectedDueMember(): void {
    this.selectedDueMember = null;
    this.snapshotDraftAmount = null;
    this.snapshotDraftRenewalDate = '';
  }

  saveSnapshotEdits(): void {
    if (!this.selectedDueMember) return;

    const amount = Number(this.snapshotDraftAmount) || 0;
    const renewalDate = this.snapshotDraftRenewalDate || this.selectedDueMember.renewalDate;
    const daysRemaining = this.getDaysRemaining(renewalDate);

    const updatedMember = {
      ...this.selectedDueMember,
      totalPending: amount,
      renewalDate,
      daysRemaining,
      amountSource: 'Edited'
    };

    this.dueSoonMembers = this.dueSoonMembers
      .map((member) => member.id === updatedMember.id ? updatedMember : member)
      .sort((a, b) => a.daysRemaining - b.daysRemaining);
    this.selectedDueMember = updatedMember;

    localStorage.setItem(
      this.getSnapshotOverrideStorageKey(updatedMember.id),
      JSON.stringify({ pendingAmount: amount, renewalDate })
    );
  }

  resetSnapshotEdits(): void {
    if (!this.selectedDueMember) return;

    const memberId = this.selectedDueMember.id;
    localStorage.removeItem(this.getSnapshotOverrideStorageKey(memberId));
    this.clearSelectedDueMember();
    this.loadStats();
  }

  onCheckinCadenceMemberChange(): void {
    this.checkinCadenceDays = this.getStoredCheckinCadenceDays(this.checkinCadenceMemberId) || 7;
  }

  saveCheckinCadence(): void {
    if (!this.checkinCadenceMemberId) return;

    localStorage.setItem(
      this.getCheckinCadenceStorageKey(this.checkinCadenceMemberId),
      String(Number(this.checkinCadenceDays) || 7)
    );
    this.loadStats();
  }

  clearCheckinCadence(): void {
    if (!this.checkinCadenceMemberId) return;

    localStorage.removeItem(this.getCheckinCadenceStorageKey(this.checkinCadenceMemberId));
    this.loadStats();
  }

  getCheckinDueLabel(daysUntilDue: number): string {
    if (!Number.isFinite(daysUntilDue)) return '-';
    if (daysUntilDue < 0) return `${Math.abs(daysUntilDue)} day${Math.abs(daysUntilDue) === 1 ? '' : 's'} overdue`;
    if (daysUntilDue === 0) return 'Due today';
    return `${daysUntilDue} day${daysUntilDue === 1 ? '' : 's'} left`;
  }

  isCheckinOverdue(daysUntilDue: number): boolean {
    return Number.isFinite(daysUntilDue) && daysUntilDue < 0;
  }

  get dueCheckinCount(): number {
    return this.checkinReminderRows.filter((member) =>
      member.cadenceConfigured && member.daysUntilDue <= 0
    ).length;
  }

  get billingAttentionCount(): number {
    return this.dueSoonMembers.length;
  }

  get reEngagementNeededCount(): number {
    return this.followUpSummary.reEngagementNeeded;
  }

  get followUpAttentionCount(): number {
    return this.followUpRows.length;
  }

  get recentDashboardAlerts(): { title: string; meta: string; route: string; tone: string }[] {
    const followUps = this.followUpRows.slice(0, 2).map((row) => ({
      title: row.fullName,
      meta: `${row.statusLabel} - ${this.getDaysSinceActivityLabel(row.daysSinceActivity)} since activity`,
      route: '/follow-up-center',
      tone: this.getFollowUpStatusClass(row.status)
    }));

    const checkins = this.checkinReminderRows
      .filter((member) => member.cadenceConfigured && member.daysUntilDue <= 0)
      .slice(0, 2)
      .map((member) => ({
        title: member.fullName,
        meta: `Check-in ${this.getCheckinDueLabel(member.daysUntilDue).toLowerCase()}`,
        route: '/check-in-center',
        tone: 'checkin'
      }));

    const billing = this.dueSoonMembers.slice(0, 2).map((member) => ({
      title: member.fullName,
      meta: `${this.getBillingAttentionLabel(member.daysRemaining)} - ${this.formatCurrency(member.totalPending)}`,
      route: '/billing',
      tone: this.isOverdue(member.daysRemaining) ? 'reengagement' : 'recommended'
    }));

    return [...followUps, ...checkins, ...billing].slice(0, 5);
  }

  getTrendSymbol(trend: FollowUpRequiredRow['trend']): string {
    if (trend === 'up') return '↑';
    if (trend === 'down') return '↓';
    return '→';
  }

  getFollowUpStatusClass(status: FollowUpPriority): string {
    if (status === 'RE_ENGAGEMENT_NEEDED') return 'reengagement';
    if (status === 'FOLLOW_UP_RECOMMENDED') return 'recommended';
    if (status === 'NEEDS_CHECK_IN') return 'checkin';
    return 'track';
  }

  getDaysSinceActivityLabel(days: number | null): string {
    if (days == null) return '60+ days';
    if (days === 0) return 'Today';
    return `${days} day${days === 1 ? '' : 's'}`;
  }

  viewFollowUpMember(row: FollowUpRequiredRow): void {
    const memberId = row?.id || (row as any)?.memberId || (row as any)?._id;
    if (!memberId) return;

    this.router.navigate(['/members', memberId]);
  }

  generateFollowUpMessage(row: FollowUpRequiredRow): void {
    row.generatedMessage = this.buildFollowUpMessage(row);
    row.sendStatus = 'Message generated. Review before sending.';
  }

  sendFollowUpWhatsApp(row: FollowUpRequiredRow): void {
    if (!row.phone) {
      row.sendStatus = 'Add a phone number before sending WhatsApp.';
      return;
    }

    const message = row.generatedMessage || this.buildFollowUpMessage(row);
    row.generatedMessage = message;
    row.sending = true;
    row.sendStatus = 'Sending WhatsApp...';

    this.notificationApi.send({
      memberId: row.id,
      channel: 'WHATSAPP',
      type: 'GENERIC',
      recipient: row.phone,
      message
    }).subscribe({
      next: (res) => {
        row.sending = false;
        row.sendStatus = res.status === 'SENT'
          ? 'WhatsApp sent.'
          : 'WhatsApp send failed. Check notification history.';
      },
      error: () => {
        row.sending = false;
        row.sendStatus = 'Could not send WhatsApp.';
      }
    });
  }

  setSmartPanel(panel: 'checkins' | 'billing'): void {
    this.activeSmartPanel = panel;
  }

  selectCheckinMember(member: CheckinReminderRow): void {
    this.selectedCheckinMember = member;
    this.checkinCadenceMemberId = member.id;
    this.checkinCadenceDays = member.cadenceDays || 7;
  }

  selectPendingReview(row: PendingReviewRow): void {
    const member = this.checkinReminderRows.find((item) => item.id === row.memberId);
    if (!member) return;

    this.activeSmartPanel = 'checkins';
    this.selectCheckinMember(member);
  }

  getCheckinMetricValue(value: number | null, suffix = ''): string {
    if (value == null || !Number.isFinite(value)) return 'NA';
    return `${this.formatSmartNumber(value)}${suffix}`;
  }

  getCheckinDeltaLabel(value: number | null, suffix = ''): string {
    if (value == null || !Number.isFinite(value)) return 'NA';
    const prefix = value > 0 ? '+' : '';
    return `${prefix}${this.formatSmartNumber(value)}${suffix}`;
  }

  getCheckinTrendClass(value: number | null, preferDecrease = false): string {
    if (value == null || !Number.isFinite(value) || value === 0) return '';
    const improved = preferDecrease ? value < 0 : value > 0;
    return improved ? 'trend-positive' : 'trend-negative';
  }

  getCheckinCadenceLabel(member: CheckinReminderRow | null): string {
    if (!member?.cadenceConfigured) return 'Cadence not set';
    return member.cadenceDays === 7 ? 'Weekly' : 'Every 2 weeks';
  }

  getCheckinReminderTitle(member: CheckinReminderRow | null): string {
    if (!member?.cadenceConfigured) return 'Check-in Tracking Setup';
    if (member.daysUntilDue < 0) return 'Check-in Overdue';
    if (member.daysUntilDue === 0) return 'Check-in Due Today';
    return 'Upcoming Check-in';
  }

  getCheckinReminderMessage(member: CheckinReminderRow | null): string {
    if (!member) return '';

    const [firstName, dueLabel, nextDue, formUrl] = this.getCheckinTemplateParameters(member);

    if (!member.cadenceConfigured) {
      return `Hello ${firstName},\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in reminder schedule is being set up. Please share your latest progress update when requested.\n\nCheck-in form: ${formUrl}\n\nPlease review the attached check-in summary and complete your update.`;
    }

    return `Hello ${firstName},\nThis is a progress check-in reminder from TrainWithVarun. Your progress check-in is ${dueLabel}. Please fill the check-in form so we can keep your plan moving.\n\nDue date: ${nextDue}.\n\nCheck-in form: ${formUrl}\n\nPlease review the attached check-in summary and complete your update.`;
  }

  private getCheckinFormLine(): string {
    const url = environment.checkinFormUrl?.trim();
    return url ? ` Check-in form: ${url}` : '';
  }

  private getCheckinTemplateParameters(member: CheckinReminderRow): string[] {
    return [
      this.getFirstName(member.fullName).toUpperCase(),
      member.cadenceConfigured ? this.getCheckinDueLabel(member.daysUntilDue).toLowerCase() : 'due',
      this.formatDate(member.nextCheckinDate),
      environment.checkinFormUrl?.trim() || '-'
    ];
  }

  openCheckinReminderInGmail(): void {
    if (!this.selectedCheckinMember) return;

    const subject = `${this.getCheckinReminderTitle(this.selectedCheckinMember)} - ${this.selectedCheckinMember.fullName}`;
    const body = this.getCheckinReminderMessage(this.selectedCheckinMember);
    const recipient = this.selectedCheckinMember.email || '';
    const url = `https://mail.google.com/mail/?view=cm&fs=1&to=${encodeURIComponent(recipient)}&su=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;

    window.open(url, '_blank', 'noopener');
    this.checkinShareStatus = 'Gmail opened. Attach the downloaded screenshot if needed.';
  }

  async copyCheckinReminderMessage(): Promise<void> {
    const message = this.getCheckinReminderMessage(this.selectedCheckinMember);
    if (!message) return;

    try {
      await navigator.clipboard.writeText(message);
      this.checkinShareStatus = 'Reminder message copied.';
    } catch {
      this.checkinShareStatus = 'Could not copy message in this browser.';
    }
  }

  async downloadCheckinReminderScreenshot(): Promise<void> {
    const element = this.checkinReminderSnapshot?.nativeElement;
    if (!element || !this.selectedCheckinMember) return;

    this.checkinShareStatus = 'Preparing screenshot...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(element);
      const link = document.createElement('a');
      link.download = `${this.slugify(this.selectedCheckinMember.fullName)}-checkin-reminder.png`;
      link.href = imageDataUrl;
      link.click();
      this.checkinShareStatus = 'Screenshot downloaded.';
    } catch {
      this.checkinShareStatus = 'Could not create screenshot.';
    }
  }

  async sendCheckinReminderWhatsApp(): Promise<void> {
    if (!this.selectedCheckinMember || this.sendingCheckinWhatsApp) return;

    if (!this.selectedCheckinMember.phone) {
      this.checkinShareStatus = 'Add a phone number before sending WhatsApp.';
      return;
    }

    this.sendingCheckinWhatsApp = true;
    this.checkinShareStatus = 'Preparing WhatsApp image...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(this.checkinReminderSnapshot?.nativeElement);

      this.notificationApi.send({
        memberId: this.selectedCheckinMember.id,
        channel: 'WHATSAPP',
        type: 'CHECKIN_REMINDER',
        recipient: this.selectedCheckinMember.phone,
        message: this.getCheckinReminderMessage(this.selectedCheckinMember),
        templateParameters: this.getCheckinTemplateParameters(this.selectedCheckinMember),
        imageDataUrl,
        imageFileName: `${this.slugify(this.selectedCheckinMember.fullName)}-checkin-reminder.png`
      }).subscribe({
        next: () => {
          this.sendingCheckinWhatsApp = false;
          this.checkinShareStatus = 'WhatsApp image sent.';
        },
        error: () => {
          this.sendingCheckinWhatsApp = false;
          this.checkinShareStatus = 'Could not send WhatsApp image.';
        }
      });
    } catch {
      this.sendingCheckinWhatsApp = false;
      this.checkinShareStatus = 'Could not create screenshot for WhatsApp.';
    }
  }

  getBillingReminderSubject(member: DueSoonMember | null): string {
    if (!member) return '';
    const status = this.isOverdue(member.daysRemaining) ? 'Billing Overdue' : 'Billing Due Soon';
    return `${status} - ${member.fullName}`;
  }

  getBillingReminderMessage(member: DueSoonMember | null): string {
    if (!member) return '';

    const [firstName, amount, renewalDate, upiId] = this.getBillingTemplateParameters(member);

    return `Hello ${firstName},\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ${amount} to continue your coaching plan.\n\nRenewal date: ${renewalDate}.\n\nYou can pay via UPI ID: ${upiId}. Please review the attached billing snapshot and payment details.`;
  }

  private getBillingTemplateParameters(member: DueSoonMember): string[] {
    return [
      this.getFirstName(member.fullName).toUpperCase(),
      this.formatCurrency(member.totalPending),
      this.formatDate(member.renewalDate),
      this.billingUpiId || '-'
    ];
  }

  get billingUpiId(): string {
    return environment.billingUpiId?.trim() || '';
  }

  get billingQrImageUrl(): string {
    return environment.billingQrImageUrl?.trim() || '';
  }

  openBillingReminderInGmail(): void {
    if (!this.selectedDueMember) return;

    const subject = this.getBillingReminderSubject(this.selectedDueMember);
    const body = this.getBillingReminderMessage(this.selectedDueMember);
    const recipient = this.selectedDueMember.email || '';
    const url = `https://mail.google.com/mail/?view=cm&fs=1&to=${encodeURIComponent(recipient)}&su=${encodeURIComponent(subject)}&body=${encodeURIComponent(body)}`;

    window.open(url, '_blank', 'noopener');
    this.billingShareStatus = 'Gmail opened. Attach the downloaded screenshot if needed.';
  }

  async copyBillingReminderMessage(): Promise<void> {
    const message = this.getBillingReminderMessage(this.selectedDueMember);
    if (!message) return;

    try {
      await navigator.clipboard.writeText(message);
      this.billingShareStatus = 'Reminder message copied.';
    } catch {
      this.billingShareStatus = 'Could not copy message in this browser.';
    }
  }

  async downloadBillingScreenshot(): Promise<void> {
    const element = this.billingSnapshot?.nativeElement;
    if (!element || !this.selectedDueMember) return;

    this.billingShareStatus = 'Preparing screenshot...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(element);
      const link = document.createElement('a');
      link.download = `${this.slugify(this.selectedDueMember.fullName)}-billing-reminder.png`;
      link.href = imageDataUrl;
      link.click();
      this.billingShareStatus = 'Screenshot downloaded.';
    } catch {
      this.billingShareStatus = 'Could not create screenshot.';
    }
  }

  async sendBillingReminderWhatsApp(): Promise<void> {
    if (!this.selectedDueMember || this.sendingBillingWhatsApp) return;

    if (!this.selectedDueMember.phone) {
      this.billingShareStatus = 'Add a phone number before sending WhatsApp.';
      return;
    }

    this.sendingBillingWhatsApp = true;
    this.billingShareStatus = 'Preparing WhatsApp image...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(this.billingSnapshot?.nativeElement);

      this.notificationApi.send({
        memberId: this.selectedDueMember.id,
        channel: 'WHATSAPP',
        type: 'PAYMENT_REMINDER',
        recipient: this.selectedDueMember.phone,
        message: this.getBillingReminderMessage(this.selectedDueMember),
        templateParameters: this.getBillingTemplateParameters(this.selectedDueMember),
        imageDataUrl,
        imageFileName: `${this.slugify(this.selectedDueMember.fullName)}-billing-reminder.png`
      }).subscribe({
        next: (res) => {
          this.sendingBillingWhatsApp = false;
          this.billingShareStatus = res.status === 'SENT'
            ? 'WhatsApp image sent.'
            : 'WhatsApp send failed. Check notification history for Meta error details.';
        },
        error: () => {
          this.sendingBillingWhatsApp = false;
          this.billingShareStatus = 'Could not send WhatsApp image.';
        }
      });
    } catch {
      this.sendingBillingWhatsApp = false;
      this.billingShareStatus = 'Could not create screenshot for WhatsApp.';
    }
  }

  private async captureElementAsImageDataUrl(element?: HTMLElement): Promise<string> {
    if (!element) {
      throw new Error('Missing screenshot element');
    }

    const html2canvas = (await import('html2canvas')).default;
    const canvas = await html2canvas(element, {
      backgroundColor: '#ffffff',
      scale: Math.min(window.devicePixelRatio || 1, 2),
      useCORS: true
    });

    return canvas.toDataURL('image/png');
  }

  private loadDueSoonBilling(members: any[]): void {
    if (!members.length) {
      this.dueSoonMembers = [];
      this.clearSelectedDueMember();
      this.dueSoonLoading = false;
      return;
    }

    const requests = members.map((member) =>
      forkJoin({
        subscription: this.billingApi.getSubscription(member.id).pipe(
          map((res: any[]) => (res?.length ? res[0] : null)),
          catchError(() => of(null))
        ),
        payments: this.billingApi.getPaymentHistory(member.id).pipe(
          catchError(() => of([]))
        )
      }).pipe(
        map(({ subscription, payments }) => {
          const override = this.getStoredOverride(member.id);
          const snapshotOverride = this.getSnapshotOverride(member.id);
          const pendingTotal = (payments || [])
            .filter((payment: any) => payment.status === 'PENDING')
            .reduce((sum: number, payment: any) => sum + (payment.amount || 0), 0);
          const successfulPayments = this.getSuccessfulPayments(payments || []);
          const previousMonthAmount = this.getPreviousMonthSuccessfulAmount(successfulPayments);
          const latestPaidAmount = this.getLatestSuccessfulPaymentAmount(successfulPayments);
          const latestPaidDate = this.getLatestSuccessfulPaymentDate(successfulPayments);
          const subscriptionAmount = this.getSubscriptionAmount(subscription);
          const fallbackAmount = previousMonthAmount || latestPaidAmount || subscriptionAmount;
          const totalPending = snapshotOverride?.pendingAmount ?? (pendingTotal || fallbackAmount);
          const amountSource = snapshotOverride?.pendingAmount != null
            ? 'Edited'
            : pendingTotal > 0
              ? 'Pending payment'
              : previousMonthAmount > 0
                ? 'Last month paid'
                : latestPaidAmount > 0
                  ? 'Last paid amount'
                  : subscriptionAmount > 0
                    ? 'Plan amount'
                    : 'No amount found';
          const baseRenewalDate = snapshotOverride?.renewalDate || override?.renewalDate || subscription?.endDate || '';
          const renewalDate = this.resolveBillingRenewalDate(
            baseRenewalDate,
            latestPaidDate,
            override?.cycle || subscription?.cycle || subscription?.billingCycle || subscription?.duration
          );
          const daysRemaining = this.getDaysRemaining(renewalDate);

          return {
            id: member.id,
            fullName: member.fullName,
            email: member.email,
            phone: member.phone || '',
            planName: this.getBillingPlanName(subscription, override, renewalDate),
            activeSince: this.getMemberCreatedDate(member) || subscription?.startDate || '',
            renewalDate,
            daysRemaining,
            totalPending,
            amountSource
          } as DueSoonMember;
        })
      )
    );

    forkJoin(requests).subscribe({
      next: (rows) => {
        this.dueSoonMembers = rows
          .filter((row) => row.daysRemaining <= this.dueSoonDays)
          .sort((a, b) => a.daysRemaining - b.daysRemaining);
        const refreshedSelectedMember = this.dueSoonMembers.find(
          (row) => row.id === this.selectedDueMember?.id
        ) || null;
        if (refreshedSelectedMember) {
          this.selectDueMember(refreshedSelectedMember);
        }
        this.dueSoonLoading = false;
      },
      error: () => {
        this.dueSoonMembers = [];
        this.clearSelectedDueMember();
        this.dueSoonLoading = false;
      }
    });
  }

  private loadDashboardKpis(members: any[]): void {
    if (!members.length) {
      this.resetKpis();
      this.kpiLoading = false;
      this.checkinReminderRows = [];
      this.checkinReminderLoading = false;
      this.followUpRows = [];
      this.followUpLoading = false;
      return;
    }

    this.kpiLoading = true;
    this.checkinReminderLoading = true;
    this.followUpLoading = true;

    const today = this.startOfDate(new Date());
    const currentWeekStart = this.getReportWeekStart(today);
    const currentWeekEnd = this.addDateDays(currentWeekStart, 6);
    const previousWeekStart = this.addDateDays(currentWeekStart, -7);
    const previousWeekEnd = this.addDateDays(currentWeekStart, -1);
    const activityLookbackStart = this.addDateDays(today, -60);
    const dailyMonthKeys = Array.from(new Set([
      ...this.getMonthKeysBetweenDates(currentWeekStart, currentWeekEnd),
      ...this.getMonthKeysBetweenDates(previousWeekStart, previousWeekEnd),
      ...this.getMonthKeysBetweenDates(activityLookbackStart, today)
    ]));

    const requests = members.map((member) =>
      forkJoin({
        workoutPlans: this.workoutApi.getWorkoutPlan(member.id).pipe(
          catchError(() => of(null))
        ),
        dietPlan: this.dietApi.getDietPlanByMember(member.id).pipe(
          catchError(() => of(null))
        ),
        payments: this.billingApi.getPaymentHistory(member.id).pipe(
          catchError(() => of([]))
        ),
        subscription: this.billingApi.getSubscription(member.id).pipe(
          map((res: any[]) => (res?.length ? res[0] : null)),
          catchError(() => of(null))
        ),
        progressCheckins: this.progressCheckinApi.getCheckinsByMember(member.id).pipe(
          catchError(() => of([]))
        ),
        dailyCalendars: forkJoin(
          dailyMonthKeys.map((month) => this.dailyCheckinApi.getMemberCalendar(member.id, month).pipe(
            catchError(() => of(null))
          ))
        )
      }).pipe(
        map(({ workoutPlans, dietPlan, payments, subscription, progressCheckins, dailyCalendars }) => {
          const weeklyCheckins = (progressCheckins || []).filter((checkin: any) =>
            this.isCurrentWeek(checkin.submittedAt || checkin.checkInDate || checkin.createdAt)
          );
          const dailyDays = (dailyCalendars || []).flatMap((calendar: any) => calendar?.days || []);
          const followUpRow = this.buildFollowUpRequiredRow(
            member,
            workoutPlans,
            subscription,
            dailyDays,
            currentWeekStart,
            currentWeekEnd,
            previousWeekStart,
            previousWeekEnd,
            today
          );

          return {
            workoutCount: this.countActiveWorkoutPlans(workoutPlans),
            dietCount: this.countDietPlans(dietPlan),
            currentMonthRevenue: this.sumPaymentsForMonth(payments || [], 0),
            previousMonthRevenue: this.sumPaymentsForMonth(payments || [], -1),
            weeklyCheckins,
            pendingReviews: weeklyCheckins
              .filter((checkin: any) => this.isPendingReview(checkin))
              .map((checkin: any) => ({
                memberId: member.id,
                fullName: member.fullName,
                email: member.email,
                checkinDate: checkin.submittedAt || checkin.checkInDate || checkin.createdAt || '',
                status: this.getCheckinReviewStatusLabel(checkin)
              } as PendingReviewRow)),
            checkinReminder: this.buildCheckinReminderRow(member, progressCheckins || [], subscription),
            followUpRow
          };
        })
      )
    );

    forkJoin(requests).subscribe({
      next: (rows) => {
        this.activeWorkoutPlanCount = rows.reduce((sum, row) => sum + row.workoutCount, 0);
        this.activeDietPlanCount = rows.reduce((sum, row) => sum + row.dietCount, 0);
        this.activePlanCount = this.activeWorkoutPlanCount + this.activeDietPlanCount;
        this.monthlyRevenue = rows.reduce((sum, row) => sum + row.currentMonthRevenue, 0);
        const previousMonthRevenue = rows.reduce((sum, row) => sum + row.previousMonthRevenue, 0);
        const weeklyCheckins = rows.flatMap((row) => row.weeklyCheckins);

        this.revenueTrendLabel = this.getRevenueTrendLabel(this.monthlyRevenue, previousMonthRevenue);
        this.weeklyCheckinCount = weeklyCheckins.length;
        this.pendingReviewRows = rows.flatMap((row) => row.pendingReviews);
        this.pendingReviewCount = this.pendingReviewRows.length;
        this.checkinReminderRows = rows
          .map((row) => row.checkinReminder)
          .filter((row): row is CheckinReminderRow => !!row)
          .sort((a, b) => {
            if (a.cadenceConfigured !== b.cadenceConfigured) {
              return a.cadenceConfigured ? -1 : 1;
            }
            return a.daysUntilDue - b.daysUntilDue;
          });
        const allFollowUpRows = rows
          .map((row) => row.followUpRow)
          .filter((row): row is FollowUpRequiredRow => !!row);
        this.followUpSummary = this.buildFollowUpSummary(allFollowUpRows);
        this.followUpRows = allFollowUpRows
          .filter((row) => row.status !== 'ON_TRACK')
          .sort((a, b) => this.getFollowUpPriorityRank(a.status) - this.getFollowUpPriorityRank(b.status));
        this.selectedCheckinMember = this.checkinReminderRows.find(
          (member) => member.id === this.selectedCheckinMember?.id
        ) || this.checkinReminderRows[0] || null;
        this.kpiLoading = false;
        this.checkinReminderLoading = false;
        this.followUpLoading = false;
      },
      error: () => {
        this.resetKpis();
        this.kpiLoading = false;
        this.checkinReminderRows = [];
        this.selectedCheckinMember = null;
        this.checkinReminderLoading = false;
        this.followUpRows = [];
        this.followUpSummary = this.buildFollowUpSummary([]);
        this.followUpLoading = false;
      }
    });
  }

  private resetKpis(): void {
    this.activePlanCount = 0;
    this.activeWorkoutPlanCount = 0;
    this.activeDietPlanCount = 0;
    this.monthlyRevenue = 0;
    this.revenueTrendLabel = 'No revenue last month';
    this.weeklyCheckinCount = 0;
    this.pendingReviewCount = 0;
    this.pendingReviewRows = [];
    this.followUpRows = [];
    this.followUpSummary = this.buildFollowUpSummary([]);
  }

  private countActiveWorkoutPlans(value: any): number {
    if (!value) return 0;

    const plans = Array.isArray(value) ? value : [value];
    return plans.filter((plan) => !plan?.status || plan.status === 'ACTIVE').length;
  }

  private countDietPlans(value: any): number {
    if (!value) return 0;

    const plans = Array.isArray(value) ? value : [value];
    return plans.filter((plan) => !plan?.status || plan.status === 'ACTIVE').length;
  }

  private sumPaymentsForMonth(payments: any[], monthOffset: number): number {
    const target = new Date();
    target.setMonth(target.getMonth() + monthOffset);
    const targetMonth = target.getMonth();
    const targetYear = target.getFullYear();

    return this.getSuccessfulPayments(payments)
      .filter((payment: any) => {
        const parsed = new Date(payment.paymentDate || payment.createdAt || payment.updatedAt);
        return !Number.isNaN(parsed.getTime())
          && parsed.getMonth() === targetMonth
          && parsed.getFullYear() === targetYear;
      })
      .reduce((sum: number, payment: any) => sum + (Number(payment.amount) || 0), 0);
  }

  private getRevenueTrendLabel(current: number, previous: number): string {
    if (!previous) {
      return current ? 'No revenue last month' : 'No revenue this month';
    }

    const percentage = Math.round(((current - previous) / previous) * 100);
    const sign = percentage >= 0 ? '+' : '';
    return `${sign}${percentage}% vs last month`;
  }

  private isCurrentWeek(value: string): boolean {
    if (!value) return false;

    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return false;

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const weekStart = new Date(today);
    weekStart.setDate(today.getDate() - today.getDay());

    const weekEnd = new Date(weekStart);
    weekEnd.setDate(weekStart.getDate() + 7);

    return parsed >= weekStart && parsed < weekEnd;
  }

  private isPendingReview(checkin: any): boolean {
    const rawStatus = checkin?.status || checkin?.reviewStatus;
    const status = String(rawStatus || '').toUpperCase();
    if (['REVIEWED', 'APPROVED', 'DONE', 'COMPLETED'].includes(status)) return false;
    if (['PENDING', 'PENDING_REVIEW', 'SUBMITTED', 'NEW'].includes(status)) return true;
    if (typeof checkin?.reviewed === 'boolean') return !checkin.reviewed;
    if (typeof checkin?.isReviewed === 'boolean') return !checkin.isReviewed;
    if (checkin?.reviewedAt) return false;
    return false;
  }

  private getCheckinReviewStatusLabel(checkin: any): string {
    const status = String(checkin?.status || checkin?.reviewStatus || '').trim();
    if (status) return status.replace(/_/g, ' ');
    if (typeof checkin?.reviewed === 'boolean') return checkin.reviewed ? 'Reviewed' : 'Pending';
    if (typeof checkin?.isReviewed === 'boolean') return checkin.isReviewed ? 'Reviewed' : 'Pending';
    return checkin?.reviewedAt ? 'Reviewed' : 'Pending';
  }

  private buildCheckinReminderRow(member: any, checkins: any[], subscription: any | null = null): CheckinReminderRow | null {
    const cadenceDays = this.getStoredCheckinCadenceDays(member.id);
    const latestProgressCheckinDate = this.getLatestProgressCheckinDate(checkins);
    const activeSinceDate = this.getCheckinActiveSinceDate(member, subscription);
    const lastCheckinDate = checkins.length === 1
      ? activeSinceDate
      : latestProgressCheckinDate || activeSinceDate;
    const nextCheckinDate = cadenceDays && lastCheckinDate
      ? this.addDays(lastCheckinDate, cadenceDays)
      : cadenceDays
        ? this.getTodayDateInput()
        : '';
    const daysUntilDue = cadenceDays ? this.getDaysRemaining(nextCheckinDate) : Number.POSITIVE_INFINITY;
    const sortedCheckins = [...checkins].sort(
      (a, b) =>
        this.getCheckinDateValue(b.submittedAt || b.checkInDate || b.createdAt) -
        this.getCheckinDateValue(a.submittedAt || a.checkInDate || a.createdAt)
    );
    const latestCheckin = sortedCheckins[0] || null;
    const previousCheckin = sortedCheckins[1] || null;
    const latestWeight = this.getNumericValue(latestCheckin?.weight);
    const previousWeight = this.getNumericValue(previousCheckin?.weight);
    const latestSteps = this.getNumericValue(latestCheckin?.stepsAvg);
    const previousSteps = this.getNumericValue(previousCheckin?.stepsAvg);
    const latestDietAdherence = this.getNumericValue(latestCheckin?.dietAdherence);
    const latestEnergy = this.getNumericValue(latestCheckin?.energy);
    const latestExerciseRating = this.getNumericValue(
      latestCheckin?.exerciseRating ?? latestCheckin?.energy
    );

    return {
      id: member.id,
      fullName: member.fullName,
      email: member.email,
      phone: member.phone || '',
      cadenceDays,
      lastCheckinDate,
      nextCheckinDate,
      daysUntilDue,
      checkinCount: checkins.length,
      cadenceConfigured: cadenceDays > 0,
      latestCheckin,
      previousCheckin,
      latestWeight,
      weightDelta: latestWeight != null && previousWeight != null
        ? this.roundToTwo(latestWeight - previousWeight)
        : null,
      latestSteps,
      stepsDelta: latestSteps != null && previousSteps != null
        ? this.roundToTwo(latestSteps - previousSteps)
        : null,
      latestDietAdherence,
      latestEnergy,
      latestExerciseRating,
      latestNotes: String(latestCheckin?.notes || '').trim()
    };
  }

  private buildFollowUpRequiredRow(
    member: any,
    workoutPlans: any,
    subscription: any | null,
    dailyDays: DailyCheckinDay[],
    currentWeekStart: Date,
    currentWeekEnd: Date,
    previousWeekStart: Date,
    previousWeekEnd: Date,
    today: Date
  ): FollowUpRequiredRow {
    const activeWorkoutPlan = this.getActiveWorkoutPlan(workoutPlans);
    const currentScore = this.calculateWeeklyConsistencyScore(
      dailyDays,
      currentWeekStart,
      currentWeekEnd,
      activeWorkoutPlan
    );
    const previousScore = this.calculateWeeklyConsistencyScore(
      dailyDays,
      previousWeekStart,
      previousWeekEnd,
      activeWorkoutPlan
    );
    const lastActivityDate = this.getLastActivityDate(dailyDays);
    const fallbackStartDate = this.getFollowUpBaselineDate(member, subscription);
    const activityReferenceDate = lastActivityDate || fallbackStartDate;
    const daysSinceActivity = activityReferenceDate
      ? this.getDaysBetweenDates(this.parseDateKey(activityReferenceDate), today)
      : null;
    const status = this.getFollowUpStatus(currentScore, daysSinceActivity);

    return {
      id: member.id,
      fullName: member.fullName,
      phone: member.phone || '',
      weeklyScore: currentScore,
      previousWeeklyScore: previousScore,
      trend: this.getScoreTrend(currentScore, previousScore),
      daysSinceActivity,
      lastActivityDate: lastActivityDate || '',
      status,
      statusLabel: this.getFollowUpStatusLabel(status),
      generatedMessage: '',
      sending: false,
      sendStatus: ''
    };
  }

  private calculateWeeklyConsistencyScore(
    days: DailyCheckinDay[],
    start: Date,
    end: Date,
    activeWorkoutPlan: any
  ): number {
    const dateKeys = this.getDateKeysBetweenDates(start, end);
    const entriesByDate = new Map((days || []).map((day) => [day.checkInDate, day]));
    const weekEntries = dateKeys.map((date) => entriesByDate.get(date) || null);
    const completedWorkouts = weekEntries.filter((entry) => Boolean(entry?.exerciseDone)).length;
    const totalSteps = weekEntries.reduce((sum, entry) => sum + Math.max(0, Number(entry?.stepsCount || 0)), 0);
    const averageDailySteps = dateKeys.length ? totalSteps / dateKeys.length : 0;
    const plannedWorkouts = Array.isArray(activeWorkoutPlan?.days) ? activeWorkoutPlan.days.length : 0;
    const stepTarget = Math.max(0, Number(activeWorkoutPlan?.targetStepsCount || 0));
    const workoutCompliance = plannedWorkouts > 0
      ? Math.min(100, (Math.max(0, completedWorkouts) / plannedWorkouts) * 100)
      : 0;
    const stepsCompliance = stepTarget > 0
      ? Math.min(100, (Math.max(0, averageDailySteps) / stepTarget) * 100)
      : 0;

    return Math.round((workoutCompliance * 0.7) + (stepsCompliance * 0.3));
  }

  private getActiveWorkoutPlan(value: any): any {
    const plans = Array.isArray(value) ? value : value ? [value] : [];
    return plans.find((plan) => !plan?.status || plan.status === 'ACTIVE') || null;
  }

  private getLastActivityDate(days: DailyCheckinDay[]): string {
    return [...(days || [])]
      .filter((day) => this.isActiveDailyEntry(day))
      .map((day) => day.checkInDate)
      .sort((a, b) => b.localeCompare(a))[0] || '';
  }

  private getFollowUpBaselineDate(member: any, subscription: any | null): string {
    const override = this.getStoredOverride(member.id);
    return this.getMemberCreatedDate(member)
      || this.normalizeDateInput(override?.activeSince || '')
      || this.normalizeDateInput(subscription?.startDate || '')
      || this.normalizeDateInput(subscription?.createdAt || '');
  }

  private isActiveDailyEntry(entry: DailyCheckinDay | null): boolean {
    return Boolean(
      entry?.exerciseDone
      || entry?.stepTargetAchieved
      || entry?.travelWorkout
      || entry?.recoveryDay
      || entry?.activeOther
    );
  }

  private getFollowUpStatus(score: number, daysSinceActivity: number | null): FollowUpPriority {
    if (daysSinceActivity == null || daysSinceActivity >= 7) return 'RE_ENGAGEMENT_NEEDED';
    if (score < 70) return 'FOLLOW_UP_RECOMMENDED';
    if (daysSinceActivity >= 4) return 'NEEDS_CHECK_IN';
    return 'ON_TRACK';
  }

  private getFollowUpStatusLabel(status: FollowUpPriority): string {
    if (status === 'RE_ENGAGEMENT_NEEDED') return 'Re-engagement Needed';
    if (status === 'FOLLOW_UP_RECOMMENDED') return 'Follow-Up Recommended';
    if (status === 'NEEDS_CHECK_IN') return 'Needs Check-In';
    return 'On Track';
  }

  private getScoreTrend(currentScore: number, previousScore: number | null): FollowUpRequiredRow['trend'] {
    if (previousScore == null) return 'stable';
    const difference = currentScore - previousScore;
    if (difference >= 5) return 'up';
    if (difference <= -5) return 'down';
    return 'stable';
  }

  private getFollowUpPriorityRank(status: FollowUpPriority): number {
    if (status === 'RE_ENGAGEMENT_NEEDED') return 1;
    if (status === 'FOLLOW_UP_RECOMMENDED') return 2;
    if (status === 'NEEDS_CHECK_IN') return 3;
    return 4;
  }

  private buildFollowUpSummary(rows: FollowUpRequiredRow[]): FollowUpSummary {
    return {
      onTrack: rows.filter((row) => row.status === 'ON_TRACK').length,
      needsCheckIn: rows.filter((row) => row.status === 'NEEDS_CHECK_IN').length,
      followUpRecommended: rows.filter((row) => row.status === 'FOLLOW_UP_RECOMMENDED').length,
      reEngagementNeeded: rows.filter((row) => row.status === 'RE_ENGAGEMENT_NEEDED').length
    };
  }

  private buildFollowUpMessage(row: FollowUpRequiredRow): string {
    const firstName = this.getFirstName(row.fullName);
    const lastActivity = row.lastActivityDate
      ? `I noticed your last logged activity was on ${this.formatDate(row.lastActivityDate)}.`
      : 'I noticed we have not had a recent activity update logged.';

    if (row.status === 'NEEDS_CHECK_IN') {
      return `Hi ${firstName}, just checking in. ${lastActivity} No pressure if the week has been busy. Send me a quick update and we can adjust the next step to something manageable.`;
    }

    if (row.status === 'RE_ENGAGEMENT_NEEDED') {
      return `Hi ${firstName}, wanted to reconnect and help you restart gently. ${lastActivity} Even a short walk, recovery session, or travel-friendly workout counts. Reply with what feels realistic today.`;
    }

    if (row.status === 'FOLLOW_UP_RECOMMENDED') {
      return `Hi ${firstName}, your weekly consistency score was ${row.weeklyScore}/100. Let us keep the next step simple and focus on one workout or movement win today.`;
    }

    return `Hi ${firstName}, you are on track. Keep the rhythm steady and share today's activity update when you can.`;
  }

  private getLatestProgressCheckinDate(checkins: any[]): string {
    const latest = [...checkins]
      .map((checkin) => checkin.submittedAt || checkin.checkInDate || checkin.createdAt)
      .filter(Boolean)
      .sort((a, b) => new Date(b).getTime() - new Date(a).getTime())[0];

    return latest || '';
  }

  private getCheckinActiveSinceDate(member: any, subscription: any | null): string {
    return this.getMemberCreatedDate(member) || this.normalizeDateInput(subscription?.startDate || '');
  }

  private getMemberCreatedDate(member: any): string {
    return this.normalizeDateInput(member?.createdAt || member?.activeSince || '');
  }

  private getCheckinDateValue(value: string | null | undefined): number {
    if (!value) return 0;

    const parsed = new Date(value);
    return Number.isNaN(parsed.getTime()) ? 0 : parsed.getTime();
  }

  private getDaysRemaining(value: string): number {
    if (!value) return Number.POSITIVE_INFINITY;

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const target = new Date(value);
    if (Number.isNaN(target.getTime())) return Number.POSITIVE_INFINITY;
    target.setHours(0, 0, 0, 0);

    return Math.ceil((target.getTime() - today.getTime()) / (1000 * 60 * 60 * 24));
  }

  private getPreviousMonthSuccessfulAmount(successfulPayments: any[]): number {
    const target = new Date();
    target.setMonth(target.getMonth() - 1);
    const targetMonth = target.getMonth();
    const targetYear = target.getFullYear();

    return successfulPayments
      .filter((payment: any) => {
        const parsed = new Date(payment.paymentDate || payment.createdAt || payment.updatedAt);
        return !Number.isNaN(parsed.getTime())
          && parsed.getMonth() === targetMonth
          && parsed.getFullYear() === targetYear;
      })
      .reduce((sum: number, payment: any) => sum + (Number(payment.amount) || 0), 0);
  }

  private getLatestSuccessfulPaymentAmount(successfulPayments: any[]): number {
    const latestPayment = this.getLatestSuccessfulPayment(successfulPayments);

    return Number(latestPayment?.amount) || 0;
  }

  private getLatestSuccessfulPaymentDate(successfulPayments: any[]): string {
    const latestPayment = this.getLatestSuccessfulPayment(successfulPayments);

    return latestPayment?.paymentDate || latestPayment?.createdAt || latestPayment?.updatedAt || '';
  }

  private getLatestSuccessfulPayment(successfulPayments: any[]): any | null {
    return [...successfulPayments]
      .sort((a: any, b: any) => {
        const first = new Date(a.paymentDate || a.createdAt || a.updatedAt).getTime() || 0;
        const second = new Date(b.paymentDate || b.createdAt || b.updatedAt).getTime() || 0;
        return second - first;
      })[0] || null;
  }

  private getSuccessfulPayments(payments: any[]): any[] {
    return payments.filter((payment: any) =>
      String(payment?.status || '').toUpperCase() === 'SUCCESS'
    );
  }

  private resolveBillingRenewalDate(
    baseRenewalDate: string,
    latestPaidDate: string,
    cycle: string
  ): string {
    const normalizedRenewal = this.normalizeDateInput(baseRenewalDate);
    const normalizedPayment = this.normalizeDateInput(latestPaidDate);
    if (!normalizedPayment) return baseRenewalDate;
    if (!normalizedRenewal) {
      return this.addMonths(normalizedPayment, this.getCycleMonths(cycle));
    }

    const paymentTime = new Date(`${normalizedPayment}T00:00:00`).getTime();
    const renewalTime = new Date(`${normalizedRenewal}T00:00:00`).getTime();
    if (Number.isNaN(paymentTime) || Number.isNaN(renewalTime)) return baseRenewalDate;

    if (paymentTime >= renewalTime) {
      return this.addMonths(normalizedPayment, this.getCycleMonths(cycle));
    }

    return baseRenewalDate;
  }

  private getCycleMonths(cycle: string): number {
    const normalized = String(cycle || '').toUpperCase();
    if (normalized.includes('YEAR') || normalized === '12') return 12;
    if (normalized.includes('QUARTER') || normalized === '3') return 3;
    return 1;
  }

  private getSubscriptionAmount(subscription: any): number {
    return Number(
      subscription?.amount
      || subscription?.price
      || subscription?.monthlyAmount
      || subscription?.planAmount
      || 0
    );
  }

  private getBillingPlanName(subscription: any, override: any | null, renewalDate = ''): string {
    const planName = String(subscription?.planName || '').trim();
    if (planName) return planName;

    const cycle = String(override?.cycle || subscription?.cycle || subscription?.billingCycle || subscription?.duration || '').toUpperCase();
    if (cycle.includes('QUARTER') || cycle === '3') return 'Quarterly';
    if (cycle.includes('YEAR') || cycle === '12') return 'Yearly';
    if (cycle.includes('MONTH') || cycle === '1') return 'Monthly';
    if (override?.activeSince || override?.renewalDate || subscription?.startDate || subscription?.endDate || renewalDate) return 'Monthly';

    return 'No Plan';
  }

  private normalizeDateInput(value: string): string {
    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return '';
    return parsed.toISOString().slice(0, 10);
  }

  private addDays(value: string, days: number): string {
    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return '';
    parsed.setHours(0, 0, 0, 0);
    parsed.setDate(parsed.getDate() + days);
    return parsed.toISOString().slice(0, 10);
  }

  private getReportWeekStart(value: Date): Date {
    const sundayStart = this.getSundayWeekStart(value);
    return value.getDay() === 0 ? this.addDateDays(sundayStart, -7) : sundayStart;
  }

  private getSundayWeekStart(value: Date): Date {
    const date = this.startOfDate(value);
    return this.addDateDays(date, -date.getDay());
  }

  private startOfDate(value: Date): Date {
    return new Date(value.getFullYear(), value.getMonth(), value.getDate());
  }

  private addDateDays(value: Date, days: number): Date {
    const date = new Date(value);
    date.setDate(date.getDate() + days);
    return date;
  }

  private getMonthKeysBetweenDates(start: Date, end: Date): string[] {
    const keys: string[] = [];
    const cursor = new Date(start.getFullYear(), start.getMonth(), 1);
    const last = new Date(end.getFullYear(), end.getMonth(), 1);

    while (cursor <= last) {
      keys.push(this.getMonthKeyFromDate(cursor));
      cursor.setMonth(cursor.getMonth() + 1);
    }

    return keys;
  }

  private getDateKeysBetweenDates(start: Date, end: Date): string[] {
    const keys: string[] = [];
    let cursor = this.startOfDate(start);
    const last = this.startOfDate(end);

    while (cursor <= last) {
      keys.push(this.getDateKeyFromDate(cursor));
      cursor = this.addDateDays(cursor, 1);
    }

    return keys;
  }

  private getMonthKeyFromDate(value: Date): string {
    const month = String(value.getMonth() + 1).padStart(2, '0');
    return `${value.getFullYear()}-${month}`;
  }

  private getDateKeyFromDate(value: Date): string {
    const month = String(value.getMonth() + 1).padStart(2, '0');
    const day = String(value.getDate()).padStart(2, '0');
    return `${value.getFullYear()}-${month}-${day}`;
  }

  private parseDateKey(value: string): Date {
    const [year, month, day] = value.split('-').map(Number);
    return new Date(year, month - 1, day);
  }

  private getDaysBetweenDates(start: Date, end: Date): number {
    const startMs = this.startOfDate(start).getTime();
    const endMs = this.startOfDate(end).getTime();
    return Math.max(0, Math.floor((endMs - startMs) / 86400000));
  }

  private addMonths(value: string, months: number): string {
    const parsed = new Date(`${value}T00:00:00`);
    if (Number.isNaN(parsed.getTime())) return value;

    parsed.setMonth(parsed.getMonth() + months);
    return parsed.toISOString().slice(0, 10);
  }

  private getTodayDateInput(): string {
    return new Date().toISOString().slice(0, 10);
  }

  private getNumericValue(value: any): number | null {
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : null;
  }

  private roundToTwo(value: number): number {
    return Math.round((value + Number.EPSILON) * 100) / 100;
  }

  private formatSmartNumber(value: number): string {
    return Number.isInteger(value) ? String(value) : value.toFixed(2).replace(/\.?0+$/, '');
  }

  private getFirstName(value: string): string {
    return String(value || 'there').trim().split(/\s+/)[0] || 'there';
  }

  private slugify(value: string): string {
    return String(value || 'member')
      .trim()
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '') || 'member';
  }

  private getStoredOverride(memberId: string): any | null {
    const raw = localStorage.getItem(`member_subscription_override_${memberId}`);
    if (!raw) return null;

    try {
      return JSON.parse(raw);
    } catch {
      return null;
    }
  }

  private getSnapshotOverride(memberId: string): any | null {
    const raw = localStorage.getItem(this.getSnapshotOverrideStorageKey(memberId));
    if (!raw) return null;

    try {
      return JSON.parse(raw);
    } catch {
      return null;
    }
  }

  private getSnapshotOverrideStorageKey(memberId: string): string {
    return `dashboard_billing_snapshot_override_${memberId}`;
  }

  private getStoredCheckinCadenceDays(memberId: string): number {
    const raw = localStorage.getItem(this.getCheckinCadenceStorageKey(memberId));
    const value = Number(raw);
    return value === 7 || value === 14 ? value : 0;
  }

  private getCheckinCadenceStorageKey(memberId: string): string {
    return `dashboard_progress_checkin_cadence_${memberId}`;
  }

  private isActiveMember(member: any): boolean {
    return String(member?.status || 'ACTIVE').toUpperCase() !== 'INACTIVE';
  }
}
