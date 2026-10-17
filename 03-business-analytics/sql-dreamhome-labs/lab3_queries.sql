/* ====================================================================
   BAN-0301  SQL Lab III -- Session 6: Joins & Subqueries
   Student: Adam El Harouchi
   Run in DB Browser for SQLite against DreamHome.db (Execute SQL tab).
   Put the cursor inside one query and press Shift+F5 to run only it.
   ==================================================================== */

PRAGMA foreign_keys = ON;

/* ---------------- PART A -- Joins ---------------- */

-- A1
SELECT p.propertyNo, p.city, s.name AS staffName
FROM Property p
INNER JOIN Staff s ON p.staffNo = s.staffNo
ORDER BY p.propertyNo;

-- A2
SELECT p.propertyNo, p.city, s.name AS staffName
FROM Property p
LEFT JOIN Staff s ON p.staffNo = s.staffNo
ORDER BY p.propertyNo;

-- A3
SELECT p.propertyNo, p.city, p.type, p.rent
FROM Property p
LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
WHERE v.propertyNo IS NULL
ORDER BY p.propertyNo;

-- A4
SELECT p.propertyNo, COUNT(v.propertyNo) AS numViewings
FROM Property p
LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
GROUP BY p.propertyNo
ORDER BY numViewings DESC, p.propertyNo;

-- A4b  same query with COUNT(*)
SELECT p.propertyNo, COUNT(*) AS numViewings
FROM Property p
LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
GROUP BY p.propertyNo
ORDER BY numViewings DESC, p.propertyNo;

-- A5  INNER JOIN
SELECT s.staffNo, s.name AS staffName, s.position, m.name AS reportsTo
FROM Staff s
INNER JOIN Staff m ON s.supervisorStaffNo = m.staffNo
ORDER BY s.staffNo;

-- A5b  LEFT JOIN
SELECT s.staffNo, s.name AS staffName, s.position, m.name AS reportsTo
FROM Staff s
LEFT JOIN Staff m ON s.supervisorStaffNo = m.staffNo
ORDER BY s.staffNo;

-- A6
SELECT b.city, COUNT(*) AS runningLeases, SUM(l.rent) AS rentRoll
FROM Lease l
JOIN Property p ON l.propertyNo = p.propertyNo
JOIN Branch   b ON p.branchNo  = b.branchNo
WHERE l.rentFinish IS NULL
GROUP BY b.city
ORDER BY rentRoll DESC;

-- A6 stretch  every city, 0 where nothing is running
SELECT b.city, COUNT(l.leaseNo) AS runningLeases, COALESCE(SUM(l.rent), 0) AS rentRoll
FROM Branch b
LEFT JOIN Property p ON p.branchNo = b.branchNo
LEFT JOIN Lease    l ON l.propertyNo = p.propertyNo
                    AND l.rentFinish IS NULL
GROUP BY b.city
ORDER BY rentRoll DESC;

-- A7
SELECT l.leaseNo, c.name AS clientName, c.maxRent, l.rent AS agreedRent,
       l.rent - c.maxRent AS difference
FROM Lease l
JOIN Client c ON l.clientNo = c.clientNo
ORDER BY difference DESC;

-- A7b  how many above budget
SELECT COUNT(*) AS leasesAboveBudget
FROM Lease l
JOIN Client c ON l.clientNo = c.clientNo
WHERE l.rent > c.maxRent;


/* ---------------- PART B -- Subqueries and UNION ---------------- */

-- B1 inner query alone
SELECT ROUND(AVG(rent), 2) AS avgRent FROM Property;

-- B1
SELECT propertyNo, city, type, rent
FROM Property
WHERE rent > (SELECT AVG(rent) FROM Property)
ORDER BY rent DESC;

-- B2
SELECT staffNo, name, position, salary, branchNo
FROM Staff
WHERE salary > (SELECT AVG(salary) FROM Staff)
ORDER BY salary DESC;

-- B3
SELECT clientNo, name, prefType, maxRent
FROM Client
WHERE clientNo NOT IN (SELECT clientNo FROM Lease)
ORDER BY clientNo;

-- B4 first version (returns 0 rows -- see answer)
SELECT staffNo, name, position
FROM Staff
WHERE staffNo NOT IN (SELECT staffNo FROM Property);

-- B4 fixed
SELECT staffNo, name, position
FROM Staff
WHERE staffNo NOT IN (SELECT staffNo FROM Property WHERE staffNo IS NOT NULL)
ORDER BY staffNo;

