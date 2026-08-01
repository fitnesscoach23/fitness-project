import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { MemberApiService } from './member-api.service';

describe('MemberApiService', () => {
  let service: MemberApiService;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule]
    });
    service = TestBed.inject(MemberApiService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should return members sorted alphabetically by full name', () => {
    let result: any[] = [];

    service.getMembers().subscribe((members) => {
      result = members;
    });

    const request = httpMock.expectOne((req) => req.url.endsWith('/members'));
    request.flush([
      { id: '3', fullName: 'zara Lane', email: 'zara@example.com' },
      { id: '2', fullName: 'amit Shah', email: 'amit@example.com' },
      { id: '1', fullName: 'Anita Rao', email: 'anita@example.com' }
    ]);

    expect(result.map((member) => member.fullName)).toEqual([
      'amit Shah',
      'Anita Rao',
      'zara Lane'
    ]);
  });
});
