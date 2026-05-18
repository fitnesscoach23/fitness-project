ALTER TABLE meals
    ADD COLUMN order_index INT;

ALTER TABLE meals
    ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Optional backfill for existing meals (per plan, ordered by created_at then id)
WITH ranked AS (
    SELECT
        id,
        ROW_NUMBER() OVER (PARTITION BY plan_id ORDER BY created_at ASC, id ASC) - 1 AS rn
    FROM meals
)
UPDATE meals m
SET order_index = r.rn
FROM ranked r
WHERE m.id = r.id;
