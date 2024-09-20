CREATE OR REPLACE FUNCTION load_asset_names(last_updated TIMESTAMPTZ DEFAULT NULL)
RETURNS SETOF TEXT
SET search_path = ''
STABLE
AS $$
BEGIN
    RETURN QUERY
    SELECT name
    FROM storage.objects
    WHERE bucket_id = 'assets'
        AND name LIKE '%.webp'
        AND (last_updated IS NULL OR updated_at > last_updated);
END;
$$ LANGUAGE plpgsql;
