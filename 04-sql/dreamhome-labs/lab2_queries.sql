-- A1
SELECT COUNT(*) AS num_properties
FROM Property;

-- A2
SELECT MIN(rent) AS cheapest_rent, MAX(rent) AS dearest_rent
FROM Property;

-- A3
SELECT ROUND(AVG(rent), 2) AS avg_asking_rent
FROM Property;

-- A4
SELECT SUM(salary) AS total_salary_bill, COUNT(*) AS num_staff
FROM Staff;

-- A5
SELECT SUM(rent) AS running_rent_roll
FROM Lease
WHERE rentFinish IS NULL;

-- A6
SELECT COUNT(*)                 AS num_clients,
       COUNT(maxRent)           AS stated_budget,
       COUNT(DISTINCT prefType) AS distinct_pref_types
FROM Client;

-- A7
SELECT ROUND(AVG(maxRent), 2)            AS avg_via_AVG,
       ROUND(SUM(maxRent) * 1.0 / COUNT(*), 2) AS avg_via_SUM_over_COUNT
FROM Client;

-- A8
SELECT COUNT(*) AS num_viewings, COUNT(comment) AS with_comment
FROM Viewing;


/* ---------------- PART B -- GROUP BY ---------------- */

-- B1  one row per city
SELECT city, COUNT(*) AS num_properties
FROM Property
GROUP BY city
ORDER BY num_properties DESC;

-- B2  one row per type
SELECT type, COUNT(*) AS num_properties, ROUND(AVG(rent), 2) AS avg_rent
FROM Property
GROUP BY type;

-- B3  one row per branch
SELECT branchNo, COUNT(*) AS headcount, SUM(salary) AS salary_bill
FROM Staff
GROUP BY branchNo
ORDER BY salary_bill DESC;

-- B4  one row per position
SELECT position, COUNT(*) AS headcount, ROUND(AVG(salary), 2) AS avg_salary
FROM Staff
GROUP BY position;

-- B5  one row per city + type
SELECT city, type, COUNT(*) AS num_properties, ROUND(AVG(rent), 2) AS avg_rent
FROM Property
GROUP BY city, type
ORDER BY city, type;

-- B6  one row per property (that has been viewed)
SELECT propertyNo, COUNT(*) AS num_viewings
FROM Viewing
GROUP BY propertyNo
ORDER BY num_viewings DESC, propertyNo;

-- B7  filter first, then group
SELECT city, COUNT(*) AS num_flats
FROM Property
WHERE type = 'Flat'
GROUP BY city
ORDER BY num_flats DESC;

-- B8  one row per branch
SELECT branchNo, COUNT(*) AS num_clients, ROUND(AVG(maxRent), 2) AS avg_budget
FROM Client
GROUP BY branchNo
ORDER BY avg_budget DESC;


/* ---------------- PART C -- HAVING ---------------- */

-- C1
SELECT city, COUNT(*) AS num_properties
FROM Property
GROUP BY city
HAVING COUNT(*) > 2;

-- C2
SELECT branchNo, SUM(salary) AS salary_bill
FROM Staff
GROUP BY branchNo
HAVING SUM(salary) > 40000
ORDER BY salary_bill DESC;

-- C3
SELECT propertyNo, COUNT(*) AS num_viewings
FROM Viewing
GROUP BY propertyNo
HAVING COUNT(*) > 1
ORDER BY num_viewings DESC, propertyNo;

-- C4
SELECT city, COUNT(*) AS num_flats, ROUND(AVG(rent), 2) AS avg_flat_rent
FROM Property
WHERE type = 'Flat'
GROUP BY city
HAVING COUNT(*) > 1
ORDER BY avg_flat_rent DESC;

-- C5
SELECT branchNo, COUNT(*) AS num_clients
FROM Client
GROUP BY branchNo
HAVING COUNT(*) >= 3;

-- C6  (deliberately broken -- produces an error)
-- SELECT city, COUNT(*) AS num_properties
-- FROM Property
-- WHERE COUNT(*) > 2
-- GROUP BY city;
-- Error: misuse of aggregate: COUNT()


/* ---------------- PART D -- Strings and dates ---------------- */

-- D1
SELECT propertyNo || ' (' || type || ', ' || rooms || ' rooms) - ' || city AS summary
FROM Property;

-- D2
SELECT propertyNo,
       street || ', ' || city || ' ' || postcode AS full_address
FROM Property;

-- D3
SELECT strftime('%Y', dateJoined) AS year_joined, COUNT(*) AS num_clients
FROM Client
GROUP BY year_joined
ORDER BY year_joined;

-- D4
SELECT leaseNo, clientNo, propertyNo, rentStart, rentFinish,
       CAST(julianday(rentFinish) - julianday(rentStart) AS INTEGER) AS days_run
FROM Lease
WHERE rentFinish IS NOT NULL
ORDER BY leaseNo;

-- D5
SELECT strftime('%Y-%m', viewDate) AS view_month, COUNT(*) AS num_viewings
FROM Viewing
GROUP BY view_month
ORDER BY view_month;


/* ---------------- PART E -- The Acquisition Brief ---------------- */

-- E1  DEMAND by type
SELECT prefType,
       COUNT(*)               AS num_clients,
       COUNT(maxRent)         AS stated_budget,
       ROUND(AVG(maxRent), 2) AS avg_budget,
       MAX(maxRent)           AS max_budget
FROM Client
GROUP BY prefType;

-- E2  SUPPLY by type
SELECT type,
       COUNT(*)            AS num_properties,
       ROUND(AVG(rent), 2) AS avg_asking_rent,
       MIN(rent)           AS cheapest,
       MAX(rent)           AS dearest
FROM Property
GROUP BY type;

-- E3  SUPPLY by city
SELECT city,
       COUNT(*)            AS num_properties,
       ROUND(AVG(rent), 2) AS avg_asking_rent
FROM Property
GROUP BY city
ORDER BY num_properties DESC;

-- E4  DEMAND by branch  (B003 Glasgow, B004 Bristol, B005 London, B007 Aberdeen)
SELECT branchNo,
       CASE branchNo WHEN 'B003' THEN 'Glasgow'  WHEN 'B004' THEN 'Bristol'
                     WHEN 'B005' THEN 'London'   WHEN 'B007' THEN 'Aberdeen' END AS city,
       COUNT(*)               AS num_clients,
       COUNT(maxRent)         AS stated_budget,
       ROUND(AVG(maxRent), 2) AS avg_budget
FROM Client
GROUP BY branchNo
ORDER BY num_clients DESC;

-- E5  INTEREST
SELECT propertyNo, COUNT(*) AS num_viewings
FROM Viewing
GROUP BY propertyNo
HAVING COUNT(*) >= 2
ORDER BY num_viewings DESC, propertyNo;

-- E-extra: city x type demand (supports sentence 1)
SELECT CASE branchNo WHEN 'B003' THEN 'Glasgow'  WHEN 'B004' THEN 'Bristol'
                     WHEN 'B005' THEN 'London'   WHEN 'B007' THEN 'Aberdeen' END AS city,
       prefType, COUNT(*) AS num_clients, COUNT(maxRent) AS stated_budget,
       ROUND(AVG(maxRent), 2) AS avg_budget
FROM Client
GROUP BY branchNo, prefType
ORDER BY city, prefType;
