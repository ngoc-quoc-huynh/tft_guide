CREATE TABLE IF NOT EXISTS base_item (
    id VARCHAR(50) PRIMARY KEY,
    ability_power SMALLINT,
    armor SMALLINT,
    attack_damage SMALLINT,
    attack_speed SMALLINT,
    crit SMALLINT,
    health SMALLINT,
    magic_resist SMALLINT,
    mana SMALLINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Function to update updated_at timestamp before each update.
CREATE OR REPLACE FUNCTION update_base_item_updated_at()
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
CREATE TRIGGER trigger_update_base_item_updated_at
BEFORE UPDATE ON base_item
FOR EACH ROW
EXECUTE FUNCTION update_base_item_updated_at();

-- Enable Row-Level Security on the table.
ALTER TABLE base_item
ENABLE ROW LEVEL SECURITY;

-- Policy to allow read-only access to the table.
CREATE POLICY read_only
ON base_item
FOR SELECT
TO public
USING (true);
