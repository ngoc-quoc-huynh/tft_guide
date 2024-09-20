CREATE TABLE IF NOT EXISTS patch_note_translation (
    id VARCHAR(100) PRIMARY KEY,
    language_code language_code NOT NULL,
    patch_note_id VARCHAR(100),
    text TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patch_note_id) REFERENCES patch_note(id) ON DELETE CASCADE
);

-- Function to update updated_at timestamp before each update.
CREATE OR REPLACE FUNCTION update_patch_note_translation_updated_at()
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
CREATE TRIGGER trigger_update_patch_note_translation_updated_at
BEFORE UPDATE ON patch_note_translation
FOR EACH ROW
EXECUTE FUNCTION update_patch_note_translation_updated_at();

-- Enable Row-Level Security on the table.
ALTER TABLE patch_note_translation
ENABLE ROW LEVEL SECURITY;

-- Policy to allow read-only access to the table.
CREATE POLICY read_only
ON patch_note_translation
FOR SELECT
TO public
USING (true);
