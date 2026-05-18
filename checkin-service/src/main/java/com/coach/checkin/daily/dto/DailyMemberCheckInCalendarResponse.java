package com.coach.checkin.daily.dto;

import java.util.List;
import java.util.UUID;

public record DailyMemberCheckInCalendarResponse(
        UUID memberId,
        String month,
        List<DailyMemberCheckInDayResponse> days,
        DailyMemberCheckInSummaryResponse summary
) {
}
