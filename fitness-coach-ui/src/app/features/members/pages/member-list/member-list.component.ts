import { Component, OnInit } from '@angular/core';
import { MemberApiService } from '../../../../core/api/member-api.service';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-member-list',
  standalone: true,
  imports: [CommonModule, RouterLink, FormsModule],
  templateUrl: './member-list.component.html',
  styleUrls: ['./member-list.component.scss']
})
export class MemberListComponent implements OnInit {

  members: any[] = [];
  searchTerm = '';

  loading = true;
  error: string | null = null;

  constructor(private memberApi: MemberApiService) {}

  ngOnInit() {
    this.loadMembers();
  }

  get filteredMembers(): any[] {
    const search = this.searchTerm.trim().toLowerCase();

    if (!search) {
      return this.members;
    }

    return this.members.filter((member) => {
      const fullName = String(member?.fullName || '').toLowerCase();
      const email = String(member?.email || '').toLowerCase();
      const status = this.getStatusLabel(member).toLowerCase();

      return fullName.includes(search) ||
        email.includes(search) ||
        status.includes(search);
    });
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

  getActiveCount(members = this.members): number {
    return members.filter(member => !this.isInactive(member)).length;
  }

  getInactiveCount(members = this.members): number {
    return members.filter(member => this.isInactive(member)).length;
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
