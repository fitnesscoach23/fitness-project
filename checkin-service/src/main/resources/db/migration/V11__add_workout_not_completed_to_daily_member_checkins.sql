ALTER TABLE daily_member_checkins
    ADD COLUMN workout_not_completed BOOLEAN NOT NULL DEFAULT FALSE;
