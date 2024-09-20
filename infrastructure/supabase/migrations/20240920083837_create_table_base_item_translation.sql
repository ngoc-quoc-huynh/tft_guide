CREATE TABLE IF NOT EXISTS base_item_translation (
    id VARCHAR(50) PRIMARY KEY,
    language_code language_code NOT NULL,
    item_id VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    hint VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES base_item(id) ON DELETE CASCADE
);

-- Function to update updated_at timestamp before each update.
CREATE OR REPLACE FUNCTION update_base_item_translation_updated_at()
RETURNS TRIGGER
SET search_path = ''
VOLATILE
AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update updated_at timestamp.
CREATE TRIGGER trigger_update_base_item_translation_updated_at
BEFORE UPDATE ON base_item_translation
FOR EACH ROW
EXECUTE FUNCTION update_base_item_translation_updated_at();

-- Enable Row-Level Security on the table.
ALTER TABLE base_item_translation
ENABLE ROW LEVEL SECURITY;

-- Policy to allow read-only access to the table.
CREATE POLICY read_only
ON base_item_translation
FOR SELECT
TO public
USING (true);
