BEGIN;
SELECT plan(4);

-- Test 1: Verify that the table exists.
SELECT has_table('full_item');

-- Test 2: Verify that the "read_only" policy exists on the table for the "public" role.
SELECT policies_are(
    'public',
    'full_item',
    ARRAY ['read_only']
);

-- Test 3: Verify that the "read_only" policy only applies to the "SELECT" command.
SELECT policy_cmd_is(
  'full_item',
  'read_only',
  'SELECT',
  'The read_only policy should only allow SELECT commands.'
);

-- Test 4: Verify that the expected number of rows exist in the table.
SELECT results_eq(
  'SELECT COUNT(*)::integer FROM full_item',
  $$VALUES (39)$$,
  'The full_item table should have exactly 39 items.'
);

SELECT * FROM finish();
ROLLBACK;