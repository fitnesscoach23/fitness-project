ALTER TABLE progress_checkins
ALTER COLUMN exercise_rating TYPE NUMERIC(3, 1)
USING exercise_rating::NUMERIC(3, 1);
