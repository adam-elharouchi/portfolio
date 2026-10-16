/* ====================================================================
   BAN-0301  Lab: Advanced SQL -- Session 07
   Student: Adam El Harouchi
   Run in DB Browser for SQLite against DreamHome.db (Execute SQL tab).
   Put the cursor inside one query and press Shift+F5 to run only it.
   Part C creates a view and an index: press Write Changes afterwards.
   ==================================================================== */

PRAGMA foreign_keys = ON;

/* ---------------- PART A -- CTEs ---------------- */

-- A1 inner query on its own (4 rows)
SELECT city, ROUND(AVG(rent), 2) AS avgRent
FROM Property
GROUP BY city;

-- A1
WITH cityAvg AS (
    SELECT city, AVG(rent) AS avgRent
    FROM Property
    GROUP BY city
)
SELECT p.propertyNo, p.city, p.type, p.rent, ROUND(ca.avgRent, 2) AS cityAvg
FROM Property p
JOIN cityAvg ca ON ca.city = p.city
WHERE p.rent > ca.avgRent
ORDER BY p.city, p.rent DESC;

-- A2
WITH viewers AS (
    SELECT DISTINCT clientNo FROM Viewing
),
leasers AS (
    SELECT DISTINCT clientNo FROM Lease
)
SELECT c.clientNo, c.name, c.prefType, c.maxRent, c.branchNo
FROM Client c
JOIN viewers v ON v.clientNo = c.clientNo
WHERE c.clientNo NOT IN (SELECT clientNo FROM leasers)
ORDER BY c.maxRent DESC;

-- A3
WITH active AS (
    SELECT * FROM Lease WHERE rentFinish IS NULL
)
SELECT p.branchNo, COUNT(*) AS activeLeases, SUM(a.rent) AS monthlyRent
FROM active a
JOIN Property p ON p.propertyNo = a.propertyNo
GROUP BY p.branchNo
ORDER BY monthlyRent DESC;

-- A3 every branch shown (0 where nothing is active)
WITH active AS (
    SELECT * FROM Lease WHERE rentFinish IS NULL
)
SELECT b.branchNo, b.city, COUNT(a.leaseNo) AS activeLeases,
       COALESCE(SUM(a.rent), 0) AS monthlyRent
FROM Branch b
LEFT JOIN Property p ON p.branchNo = b.branchNo
LEFT JOIN active   a ON a.propertyNo = p.propertyNo
GROUP BY b.branchNo
ORDER BY monthlyRent DESC;


/* ---------------- PART B -- Window functions ---------------- */

-- B1
SELECT staffNo, name, branchNo, salary,
       ROUND(AVG(salary) OVER (PARTITION BY branchNo), 2)          AS branchAvg,
       ROUND(salary - AVG(salary) OVER (PARTITION BY branchNo), 2) AS diffFromAvg
FROM Staff
ORDER BY branchNo, salary DESC;

-- B2 first attempt in WHERE (fails -- see answer)
-- SELECT propertyNo, city, rent,
--        RANK() OVER (PARTITION BY city ORDER BY rent DESC) AS rentRank
-- FROM Property
-- WHERE rentRank = 1;
-- Error: misuse of aliased window function rentRank

-- B2
WITH ranked AS (
    SELECT propertyNo, city, type, rent,
           RANK() OVER (PARTITION BY city ORDER BY rent DESC) AS rentRank
    FROM Property
)
SELECT city, propertyNo, type, rent
FROM ranked
WHERE rentRank = 1
ORDER BY rent DESC;

-- B3
WITH counts AS (
    SELECT propertyNo, COUNT(*) AS views
    FROM Viewing
    GROUP BY propertyNo
)
SELECT propertyNo, views,
       ROW_NUMBER() OVER (ORDER BY views DESC) AS rowNum,
       RANK()       OVER (ORDER BY views DESC) AS rnk,
       DENSE_RANK() OVER (ORDER BY views DESC) AS denseRnk
FROM counts
ORDER BY views DESC, propertyNo;

-- B3 how many properties score <= 3 under each
WITH counts AS (
    SELECT propertyNo, COUNT(*) AS views FROM Viewing GROUP BY propertyNo
),
r AS (
    SELECT ROW_NUMBER() OVER (ORDER BY views DESC) AS rowNum,
           RANK()       OVER (ORDER BY views DESC) AS rnk,
           DENSE_RANK() OVER (ORDER BY views DESC) AS denseRnk
    FROM counts
)
SELECT SUM(rowNum <= 3) AS rowNumberTop3,
       SUM(rnk <= 3)    AS rankTop3,
       SUM(denseRnk <= 3) AS denseRankTop3
FROM r;

-- B4
SELECT clientNo, propertyNo, viewDate,
       ROW_NUMBER() OVER (PARTITION BY clientNo ORDER BY viewDate) AS viewingNo
FROM Viewing
ORDER BY clientNo, viewingNo;

-- B5 running total, default frame (RANGE: ties on rentStart share a total)
SELECT leaseNo, rentStart, rent,
       SUM(rent) OVER (ORDER BY rentStart) AS runningTotal
FROM Lease
ORDER BY rentStart, leaseNo;

