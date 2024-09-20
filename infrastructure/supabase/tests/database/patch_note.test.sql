BEGIN;
SELECT plan(4);

-- Test 1: Verify that the table exists.
SELECT has_table('patch_note');

-- Test 2: Verify that the "read_only" policy exists on the table for the "public" role.
SELECT policies_are(
    'public',
    'patch_note',
    ARRAY ['read_only']
);

-- Test 3: Verify that the "read_only" policy only applies to the "SELECT" command.
SELECT policy_cmd_is(
  'patch_note',
  'read_only',
  'SELECT',
  'The read_only policy should only allow SELECT commands.'
);

-- Test 4: Verify that the expected number of rows exist in the table.
SELECT results_eq(
  'SELECT COUNT(*)::integer FROM patch_note',
  $$VALUES (1)$$,
  'The patch_note table should have exactly 1 note.'
);

SELECT * FROM finish();
ROLLBACK;