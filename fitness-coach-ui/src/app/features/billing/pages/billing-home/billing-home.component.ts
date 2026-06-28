import { CommonModule } from '@angular/common';
import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { forkJoin, of } from 'rxjs';
import { catchError, map } from 'rxjs/operators';
import { BillingApiService } from '../../../../core/api/billing-api.service';
import { MemberApiService, MemberStatus } from '../../../../core/api/member-api.service';
import { NotificationApiService } from '../../../../core/api/notification-api.service';
import { environment } from '../../../../../environments/environment';

declare const Razorpay: any;

type OverrideCycle = 'MONTHLY' | 'QUARTERLY' | 'YEARLY';

type BillingRow = {
  id: string;
  fullName: string;
  email: string;
  planName: string;
  status: string;
  memberStatus: MemberStatus;
  renewalDate: string;
  totalPaid: number;
  totalPending: number;
  amountSource: string;
};

@Component({
  selector: 'app-billing-home',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './billing-home.component.html',
  styleUrls: ['./billing-home.component.scss']
})
export class BillingHomeComponent implements OnInit {
  @ViewChild('billingReminderSnapshot') billingReminderSnapshot?: ElementRef<HTMLElement>;

  private readonly expirySoonDays = 7;
  members: any[] = [];
  membersLoading = true;
  membersError: string | null = null;

  selectedMemberId = '';
  selectedMember: any = null;

  billingRows: BillingRow[] = [];
  billingRowsLoading = true;

  subscription: any = null;
  subscriptionHistory: any[] = [];
  subscriptionLoading = false;
  payments: any[] = [];
  paymentsLoading = false;

  paymentAmount: number | null = null;
  confirmPaymentDates: Record<string, string> = {};
  paymentActionLoading = false;
  paymentActionError: string | null = null;
  deletingPaymentId: string | null = null;
  deletePaymentError: string | null = null;

  onlineAmount: number | null = null;
  onlinePaymentLoading = false;
  onlinePaymentError: string | null = null;

  totalPaid = 0;
  totalPending = 0;
  pendingAmountSource = 'No amount found';

  overrideActiveSince = '';
  overrideRenewalDate = '';
  overrideCycle: OverrideCycle = 'MONTHLY';
  autoCalculateRenewal = true;
  overrideMessage: string | null = null;
  memberStatusUpdating = false;
  memberStatusError: string | null = null;
  manualPaymentDate = new Date().toISOString().slice(0, 10);
  billingReminderStatus = '';
  sendingBillingReminderWhatsApp = false;

  constructor(
    private memberApi: MemberApiService,
    private billingApi: BillingApiService,
    private notificationApi: NotificationApiService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.loadMembers();
  }

  get displayedActiveSince(): string {
    return this.getSelectedMemberCreatedDate() || this.getOriginalSubscriptionStartDate() || '-';
  }

  get displayedRenewalDate(): string {
    return this.overrideRenewalDate || this.subscription?.endDate || '-';
  }

  get selectedMemberSystemStatus(): 'ACTIVE' | 'INACTIVE' {
    return this.selectedMember?.status === 'INACTIVE' ? 'INACTIVE' : 'ACTIVE';
  }

  get selectedPlanName(): string {
    return this.subscription?.planName || 'No Plan';
  }

  get billingUpiId(): string {
    return environment.billingUpiId?.trim() || '';
  }

  get billingQrImageUrl(): string {
    return environment.billingQrImageUrl?.trim() || '';
  }

  loadMembers(): void {
    this.membersLoading = true;
    this.membersError = null;

    this.memberApi.getMembers().subscribe({
      next: (res: any[]) => {
        this.members = res || [];
        this.membersLoading = false;

        if (this.members.length > 0) {
          this.selectedMemberId = this.members[0].id;
          this.onMemberChange();
        } else {
          this.billingRows = [];
          this.billingRowsLoading = false;
        }

        this.loadAllMemberBilling();
      },
      error: () => {
        this.membersLoading = false;
        this.billingRowsLoading = false;
        this.membersError = 'Failed to load members';
      }
    });
  }

