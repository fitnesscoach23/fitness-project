ALTER TABLE daily_member_checkins
    ADD COLUMN not_active BOOLEAN NOT NULL DEFAULT FALSE;

UPDATE daily_member_checkins
SET not_active = TRUE
WHERE activity_status = 'NO_ACTIVITY'
  AND exercise_done = FALSE
  AND step_target_achieved = FALSE
  AND travel_workout = FALSE
  AND recovery_day = FALSE
  AND active_other = FALSE;
