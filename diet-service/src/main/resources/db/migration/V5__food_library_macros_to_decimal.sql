DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'food_library_items'
          AND column_name = 'calories'
          AND data_type <> 'numeric'
    ) THEN
        EXECUTE 'ALTER TABLE food_library_items ALTER COLUMN calories TYPE NUMERIC(10,2) USING calories::NUMERIC(10,2)';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'food_library_items'
          AND column_name = 'carbs'
          AND data_type <> 'numeric'
    ) THEN
        EXECUTE 'ALTER TABLE food_library_items ALTER COLUMN carbs TYPE NUMERIC(10,2) USING carbs::NUMERIC(10,2)';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'food_library_items'
          AND column_name = 'protein'
          AND data_type <> 'numeric'
    ) THEN
        EXECUTE 'ALTER TABLE food_library_items ALTER COLUMN protein TYPE NUMERIC(10,2) USING protein::NUMERIC(10,2)';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = 'food_library_items'
          AND column_name = 'fats'
          AND data_type <> 'numeric'
    ) THEN
        EXECUTE 'ALTER TABLE food_library_items ALTER COLUMN fats TYPE NUMERIC(10,2) USING fats::NUMERIC(10,2)';
    END IF;
END $$;
