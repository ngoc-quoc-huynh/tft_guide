BEGIN;
SELECT plan(1);

-- Test 1: Verify that the function returns an integer.
SELECT function_returns('load_assets_count', 'integer');

SELECT * FROM finish();
ROLLBACK;
