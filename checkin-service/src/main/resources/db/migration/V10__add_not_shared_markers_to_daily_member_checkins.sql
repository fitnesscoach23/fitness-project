ALTER TABLE daily_member_checkins
    ADD COLUMN workout_video_not_shared BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN steps_record_not_shared BOOLEAN NOT NULL DEFAULT FALSE;
