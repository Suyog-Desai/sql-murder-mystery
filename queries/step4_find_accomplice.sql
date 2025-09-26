-- Step 4: Find the motivator/accomplice
SELECT *
FROM interview
WHERE person_id = '67318';

-- Step 5: Identify the motivator based on traits
SELECT p.id, p.name
FROM drivers_license dl
INNER JOIN person p
    ON p.license_id = dl.id
WHERE dl.height BETWEEN 65 AND 67
  AND dl.gender = 'female'
  AND dl.hair_color = 'red'
  AND dl.car_make = 'Tesla'
  AND dl.car_model = 'Model S'
  AND p.id IN (
      SELECT person_id
      FROM facebook_event_checkin
      WHERE event_name LIKE '%SQL Symphony%'
        AND date LIKE '201712%'
      GROUP BY person_id
      HAVING COUNT(*) = 3
  );