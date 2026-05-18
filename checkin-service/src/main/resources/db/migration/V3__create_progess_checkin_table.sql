CREATE TABLE progress_checkins (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(120) NOT NULL,
    weight NUMERIC(6,2),
    diet_adherence INT,
    energy INT,
    steps_avg INT,
    notes TEXT,
    submitted_at TIMESTAMP NOT NULL
);
