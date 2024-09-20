CREATE OR REPLACE FUNCTION load_assets_count()
RETURNS INTEGER
SET search_path = ''
STABLE
AS $$
BEGIN
    RETURN (
        SELECT COUNT(id)
        FROM storage.objects
        WHERE bucket_id = 'assets'
          AND name LIKE '%.webp'
    );
END;
$$ LANGUAGE plpgsql;
