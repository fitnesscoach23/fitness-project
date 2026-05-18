ALTER TABLE meal_items
RENAME COLUMN quantity TO quantity_text;

ALTER TABLE meal_items
ADD COLUMN quantity INT;

UPDATE meal_items
SET quantity = NULLIF(regexp_replace(quantity_text, '[^0-9]', '', 'g'), '')::INT;

ALTER TABLE meal_items
DROP COLUMN quantity_text;

ALTER TABLE meal_items
DROP COLUMN calories;

ALTER TABLE meal_items
ADD COLUMN protein INT,
ADD COLUMN carbs INT,
ADD COLUMN fat INT;
