CREATE POLICY read_only
ON storage.objects
AS PERMISSIVE FOR SELECT
TO public
USING (true);
