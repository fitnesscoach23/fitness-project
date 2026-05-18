CREATE TABLE progress_checkin_photos (
    id UUID PRIMARY KEY,
    check_in_id UUID NOT NULL,

    type VARCHAR(20) NOT NULL, -- FRONT | SIDE | BACK

    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(100) NOT NULL,
    size BIGINT NOT NULL,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Index for fast lookup by check-in
CREATE INDEX idx_progress_checkin_photos_checkin_id
    ON progress_checkin_photos(check_in_id);

-- Optional: prevent duplicate photo type per check-in
-- (uncomment later if you want strict 1-front/1-side/1-back)
-- CREATE UNIQUE INDEX ux_progress_checkin_photos_checkin_type
--     ON progress_checkin_photos(check_in_id, type);
