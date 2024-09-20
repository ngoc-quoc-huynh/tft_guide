CREATE TABLE IF NOT EXISTS full_item (
    id VARCHAR(50) PRIMARY KEY,
    item_id_1 VARCHAR(50) NOT NULL,
    item_id_2 VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL,
    is_special BOOLEAN NOT NULL DEFAULT FALSE,
    ability_power SMALLINT,
    armor SMALLINT,
    attack_damage SMALLINT,
    attack_speed SMALLINT,
    crit SMALLINT,
    health SMALLINT,
    magic_resist SMALLINT,
    mana SMALLINT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id_1) REFERENCES base_item(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id_2) REFERENCES base_item(id) ON DELETE CASCADE
);

-- Function to update updated_at timestamp before each update.
CREATE OR REPLACE FUNCTION update_full_item_updated_at()
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
CREATE TRIGGER trigger_update_full_item_updated_at
BEFORE UPDATE ON full_item
FOR EACH ROW
EXECUTE FUNCTION update_full_item_updated_at();

-- Enable Row-Level Security on the table.
ALTER TABLE full_item
ENABLE ROW LEVEL SECURITY;

-- Policy to allow read-only access to the table.
CREATE POLICY read_only
ON full_item
FOR SELECT
TO public
USING (true);