-- B5 ROWS frame
SELECT leaseNo, rentStart, rent,
       SUM(rent) OVER (ORDER BY rentStart, leaseNo
                       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS runningTotal
FROM Lease
ORDER BY rentStart, leaseNo;

-- B6
WITH gaps AS (
    SELECT clientNo, propertyNo, viewDate,
           LAG(viewDate) OVER (PARTITION BY clientNo ORDER BY viewDate) AS prevView,
           CAST(julianday(viewDate)
                - julianday(LAG(viewDate) OVER (PARTITION BY clientNo ORDER BY viewDate)) AS INTEGER) AS daysSincePrev
    FROM Viewing
)
SELECT clientNo, propertyNo, prevView, viewDate, daysSincePrev
FROM gaps
WHERE daysSincePrev IS NOT NULL
ORDER BY daysSincePrev DESC;


/* ---------------- PART C -- Views and indexes ---------------- */

-- C1 create the view
DROP VIEW IF EXISTS vPropertyActivity;
CREATE VIEW vPropertyActivity AS
SELECT p.propertyNo, p.city, p.type, p.rent,
       s.name            AS overseenBy,
       COUNT(v.viewDate) AS views,
       MAX(v.viewDate)   AS lastViewed
FROM Property p
LEFT JOIN Staff   s ON s.staffNo    = p.staffNo
LEFT JOIN Viewing v ON v.propertyNo = p.propertyNo
GROUP BY p.propertyNo;

-- C1
SELECT propertyNo, city, type, rent, overseenBy
FROM vPropertyActivity
WHERE views = 0;

-- C2 before
SELECT * FROM vPropertyActivity WHERE propertyNo = 'PL21';

-- C2 insert yesterday's viewing
INSERT INTO Viewing (clientNo, propertyNo, viewDate, comment)
VALUES ('CR83', 'PL21', date('now', '-1 day'), NULL);

-- C2 after
SELECT * FROM vPropertyActivity WHERE propertyNo = 'PL21';

-- C2 clean up
DELETE FROM Viewing WHERE clientNo = 'CR83' AND propertyNo = 'PL21';

-- C3 (fails -- see answer)
-- UPDATE vPropertyActivity SET rent = 950 WHERE propertyNo = 'PL21';
-- Error: cannot modify vPropertyActivity because it is a view

-- C4
EXPLAIN QUERY PLAN SELECT * FROM Viewing WHERE clientNo   = 'CR56';
EXPLAIN QUERY PLAN SELECT * FROM Viewing WHERE propertyNo = 'PA14';

-- C5 fix
CREATE INDEX IF NOT EXISTS idxViewingProperty ON Viewing(propertyNo);
EXPLAIN QUERY PLAN SELECT * FROM Viewing WHERE propertyNo = 'PA14';


/* ---------------- PART D -- The dashboard an AI wrote (fixed versions) ---------------- */

-- Q1 fixed: show ties instead of cutting them at LIMIT 3
WITH counts AS (
    SELECT p.propertyNo, p.city, COUNT(*) AS views
    FROM Property p
    JOIN Viewing v ON v.propertyNo = p.propertyNo
    GROUP BY p.propertyNo
),
ranked AS (
    SELECT *, RANK() OVER (ORDER BY views DESC) AS viewRank FROM counts
)
SELECT propertyNo, city, views, viewRank
FROM ranked
WHERE viewRank <= 3
ORDER BY views DESC, propertyNo;

-- Q2 fixed: count properties, not joined rows
SELECT s.name, s.branchNo, COUNT(p.propertyNo) AS properties
FROM Staff s
LEFT JOIN Property p ON p.staffNo = s.staffNo
GROUP BY s.staffNo
ORDER BY properties ASC, s.name;

-- Q3 fixed: a running lease has rentFinish = NULL
SELECT l.leaseNo, c.name, l.propertyNo, l.rent
FROM Lease l
JOIN Client c ON c.clientNo = l.clientNo
WHERE l.rentFinish IS NULL
   OR l.rentFinish >= date('now');

-- Q4 as written (trusted)
SELECT propertyNo, city, rent,
       ROUND(AVG(rent) OVER (PARTITION BY city), 2) AS cityAvg,
       ROUND(rent - AVG(rent) OVER (PARTITION BY city), 2) AS vsCityAvg
FROM Property
ORDER BY vsCityAvg DESC;

-- Q5 fixed: rank in a CTE, filter outside it
WITH ranked AS (
    SELECT city, propertyNo, rent,
           RANK() OVER (PARTITION BY city ORDER BY rent DESC) AS cityRank
    FROM Property
)
SELECT city, propertyNo, rent, cityRank
FROM ranked
WHERE cityRank = 1
ORDER BY city;


/* ---------------- PART E -- Sorting ---------------- */

-- E1
WITH firstView AS (
    SELECT clientNo, propertyNo, MIN(viewDate) AS firstViewed
    FROM Viewing
    GROUP BY clientNo, propertyNo
)
SELECT l.leaseNo, l.clientNo, l.propertyNo, fv.firstViewed, l.rentStart,
       CAST(julianday(l.rentStart) - julianday(fv.firstViewed) AS INTEGER) AS daysToLease
FROM Lease l
LEFT JOIN firstView fv ON fv.clientNo = l.clientNo AND fv.propertyNo = l.propertyNo
ORDER BY daysToLease ASC;

-- E3
WITH ordered AS (
    SELECT l.*,
           ROW_NUMBER() OVER (PARTITION BY clientNo ORDER BY rentStart DESC) AS rn
    FROM Lease l
)
SELECT leaseNo, clientNo, propertyNo, rent, rentStart, rentFinish
FROM ordered
WHERE rn = 1
ORDER BY clientNo;
