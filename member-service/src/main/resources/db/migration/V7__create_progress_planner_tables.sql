CREATE TABLE coaching_phases (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(255) NOT NULL,
    phase_number INTEGER NOT NULL,
    phase_name VARCHAR(255) NOT NULL,
    goal VARCHAR(255),
    start_date DATE NOT NULL,
    planned_end_date DATE,
    actual_end_date DATE,
    status VARCHAR(40) NOT NULL,
    workout_plan_id UUID,
    diet_plan_id UUID,
    calorie_target INTEGER,
    protein_target NUMERIC(10, 2),
    carb_target NUMERIC(10, 2),
    fat_target NUMERIC(10, 2),
    step_target INTEGER,
    planned_workout_days INTEGER,
    phase_notes TEXT,
    coach_reason TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE,
    CONSTRAINT fk_coaching_phases_member
        FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE
);

CREATE INDEX idx_coaching_phases_member ON coaching_phases(member_id);
CREATE INDEX idx_coaching_phases_member_status ON coaching_phases(member_id, status);
CREATE INDEX idx_coaching_phases_review ON coaching_phases(planned_end_date, status);

CREATE TABLE progress_planner_changes (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(255) NOT NULL,
    phase_id UUID,
    change_type VARCHAR(60) NOT NULL,
    change_date DATE NOT NULL,
    previous_value TEXT,
    new_value TEXT,
    reason TEXT NOT NULL,
    coach_notes TEXT,
    source VARCHAR(60) NOT NULL,
    created_by VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    CONSTRAINT fk_progress_planner_changes_member
        FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    CONSTRAINT fk_progress_planner_changes_phase
        FOREIGN KEY (phase_id) REFERENCES coaching_phases(id) ON DELETE SET NULL
);

CREATE INDEX idx_progress_planner_changes_member ON progress_planner_changes(member_id);
CREATE INDEX idx_progress_planner_changes_coach_member ON progress_planner_changes(coach_email, member_id);
CREATE INDEX idx_progress_planner_changes_phase ON progress_planner_changes(phase_id);
CREATE INDEX idx_progress_planner_changes_timeline
    ON progress_planner_changes(member_id, change_date, created_at);
