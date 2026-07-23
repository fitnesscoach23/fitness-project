CREATE TABLE progress_planner_recommendations (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(255) NOT NULL,
    phase_id UUID,
    recommendation_type VARCHAR(60) NOT NULL,
    title VARCHAR(255) NOT NULL,
    suggested_action TEXT NOT NULL,
    reason TEXT NOT NULL,
    supporting_metrics TEXT,
    acceptance_change_type TEXT,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,
    generated_at TIMESTAMP WITH TIME ZONE NOT NULL,
    reviewed_at TIMESTAMP WITH TIME ZONE,
    coach_decision_notes TEXT,
    CONSTRAINT fk_progress_recommendations_member
        FOREIGN KEY (member_id) REFERENCES members(id) ON DELETE CASCADE,
    CONSTRAINT fk_progress_recommendations_phase
        FOREIGN KEY (phase_id) REFERENCES coaching_phases(id) ON DELETE SET NULL
);

CREATE INDEX idx_progress_recommendations_member
    ON progress_planner_recommendations(coach_email, member_id);
CREATE INDEX idx_progress_recommendations_phase
    ON progress_planner_recommendations(phase_id);
CREATE INDEX idx_progress_recommendations_status
    ON progress_planner_recommendations(coach_email, status, priority);
