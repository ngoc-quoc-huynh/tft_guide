BEGIN;
SELECT plan(5);

-- Test 1: Verify that the table exists.
SELECT has_table('full_item_translation');

-- Test 2: Verify that the "read_only" policy exists on the table for the "public" role.
SELECT policies_are(
    'public',
    'full_item_translation',
    ARRAY ['read_only']
);

-- Test 3: Verify that the "read_only" policy only applies to the "SELECT" command.
SELECT policy_cmd_is(
  'full_item_translation',
  'read_only',
  'SELECT',
  'The read_only policy should only allow SELECT commands.'
);

-- Test 4: Verify that the table contains the expected number of rows for language_code 'de',
SELECT results_eq(
  'SELECT COUNT(*)::integer FROM full_item_translation WHERE language_code = ''de''',
  $$VALUES (39)$$,
  'The full_item_translation table should have exactly 39 items for the language_code de.'
);

-- Test 5: Verify that the table contains the expected number of rows for language_code 'en'
SELECT results_eq(
  'SELECT COUNT(*)::integer FROM full_item_translation WHERE language_code = ''en''',
  $$VALUES (39)$$,
  'The full_item_translation table should have exactly 39 items for the language_code en.'
);

SELECT * FROM finish();
ROLLBACK;