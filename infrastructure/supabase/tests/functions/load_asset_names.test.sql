BEGIN;
SELECT plan(1);

-- Test 1: Verify that the function returns a set of text.
SELECT function_returns('load_asset_names', 'setof text');

SELECT * FROM finish();
ROLLBACK;
