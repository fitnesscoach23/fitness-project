ALTER TABLE members
    ADD COLUMN inactive_at TIMESTAMP NULL;

UPDATE members
SET inactive_at = COALESCE(updated_at, created_at, CURRENT_TIMESTAMP)
WHERE status = 'INACTIVE'
  AND inactive_at IS NULL;
