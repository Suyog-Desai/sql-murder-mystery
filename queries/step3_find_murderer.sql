-- Step 3: Use witness clues to track the murderer
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
SELECT gm.person_id, gm.name
FROM get_fit_now_member gm
INNER JOIN person p
    ON p.id = gm.person_id
INNER JOIN drivers_license dl
    ON dl.id = p.license_id
WHERE gm.id LIKE '48Z%'
  AND gm.membership_status = 'gold'
  AND dl.plate_number LIKE '%H42W%'
  AND gm.id IN (
      SELECT membership_id
      FROM get_fit_now_check_in
      WHERE check_out_time >= (
          SELECT check_in_time
          FROM get_fit_now_check_in
          WHERE check_in_date = 20180109
            AND membership_id = (
                SELECT id
                FROM get_fit_now_member
                WHERE person_id = (
                    SELECT person_id
                    FROM witness
                    WHERE transcript LIKE 'I saw%'
                )
            )
      )
  );