ALTER TABLE daily_member_checkins
    ADD COLUMN activity_status VARCHAR(40);

UPDATE daily_member_checkins
SET activity_status = CASE
    WHEN exercise_done = TRUE THEN 'WORKOUT_COMPLETED'
    WHEN COALESCE(steps_count, 0) > 0 THEN 'STEP_TARGET_ACHIEVED'
    ELSE 'NO_ACTIVITY'
END
WHERE activity_status IS NULL;

ALTER TABLE daily_member_checkins
    ALTER COLUMN activity_status SET NOT NULL,
    ALTER COLUMN activity_status SET DEFAULT 'NO_ACTIVITY';
