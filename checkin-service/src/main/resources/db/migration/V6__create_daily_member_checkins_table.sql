CREATE TABLE daily_member_checkins (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    member_id UUID NOT NULL,
    coach_email VARCHAR(255) NOT NULL,
    check_in_date DATE NOT NULL,
    exercise_done BOOLEAN NOT NULL DEFAULT FALSE,
    steps_count INTEGER,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW()
);

CREATE UNIQUE INDEX ux_daily_member_checkins_member_date_coach
    ON daily_member_checkins(member_id, check_in_date, coach_email);

CREATE INDEX idx_daily_member_checkins_member_coach_date
    ON daily_member_checkins(member_id, coach_email, check_in_date);