  onMemberChange(): void {
    if (!this.selectedMemberId) {
      this.selectedMember = null;
      this.subscription = null;
      this.payments = [];
      return;
    }

    this.selectedMember = this.members.find((m) => m.id === this.selectedMemberId) || null;
    this.loadSubscriptionOverride();
    this.syncManualPaymentDateWithRenewalDate();
    this.loadSelectedMemberBilling();
  }

  private fetchBillingBundle(memberId: string) {
    const subscription$ = this.billingApi.getSubscription(memberId).pipe(
      map((res: any[]) => (Array.isArray(res) ? res : [])),
      catchError(() => of([]))
    );

    const payments$ = this.billingApi.getPaymentHistory(memberId).pipe(
      catchError(() => of([]))
    );

    return forkJoin({ subscription: subscription$, payments: payments$ });
  }

  private loadSelectedMemberBilling(): void {
    if (!this.selectedMemberId) return;

    this.subscriptionLoading = true;
    this.paymentsLoading = true;

    this.fetchBillingBundle(this.selectedMemberId).subscribe({
      next: ({ subscription, payments }) => {
        this.subscriptionHistory = subscription;
        this.subscription = subscription.length ? subscription[0] : null;
        this.payments = [...(payments || [])];
        this.initializeConfirmPaymentDates();
        this.calculatePaymentSummary();

        const originalStartDate = this.getOriginalSubscriptionStartDate();
        this.overrideActiveSince = this.getSelectedMemberCreatedDate() || this.normalizeDateInput(originalStartDate || '');
        if (!this.overrideRenewalDate && this.subscription?.endDate) {
          this.overrideRenewalDate = this.normalizeDateInput(this.subscription.endDate);
        }
        this.syncManualPaymentDateWithRenewalDate();

        this.subscriptionLoading = false;
        this.paymentsLoading = false;
      },
      error: () => {
        this.subscriptionLoading = false;
        this.paymentsLoading = false;
      }
    });
  }

  loadAllMemberBilling(): void {
    if (!this.members.length) {
      this.billingRows = [];
      this.billingRowsLoading = false;
      return;
    }

    this.billingRowsLoading = true;

    const requests = this.members.map((member) =>
      this.fetchBillingBundle(member.id).pipe(
        map(({ subscription, payments }) => {
          const latestSubscription = subscription.length ? subscription[0] : null;
          const totalPaid = (payments || [])
            .filter((p: any) => p.status === 'SUCCESS')
            .reduce((sum: number, p: any) => sum + (p.amount || 0), 0);
          const pendingSummary = this.getPendingAmountSummary(member.id, latestSubscription, payments || []);

          return {
            id: member.id,
            fullName: member.fullName,
            email: member.email,
            planName: latestSubscription?.planName || 'No Plan',
            status: latestSubscription?.status || 'NO_PLAN',
            renewalDate: this.resolveRenewalDate(member.id, latestSubscription),
            memberStatus: member.status === 'INACTIVE' ? 'INACTIVE' : 'ACTIVE',
            totalPaid,
            totalPending: pendingSummary.amount,
            amountSource: pendingSummary.source
          } as BillingRow;
        })
      )
    );

    forkJoin(requests).subscribe({
      next: (rows) => {
        this.billingRows = rows.sort((a, b) => b.totalPending - a.totalPending);
        this.autoMarkOverdueMembersInactive(this.billingRows);
        this.billingRowsLoading = false;
      },
      error: () => {
        this.billingRowsLoading = false;
      }
    });
  }

  onOverrideActiveSinceChange(): void {
    if (this.autoCalculateRenewal) {
      this.applyCycleToRenewal();
    }
  }

  onOverrideCycleChange(): void {
    if (this.autoCalculateRenewal) {
      this.applyCycleToRenewal();
    }
  }

