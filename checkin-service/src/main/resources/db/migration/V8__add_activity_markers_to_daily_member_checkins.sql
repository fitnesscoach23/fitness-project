ALTER TABLE daily_member_checkins
    ADD COLUMN step_target_achieved BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN travel_workout BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN recovery_day BOOLEAN NOT NULL DEFAULT FALSE,
    ADD COLUMN active_other BOOLEAN NOT NULL DEFAULT FALSE;

UPDATE daily_member_checkins
SET step_target_achieved = TRUE
WHERE activity_status = 'STEP_TARGET_ACHIEVED'
   OR COALESCE(steps_count, 0) > 0;

UPDATE daily_member_checkins
SET travel_workout = TRUE
WHERE activity_status = 'TRAVEL_WORKOUT';

UPDATE daily_member_checkins
SET recovery_day = TRUE
WHERE activity_status = 'RECOVERY_DAY';

UPDATE daily_member_checkins
SET active_other = TRUE
WHERE activity_status = 'ACTIVE_OTHER';