-- B5 version 1: inner table built from Viewing only
SELECT ROUND(AVG(numViewings), 2) AS avgViewingsPerProperty
FROM (SELECT propertyNo, COUNT(*) AS numViewings
      FROM Viewing
      GROUP BY propertyNo) AS t;

-- B5 version 2: inner table built from Property LEFT JOIN Viewing
SELECT ROUND(AVG(numViewings), 2) AS avgViewingsPerProperty
FROM (SELECT p.propertyNo, COUNT(v.propertyNo) AS numViewings
      FROM Property p
      LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
      GROUP BY p.propertyNo) AS t;

-- B6 UNION
SELECT propertyNo FROM Viewing
UNION
SELECT propertyNo FROM Lease
ORDER BY propertyNo;

-- B6b UNION ALL
SELECT propertyNo FROM Viewing
UNION ALL
SELECT propertyNo FROM Lease
ORDER BY propertyNo;

-- B7 stretch: Acquisition grid in one query
SELECT s.city,
       s.propertiesHeld,
       s.avgAskingRent,
       d.clients,
       d.avgBudget,
       ROUND(d.avgBudget - s.avgAskingRent, 2) AS gap
FROM (SELECT city, COUNT(*) AS propertiesHeld, ROUND(AVG(rent), 2) AS avgAskingRent
      FROM Property
      GROUP BY city) AS s
JOIN (SELECT b.city, COUNT(*) AS clients, ROUND(AVG(c.maxRent), 2) AS avgBudget
      FROM Client c
      JOIN Branch b ON c.branchNo = b.branchNo
      GROUP BY b.city) AS d
  ON s.city = d.city
ORDER BY gap DESC;

-- B8 stretch: above the average for their own city (correlated subquery)
SELECT p.propertyNo, p.city, p.type, p.rent,
       (SELECT ROUND(AVG(p2.rent), 2) FROM Property p2 WHERE p2.city = p.city) AS cityAvg
FROM Property p
WHERE p.rent > (SELECT AVG(p2.rent) FROM Property p2 WHERE p2.city = p.city)
ORDER BY p.city, p.rent DESC;


/* ---------------- PART C -- The Monday exception report ---------------- */

-- C1
SELECT 'Unassigned property' AS issue, p.propertyNo AS ref, b.city
FROM Property p
JOIN Branch b ON p.branchNo = b.branchNo
WHERE p.staffNo IS NULL;

-- C2
SELECT 'Never viewed' AS issue, p.propertyNo AS ref, b.city
FROM Property p
JOIN Branch b ON p.branchNo = b.branchNo
LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
WHERE v.propertyNo IS NULL;

-- C3
SELECT 'Idle assistant' AS issue, s.staffNo AS ref, b.city
FROM Staff s
JOIN Branch b ON s.branchNo = b.branchNo
WHERE s.position = 'Assistant'
  AND s.staffNo NOT IN (SELECT staffNo FROM Property WHERE staffNo IS NOT NULL);

-- C4
SELECT 'Lease above budget' AS issue, c.clientNo AS ref, b.city
FROM Lease l
JOIN Client c ON l.clientNo = c.clientNo
JOIN Branch b ON c.branchNo = b.branchNo
WHERE l.rent > c.maxRent;

-- C5  one report
SELECT 'Unassigned property' AS issue, p.propertyNo AS ref, b.city
FROM Property p
JOIN Branch b ON p.branchNo = b.branchNo
WHERE p.staffNo IS NULL
UNION ALL
SELECT 'Never viewed', p.propertyNo, b.city
FROM Property p
JOIN Branch b ON p.branchNo = b.branchNo
LEFT JOIN Viewing v ON p.propertyNo = v.propertyNo
WHERE v.propertyNo IS NULL
UNION ALL
SELECT 'Idle assistant', s.staffNo, b.city
FROM Staff s
JOIN Branch b ON s.branchNo = b.branchNo
WHERE s.position = 'Assistant'
  AND s.staffNo NOT IN (SELECT staffNo FROM Property WHERE staffNo IS NOT NULL)
UNION ALL
SELECT 'Lease above budget', c.clientNo, b.city
FROM Lease l
JOIN Client c ON l.clientNo = c.clientNo
JOIN Branch b ON c.branchNo = b.branchNo
WHERE l.rent > c.maxRent
ORDER BY city, issue;