  saveSubscriptionOverride(): void {
    this.overrideMessage = null;

    if (!this.selectedMemberId) {
      this.overrideMessage = 'Select a member first';
      return;
    }

    const activeSince = this.getSelectedMemberCreatedDate() || this.overrideActiveSince;
    this.overrideActiveSince = activeSince;

    if (!activeSince) {
      this.overrideMessage = 'Member creation date is required';
      return;
    }

    if (this.autoCalculateRenewal) {
      this.applyCycleToRenewal();
    }

    if (!this.overrideRenewalDate) {
      this.overrideMessage = 'Renewal Date is required';
      return;
    }

    const payload = {
      activeSince,
      renewalDate: this.overrideRenewalDate,
      cycle: this.overrideCycle,
      autoCalculate: this.autoCalculateRenewal
    };

    localStorage.setItem(this.getOverrideStorageKey(this.selectedMemberId), JSON.stringify(payload));
    this.overrideMessage = 'Subscription override saved';
    this.syncManualPaymentDateWithRenewalDate();
    this.loadAllMemberBilling();
  }

  clearSubscriptionOverride(): void {
    if (!this.selectedMemberId) return;

    localStorage.removeItem(this.getOverrideStorageKey(this.selectedMemberId));
    this.overrideMessage = 'Subscription override cleared';
    this.overrideCycle = 'MONTHLY';
    this.autoCalculateRenewal = true;
    this.overrideActiveSince = this.getSelectedMemberCreatedDate();
    this.overrideRenewalDate = this.subscription?.endDate
      ? this.normalizeDateInput(this.subscription.endDate)
      : '';

    this.syncManualPaymentDateWithRenewalDate();
    this.loadAllMemberBilling();
  }

  private applyCycleToRenewal(): void {
    if (!this.overrideActiveSince) return;

    const cycleMonths =
      this.overrideCycle === 'MONTHLY' ? 1 : this.overrideCycle === 'QUARTERLY' ? 3 : 12;

    const start = new Date(`${this.overrideActiveSince}T00:00:00`);
    if (Number.isNaN(start.getTime())) return;

    start.setMonth(start.getMonth() + cycleMonths);
    this.overrideRenewalDate = start.toISOString().slice(0, 10);
    this.syncManualPaymentDateWithRenewalDate();
  }

  private loadSubscriptionOverride(): void {
    if (!this.selectedMemberId) return;

    const stored = this.getStoredOverride(this.selectedMemberId);
    if (!stored) {
      this.overrideCycle = 'MONTHLY';
      this.autoCalculateRenewal = true;
      this.overrideActiveSince = this.getSelectedMemberCreatedDate();
      this.overrideRenewalDate = '';
      this.overrideMessage = null;
      return;
    }

    this.overrideActiveSince = this.getSelectedMemberCreatedDate();
    this.overrideRenewalDate = stored.renewalDate || '';
    this.overrideCycle = stored.cycle || 'MONTHLY';
    this.autoCalculateRenewal = stored.autoCalculate ?? true;
    this.overrideMessage = null;
  }

  private getStoredOverride(memberId: string): any | null {
    const raw = localStorage.getItem(this.getOverrideStorageKey(memberId));
    if (!raw) return null;

    try {
      return JSON.parse(raw);
    } catch {
      return null;
    }
  }

  private getOverrideStorageKey(memberId: string): string {
    return `member_subscription_override_${memberId}`;
  }

  private resolveRenewalDate(memberId: string, subscription: any): string {
    const override = this.getStoredOverride(memberId);
    if (override?.renewalDate) {
      return override.renewalDate;
    }

    if (memberId === this.selectedMemberId && this.displayedRenewalDate && this.displayedRenewalDate !== '-') {
      return this.displayedRenewalDate;
    }

    return subscription?.endDate || '-';
  }

  private normalizeDateInput(value: string): string {
    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return '';
    return parsed.toISOString().slice(0, 10);
  }

