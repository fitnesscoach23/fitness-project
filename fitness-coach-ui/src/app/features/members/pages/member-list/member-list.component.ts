import { Component, OnInit } from '@angular/core';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';

@Component({
  selector: 'app-member-list',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './member-list.component.html',
  styleUrls: ['./member-list.component.scss']
})
export class MemberListComponent implements OnInit {

  members: any[] = [];

  loading = true;
  error: string | null = null;

  constructor(private memberApi: MemberApiService) {}

  ngOnInit() {
    this.loadMembers();
  }

  loadMembers() {
    this.loading = true;
    this.error = null;

    this.memberApi.getMembers().subscribe({
      next: (res: any) => {
        this.members = this.sortMembers(res || []);
        this.loading = false;
      },
      error: (err) => {
        console.error(err);
        this.error = 'Failed to load members';
        this.loading = false;
      }
    });
  }

  getStatusLabel(member: any): string {
    return String(member?.status || 'ACTIVE').toUpperCase();
  }

  getInactiveLabel(member: any): string {
    if (!this.isInactive(member)) {
      return 'Current';
    }

    const days = this.getInactiveDays(member);
    if (days === 0) return 'Inactive today';
    return `Inactive for ${days} day${days === 1 ? '' : 's'}`;
  }

  isInactive(member: any): boolean {
    return this.getStatusLabel(member) === 'INACTIVE';
  }

  private sortMembers(members: any[]): any[] {
    return [...members].sort((a, b) => {
      const aInactive = this.isInactive(a);
      const bInactive = this.isInactive(b);

      if (aInactive !== bInactive) {
        return aInactive ? 1 : -1;
      }

      if (aInactive && bInactive) {
        return this.getInactiveDays(b) - this.getInactiveDays(a);
      }

      return String(a?.fullName || '').localeCompare(String(b?.fullName || ''));
    });
  }

  private getInactiveDays(member: any): number {
    const source = member?.inactiveAt || member?.updatedAt || member?.createdAt;
    const inactiveDate = new Date(source);
    if (Number.isNaN(inactiveDate.getTime())) {
      return 0;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    inactiveDate.setHours(0, 0, 0, 0);

    return Math.max(
      0,
      Math.floor((today.getTime() - inactiveDate.getTime()) / (1000 * 60 * 60 * 24))
    );
  }
}
