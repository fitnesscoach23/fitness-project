CREATE TABLE diet_plans (
    id UUID PRIMARY KEY,
    member_id UUID NOT NULL,
    coach_email VARCHAR(120) NOT NULL,
    title VARCHAR(100) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE meals (
    id UUID PRIMARY KEY,
    plan_id UUID NOT NULL REFERENCES diet_plans(id),
    meal_name VARCHAR(100) NOT NULL
);

CREATE TABLE meal_items (
    id UUID PRIMARY KEY,
    meal_id UUID NOT NULL REFERENCES meals(id),
    food_name VARCHAR(200) NOT NULL,
    quantity VARCHAR(50),
    unit VARCHAR(50),
    calories INT
);