  startManualPayment(): void {
    if (!this.selectedMemberId || !this.paymentAmount) return;

    const paymentDate = this.getRenewalDateForManualPayment();
    this.manualPaymentDate = paymentDate;

    this.paymentActionLoading = true;
    this.paymentActionError = null;

    this.billingApi.startManualPayment(this.selectedMemberId, this.paymentAmount).subscribe({
      next: (createdPayment: any) => {
        const paymentId = this.getCreatedPaymentId(createdPayment);

        if (paymentId && !this.isSuccessfulPayment(createdPayment)) {
          this.finalizeStartedManualPayment(paymentId, paymentDate);
          return;
        }

        this.paymentActionLoading = false;
        this.paymentAmount = null;
        if (this.isSuccessfulPayment(createdPayment)) {
          this.applyRenewalOverrideFromPaymentDate(paymentDate);
          this.clearDashboardBillingSnapshotForSelectedMember();
        }
        this.loadSelectedMemberBilling();
        this.loadAllMemberBilling();
      },
      error: () => {
        this.paymentActionLoading = false;
        this.paymentActionError = 'Failed to start payment';
      }
    });
  }

  confirmPayment(paymentId: string): void {
    const paymentDate = this.confirmPaymentDates[paymentId] || this.getTodayDateInput();

    this.billingApi.confirmPayment(
      paymentId,
      paymentDate
    ).subscribe({
      next: () => {
        this.clearDashboardBillingSnapshotForSelectedMember();
        this.loadSelectedMemberBilling();
        this.loadAllMemberBilling();
      }
    });
  }

  deletePayment(paymentId: string): void {
    const confirmed = window.confirm('Delete this payment history entry? This action cannot be undone.');
    if (!confirmed) return;

    this.deletingPaymentId = paymentId;
    this.deletePaymentError = null;

    this.billingApi.deletePayment(paymentId).subscribe({
      next: () => {
        this.deletingPaymentId = null;
        this.clearStoredSubscriptionOverrideForSelectedMember();
        this.clearDashboardBillingSnapshotForSelectedMember();
        this.loadSelectedMemberBilling();
        this.loadAllMemberBilling();
      },
      error: () => {
        this.deletingPaymentId = null;
        this.deletePaymentError = 'Failed to delete payment history';
      }
    });
  }

  startOnlinePayment(): void {
    if (!this.selectedMemberId || !this.onlineAmount) return;

    this.onlinePaymentLoading = true;
    this.onlinePaymentError = null;

    this.billingApi.startOnlinePayment(this.selectedMemberId, this.onlineAmount).subscribe({
      next: (order: any) => {
        this.onlinePaymentLoading = false;
        this.onlineAmount = null;
        this.openRazorpayCheckout(order);
      },
      error: () => {
        this.onlinePaymentLoading = false;
        this.onlinePaymentError = 'Failed to start online payment';
      }
    });
  }

  private openRazorpayCheckout(order: any): void {
    const options = {
      key: order.razorpayKeyId,
      amount: order.amount,
      currency: order.currency,
      name: 'Fitness Coach',
      description: 'Subscription Payment',
      order_id: order.razorpayOrderId,
      handler: () => {
        alert('Payment completed. Updating status shortly.');
        setTimeout(() => {
          this.loadSelectedMemberBilling();
          this.loadAllMemberBilling();
        }, 3000);
      },
      prefill: {
        email: this.selectedMember?.email,
        contact: this.selectedMember?.phone
      },
      theme: {
        color: '#2563eb'
      }
    };

    const rzp = new Razorpay(options);
    rzp.open();
  }

  calculatePaymentSummary(): void {
    this.totalPaid = this.payments
      .filter((p) => p.status === 'SUCCESS')
      .reduce((sum, p) => sum + p.amount, 0);

    const pendingSummary = this.getPendingAmountSummary(
      this.selectedMemberId,
      this.subscription,
      this.payments
    );
    this.totalPending = pendingSummary.amount;
    this.pendingAmountSource = pendingSummary.source;
  }

