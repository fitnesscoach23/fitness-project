import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-sidebar',
  standalone: true,
  imports: [CommonModule, RouterLink, RouterLinkActive],
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss']
})
export class SidebarComponent {
  readonly navItems = [
    { label: 'Dashboard', route: '/dashboard', icon: 'D' },
    { label: 'Members', route: '/members', icon: 'M' },
    { label: 'Workout Plan', route: '/plans/workouts/create', icon: 'W' },
    { label: 'Diet Plan', route: '/plans/diets/create', icon: 'P' },
    { label: 'Follow-Up Center', route: '/follow-up-center', icon: 'F' },
    { label: 'Check-In Center', route: '/check-in-center', icon: 'C' },
    { label: 'Progress Planner', route: '/progress-planner', icon: 'R' },
    { label: 'Leaderboard', route: '/weekly-consistency-leaderboard', icon: '3' },
    { label: 'Billing', route: '/billing', icon: 'B' },
    { label: 'Notifications', route: '/notifications', icon: 'N' },
    { label: 'Exercise Library', route: '/exercise-library', icon: 'E' },
    { label: 'Diet Library', route: '/diet-library', icon: 'L' }
  ];
}
