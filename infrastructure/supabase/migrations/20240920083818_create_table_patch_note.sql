CREATE TABLE IF NOT EXISTS patch_note (
    id VARCHAR(100) PRIMARY KEY,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Function to update updated_at timestamp before each update.
CREATE OR REPLACE FUNCTION update_patch_note_updated_at()
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
CREATE TRIGGER trigger_update_patch_note_updated_at
BEFORE UPDATE ON patch_note
FOR EACH ROW
EXECUTE FUNCTION update_patch_note_updated_at();

-- Enable Row-Level Security on the table.
ALTER TABLE patch_note
ENABLE ROW LEVEL SECURITY;

-- Policy to allow read-only access to the table.
CREATE POLICY read_only
ON patch_note
FOR SELECT
TO public
USING (true);
