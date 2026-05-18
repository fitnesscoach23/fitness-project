CREATE TABLE food_library_items (
    id UUID PRIMARY KEY,
    food_item VARCHAR(200) NOT NULL,
    calories INT NOT NULL CHECK (calories >= 0),
    carbs INT NOT NULL CHECK (carbs >= 0),
    protein INT NOT NULL CHECK (protein >= 0),
    fats INT NOT NULL CHECK (fats >= 0),
    category VARCHAR(30) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE INDEX idx_food_library_items_category
    ON food_library_items (category);

CREATE INDEX idx_food_library_items_food_item
    ON food_library_items (food_item);