  openMemberProfile(memberId: string): void {
    this.router.navigate(['/members', memberId]);
  }

  openReminderForSelectedMember(): void {
    if (!this.selectedMember) return;

    const subject = 'Payment reminder';
    const message = `Hi ${this.selectedMember.fullName || ''}, your payment is due. Pending amount: ₹${this.totalPending}.`;

    this.router.navigate(['/notifications'], {
      queryParams: {
        memberId: this.selectedMember.id,
        channel: 'EMAIL',
        type: 'PAYMENT_REMINDER',
        recipient: this.selectedMember.email || '',
        subject,
        message
      }
    });
  }

  openReminderForMember(row: BillingRow): void {
    const subject = 'Payment reminder';
    const message = `Hi ${row.fullName || ''}, your payment is due. Pending amount: ₹${row.totalPending}.`;

    this.router.navigate(['/notifications'], {
      queryParams: {
        memberId: row.id,
        channel: 'EMAIL',
        type: 'PAYMENT_REMINDER',
        recipient: row.email || '',
        subject,
        message
      }
    });
  }

  openSelectedBillingReminderCard(): void {
    this.billingReminderStatus = 'Reminder card opened for review.';
  }

  openBillingReminderCardForMember(row: BillingRow): void {
    this.selectedMemberId = row.id;
    this.onMemberChange();
    this.billingReminderStatus = 'Reminder card opened for review.';
  }

  getBillingReminderSubject(): string {
    if (!this.selectedMember) return '';
    const status = this.isExpired(this.displayedRenewalDate) ? 'Billing Overdue' : 'Billing Due Soon';
    return `${status} - ${this.selectedMember.fullName}`;
  }

  getBillingReminderMessage(): string {
    if (!this.selectedMember) return '';

    const [firstName, amount, renewalDate, upiId] = this.getBillingTemplateParameters();

    return `Hello ${firstName},\nThis is a billing reminder from TrainWithVarun. Your membership renewal is pending. Please clear the due amount of ${amount} to continue your coaching plan.\n\nRenewal date: ${renewalDate}.\n\nYou can pay via UPI ID: ${upiId}. Please review the attached billing snapshot and payment details.`;
  }

  openBillingReminderInNotifications(): void {
    if (!this.selectedMember) return;

    this.router.navigate(['/notifications'], {
      queryParams: {
        memberId: this.selectedMember.id,
        channel: 'EMAIL',
        type: 'PAYMENT_REMINDER',
        recipient: this.selectedMember.email || '',
        subject: this.getBillingReminderSubject(),
        message: this.getBillingReminderMessage()
      }
    });
  }

  async copyBillingReminderMessage(): Promise<void> {
    const message = this.getBillingReminderMessage();
    if (!message) return;

    try {
      await navigator.clipboard.writeText(message);
      this.billingReminderStatus = 'Reminder message copied.';
    } catch {
      this.billingReminderStatus = 'Could not copy message in this browser.';
    }
  }

