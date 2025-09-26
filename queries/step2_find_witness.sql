-- Step 2: Identify the witnesses
WITH witness AS (
    SELECT person_id, transcript
    FROM interview
    WHERE person_id IN (
        SELECT id
        FROM person
        WHERE name LIKE '%Annabel%'
          AND address_street_name = 'Franklin Ave'

        UNION

        SELECT id
        FROM person
        WHERE address_street_name = 'Northwestern Dr'
          AND address_number = (
              SELECT MAX(address_number)
              FROM person
              WHERE address_street_name = 'Northwestern Dr'
          )
    )
)
SELECT *
FROM witness;