import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { environment } from '../../../environments/environment';

export type MemberStatus = 'ACTIVE' | 'INACTIVE';

@Injectable({
  providedIn: 'root'
})
export class MemberApiService {

  constructor(private http: HttpClient) { }

  getMembers() {
    return this.http.get<any[]>(
      `${environment.memberApi}/members`
    ).pipe(
      map((members) => this.sortMembersByName(members || []))
    );
  }

  private sortMembersByName(members: any[]): any[] {
    return [...members].sort((a, b) => {
      const aName = this.getMemberSortText(a?.fullName);
      const bName = this.getMemberSortText(b?.fullName);

      if (aName && !bName) return -1;
      if (!aName && bName) return 1;

      const nameCompare = aName.localeCompare(bName, undefined, {
        numeric: true,
        sensitivity: 'base'
      });
      if (nameCompare !== 0) return nameCompare;

      const aFallback = this.getMemberSortText(a?.email || a?.id);
      const bFallback = this.getMemberSortText(b?.email || b?.id);
      return aFallback.localeCompare(bFallback, undefined, {
        numeric: true,
        sensitivity: 'base'
      });
    });
  }

  private getMemberSortText(value: unknown): string {
    return String(value || '').trim();
  }

createMember(payload: any) {
  return this.http.post(
    `${environment.memberApi}/members`,
    payload
  );
}

getMemberById(memberId: string) {
  return this.http.get(
    `${environment.memberApi}/members/${memberId}`
  );
}

getBodyMetrics(memberId: string) {
  return this.http.get(
    `${environment.memberApi}/members/${memberId}/body-metrics`
  );
}

updateBodyMetrics(memberId: string, payload: any) {
  return this.http.put(
    `${environment.memberApi}/members/${memberId}/body-metrics`,
    payload
  );
}

updateMember(memberId: string, payload: any) {
  return this.http.put(
    `${environment.memberApi}/members/${memberId}`,
    payload
  );
}

patchMemberStatus(memberId: string, status: MemberStatus) {
  return this.http.patch(
    `${environment.memberApi}/members/${memberId}/status`,
    { status },
    { responseType: 'text' }
  );
}

deleteMember(memberId: string) {
  return this.http.delete(
    `${environment.memberApi}/members/${memberId}`
  );
}




}