  async downloadBillingReminderCard(): Promise<void> {
    if (!this.selectedMember) return;

    this.billingReminderStatus = 'Preparing screenshot...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(this.billingReminderSnapshot?.nativeElement);
      const link = document.createElement('a');
      link.download = `${this.slugify(this.selectedMember.fullName)}-billing-reminder.png`;
      link.href = imageDataUrl;
      link.click();
      this.billingReminderStatus = 'Reminder card downloaded.';
    } catch {
      this.billingReminderStatus = 'Could not create reminder card screenshot.';
    }
  }

  async sendBillingReminderWhatsApp(): Promise<void> {
    if (!this.selectedMember || this.sendingBillingReminderWhatsApp) return;

    if (!this.selectedMember.phone) {
      this.billingReminderStatus = 'Add a phone number before sending WhatsApp.';
      return;
    }

    this.sendingBillingReminderWhatsApp = true;
    this.billingReminderStatus = 'Preparing WhatsApp reminder...';

    try {
      const imageDataUrl = await this.captureElementAsImageDataUrl(this.billingReminderSnapshot?.nativeElement);

      this.notificationApi.send({
        memberId: this.selectedMember.id,
        channel: 'WHATSAPP',
        type: 'PAYMENT_REMINDER',
        recipient: this.selectedMember.phone,
        message: this.getBillingReminderMessage(),
        templateParameters: this.getBillingTemplateParameters(),
        imageDataUrl,
        imageFileName: `${this.slugify(this.selectedMember.fullName)}-billing-reminder.png`
      }).subscribe({
        next: (res) => {
          this.sendingBillingReminderWhatsApp = false;
          this.billingReminderStatus = res.status === 'SENT'
            ? 'WhatsApp reminder sent.'
            : 'WhatsApp send failed. Check notification history.';
        },
        error: () => {
          this.sendingBillingReminderWhatsApp = false;
          this.billingReminderStatus = 'Could not send WhatsApp reminder.';
        }
      });
    } catch {
      this.sendingBillingReminderWhatsApp = false;
      this.billingReminderStatus = 'Could not create reminder card screenshot.';
    }
  }

  formatDate(value: string): string {
    if (!value || value === '-') return '-';

    const parsed = new Date(value);
    if (Number.isNaN(parsed.getTime())) return value;

    return new Intl.DateTimeFormat('en-IN', { dateStyle: 'medium' }).format(parsed);
  }

  formatCurrency(value: number): string {
    return new Intl.NumberFormat('en-IN', {
      style: 'currency',
      currency: 'INR',
      maximumFractionDigits: 0
    }).format(value || 0);
  }

  getDaysRemaining(renewalDate: string): number | null {
    if (!renewalDate || renewalDate === '-') return null;

    const renewal = new Date(`${renewalDate.slice(0, 10)}T00:00:00`);
    if (Number.isNaN(renewal.getTime())) return null;

    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    const diffMs = renewal.getTime() - today.getTime();

    return Math.ceil(diffMs / (1000 * 60 * 60 * 24));
  }

  getDaysRemainingLabel(renewalDate: string): string {
    const days = this.getDaysRemaining(renewalDate);
    if (days == null) return '-';
    if (days < 0) return `${Math.abs(days)} day(s) overdue`;
    if (days === 0) return 'Due today';
    return `${days} day(s) left`;
  }

  isExpiringSoon(renewalDate: string): boolean {
    const days = this.getDaysRemaining(renewalDate);
    return days != null && days >= 0 && days <= this.expirySoonDays;
  }

  isExpired(renewalDate: string): boolean {
    const days = this.getDaysRemaining(renewalDate);
    return days != null && days < 0;
  }

  setMemberStatus(memberId: string, status: 'ACTIVE' | 'INACTIVE') {
    const row = this.billingRows.find((item) => item.id === memberId);
    if (!row) return;

    this.memberStatusUpdating = true;
    this.memberStatusError = null;
    this.memberApi.patchMemberStatus(memberId, status).subscribe({
      next: () => {
        this.applyMemberStatusLocally(memberId, status);
        this.memberStatusUpdating = false;
      },
      error: (err) => {
        this.memberStatusError = err?.error?.message || 'Failed to update member status';
        this.memberStatusUpdating = false;
      }
    });
  }

  canActivateMember(row: BillingRow): boolean {
    return row.memberStatus !== 'ACTIVE';
  }

  private autoMarkOverdueMembersInactive(rows: BillingRow[]) {
    const overdueMembers = rows.filter(
      (row) => this.isExpired(row.renewalDate) && row.memberStatus !== 'INACTIVE'
    );

    if (!overdueMembers.length) {
      return;
    }

    const calls = overdueMembers.map((row) =>
      this.memberApi.patchMemberStatus(row.id, 'INACTIVE').pipe(
        map(() => row.id),
        catchError(() => of(null))
      )
    );

    forkJoin(calls).subscribe({
      next: (updatedIds) => {
        updatedIds.filter((id): id is string => !!id).forEach((id) => {
          this.applyMemberStatusLocally(id, 'INACTIVE');
        });
      }
    });
  }

  private applyMemberStatusLocally(memberId: string, status: MemberStatus) {
    this.members = this.members.map((member) =>
      member.id === memberId ? { ...member, status } : member
    );
    this.billingRows = this.billingRows.map((row) =>
      row.id === memberId ? { ...row, memberStatus: status } : row
    );
    if (this.selectedMemberId === memberId && this.selectedMember) {
      this.selectedMember = { ...this.selectedMember, status };
    }
  }

  trackByPaymentId(index: number, payment: any): string {
    return payment?.id || String(index);
  }

  trackByMemberId(index: number, row: BillingRow): string {
    return row.id;
  }

  private initializeConfirmPaymentDates(): void {
    const today = this.getTodayDateInput();
    const nextDates: Record<string, string> = {};

    (this.payments || []).forEach((payment) => {
      if (payment?.status === 'PENDING' && payment?.mode === 'MANUAL') {
        nextDates[payment.id] = this.normalizeDateInput(payment.paymentDate) || today;
      }
    });

    this.confirmPaymentDates = nextDates;
  }

  private getTodayDateInput(): string {
    return new Date().toISOString().slice(0, 10);
  }

  private getPendingAmountSummary(
    memberId: string,
    subscription: any,
    payments: any[]
  ): { amount: number; source: string } {
    const snapshotOverride = this.getDashboardBillingSnapshotOverride(memberId);
    const pendingTotal = (payments || [])
      .filter((payment: any) => String(payment?.status || '').toUpperCase() === 'PENDING')
      .reduce((sum: number, payment: any) => sum + (Number(payment.amount) || 0), 0);
    const successfulPayments = this.getSuccessfulPayments(payments || []);
    const previousMonthAmount = this.getPreviousMonthSuccessfulAmount(successfulPayments);
    const latestPaidAmount = this.getLatestSuccessfulPaymentAmount(successfulPayments);
    const subscriptionAmount = this.getSubscriptionAmount(subscription);

    if (snapshotOverride?.pendingAmount != null) {
      return { amount: Number(snapshotOverride.pendingAmount) || 0, source: 'Edited' };
    }

    if (pendingTotal > 0) return { amount: pendingTotal, source: 'Pending payment' };
    if (latestPaidAmount > 0) return { amount: latestPaidAmount, source: 'Last paid amount' };
    if (previousMonthAmount > 0) return { amount: previousMonthAmount, source: 'Last month paid' };
    if (subscriptionAmount > 0) return { amount: subscriptionAmount, source: 'Plan amount' };

    return { amount: 0, source: 'No amount found' };
  }

  private getDashboardBillingSnapshotOverride(memberId: string): any | null {
    const raw = localStorage.getItem(`dashboard_billing_snapshot_override_${memberId}`);
    if (!raw) return null;

    try {
      return JSON.parse(raw);
    } catch {
      return null;
    }
  }

  private getSuccessfulPayments(payments: any[]): any[] {
    return payments.filter((payment: any) =>
      String(payment?.status || '').toUpperCase() === 'SUCCESS'
    );
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
    const latestPayment = [...successfulPayments]
      .sort((a: any, b: any) => {
        const first = new Date(a.paymentDate || a.createdAt || a.updatedAt).getTime() || 0;
        const second = new Date(b.paymentDate || b.createdAt || b.updatedAt).getTime() || 0;
        return second - first;
      })[0] || null;

    return Number(latestPayment?.amount) || 0;
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

  private getBillingTemplateParameters(): string[] {
    return [
      this.getFirstName(this.selectedMember?.fullName),
      this.formatCurrency(this.totalPending),
      this.formatDate(this.displayedRenewalDate),
      this.billingUpiId || '-'
    ];
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

  private getRenewalDateForManualPayment(): string {
    return this.normalizeDateInput(this.displayedRenewalDate) || this.getTodayDateInput();
  }

  private syncManualPaymentDateWithRenewalDate(): void {
    this.manualPaymentDate = this.getRenewalDateForManualPayment();
  }

  private finalizeStartedManualPayment(paymentId: string, paymentDate: string): void {
    this.billingApi.confirmPayment(paymentId, paymentDate).subscribe({
      next: () => {
        this.paymentActionLoading = false;
        this.paymentAmount = null;
        this.applyRenewalOverrideFromPaymentDate(paymentDate);
        this.clearDashboardBillingSnapshotForSelectedMember();
        this.loadSelectedMemberBilling();
        this.loadAllMemberBilling();
      },
      error: () => {
        this.paymentActionLoading = false;
        this.paymentActionError = 'Payment was created, but confirmation failed. Confirm it from Payment History.';
        this.loadSelectedMemberBilling();
        this.loadAllMemberBilling();
      }
    });
  }

  private getCreatedPaymentId(payment: any): string {
    if (typeof payment === 'string') {
      return payment.trim();
    }

    return String(payment?.id || payment?.paymentId || payment?.payment?.id || '').trim();
  }

  private isSuccessfulPayment(payment: any): boolean {
    return String(payment?.status || payment?.payment?.status || '').toUpperCase() === 'SUCCESS';
  }

  private applyRenewalOverrideFromPaymentDate(paymentDate: string): void {
    if (!this.selectedMemberId) return;

    const paidOn = this.normalizeDateInput(paymentDate) || this.getTodayDateInput();
    const nextRenewal = this.addMonths(paidOn, this.getCycleMonths(this.overrideCycle));
    const activeSince = this.getSelectedMemberCreatedDate() || this.overrideActiveSince || paidOn;
    const payload = {
      activeSince,
      renewalDate: nextRenewal,
      cycle: this.overrideCycle,
      autoCalculate: this.autoCalculateRenewal
    };

    localStorage.setItem(this.getOverrideStorageKey(this.selectedMemberId), JSON.stringify(payload));
    this.overrideActiveSince = payload.activeSince;
    this.overrideRenewalDate = payload.renewalDate;
    this.overrideMessage = null;
    this.syncManualPaymentDateWithRenewalDate();
  }

  private getSelectedMemberCreatedDate(): string {
    return this.normalizeDateInput(
      this.selectedMember?.createdAt || this.selectedMember?.activeSince || ''
    );
  }

  private getCycleMonths(cycle: OverrideCycle): number {
    return cycle === 'QUARTERLY' ? 3 : cycle === 'YEARLY' ? 12 : 1;
  }

  private addMonths(value: string, months: number): string {
    const parsed = new Date(`${value}T00:00:00`);
    if (Number.isNaN(parsed.getTime())) return value;

    parsed.setMonth(parsed.getMonth() + months);
    return parsed.toISOString().slice(0, 10);
  }

  private clearDashboardBillingSnapshotForSelectedMember(): void {
    if (!this.selectedMemberId) return;

    localStorage.removeItem(`dashboard_billing_snapshot_override_${this.selectedMemberId}`);
  }

  private clearStoredSubscriptionOverrideForSelectedMember(): void {
    if (!this.selectedMemberId) return;

    localStorage.removeItem(this.getOverrideStorageKey(this.selectedMemberId));
    this.overrideActiveSince = this.getSelectedMemberCreatedDate();
    this.overrideRenewalDate = '';
    this.overrideMessage = null;
  }

  private getOriginalSubscriptionStartDate(): string | null {
    if (!this.subscriptionHistory.length) {
      return this.subscription?.startDate || null;
    }

    const startDates = this.subscriptionHistory
      .map((item) => String(item?.startDate || '').trim())
      .filter(Boolean)
      .sort();

    return startDates[0] || null;
  }
}
