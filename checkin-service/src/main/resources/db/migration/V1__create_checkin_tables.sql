CREATE TABLE checkins (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(120) NOT NULL,
    check_in_date DATE NOT NULL,
    weight DECIMAL(5,2),
    compliance INT,
    energy INT,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE measurements (
    id UUID PRIMARY KEY,
    check_in_id UUID NOT NULL REFERENCES checkins(id) ON DELETE CASCADE,
    measurement_name VARCHAR(50) NOT NULL,
    value DECIMAL(6,2) NOT NULL
);
