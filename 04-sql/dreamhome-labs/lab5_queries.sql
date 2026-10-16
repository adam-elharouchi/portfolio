/* ====================================================================
   BAN-0301  Session 08 -- Constraints workshop
   Student: Adam El Harouchi
   Run on DreamHome_S8.db (a COPY of DreamHome.db), foreign keys ON.
   Statements that are SUPPOSED to fail are commented out with the
   error they give, so "Execute all" runs straight through. To see an
   error yourself, uncomment the line and run it on its own (Shift+F5).
   ==================================================================== */

PRAGMA foreign_keys = ON;
SELECT sqlite_version();

/* ---------------- PART A ---------------- */
-- A1  accepted
INSERT INTO Property VALUES ('PX1', '9 Test St', 'Glasgow', 'G1 1AA', 'Flat', 'four', 400, 'CO40', 'B003', NULL);
-- A2  accepted
INSERT INTO Lease VALUES (10999, 'CR74', 'PG21', 600, 'Visa', 1200, '2026-10-01', '2025-09-30');
-- A3  accepted
INSERT INTO Client VALUES ('CR99', 'Test Person', 'Flat', -100, '2026-10-05', 'B003', 'SG37');
-- A4  accepted
INSERT INTO Viewing VALUES ('CR74', 'PG4', 'next Tuesday', NULL);
-- A5  CHECK constraint failed: type IN ('House','Flat')
-- INSERT INTO Property VALUES ('PX2', '9 Test St', 'Glasgow', 'G1 1AA', 'flat', 2, 400, 'CO40', 'B003', NULL);
-- A6  CHECK constraint failed: paymentMethod IN ('Visa','Cash','Cheque','Direct Debit')
-- INSERT INTO Lease VALUES (10998, 'CR74', 'PG21', 600, 'visa', 1200, '2026-10-01', NULL);
-- A7  FOREIGN KEY constraint failed
-- INSERT INTO Viewing VALUES ('CR74', 'PZ99', '2026-10-01', NULL);

-- A8
SELECT propertyNo, rooms, typeof(rooms) AS storedAs FROM Property ORDER BY rooms DESC;
SELECT AVG(rooms) AS avgRooms, COUNT(rooms) AS n FROM Property;

-- Part A cleanup
DELETE FROM Viewing  WHERE viewDate   = 'next Tuesday';
DELETE FROM Lease    WHERE leaseNo    = 10999;
DELETE FROM Client   WHERE clientNo   = 'CR99';
DELETE FROM Property WHERE propertyNo = 'PX1';

/* ---------------- PART B ---------------- */
-- B1
DROP TABLE IF EXISTS MaintenanceRequest;
CREATE TABLE MaintenanceRequest (
    requestNo     INTEGER PRIMARY KEY AUTOINCREMENT,
    propertyNo    TEXT    NOT NULL
                  REFERENCES Property(propertyNo) ON DELETE CASCADE,
    reportedBy    TEXT
                  REFERENCES Client(clientNo)     ON DELETE SET NULL,
    assignedTo    TEXT
                  REFERENCES Staff(staffNo)       ON DELETE SET NULL,
    description   TEXT    NOT NULL,
    priority      TEXT    NOT NULL DEFAULT 'Medium'
                  CHECK (priority IN ('Low','Medium','High')),
    status        TEXT    NOT NULL DEFAULT 'Open'
                  CHECK (status IN ('Open','In progress','Closed')),
    dateReported  TEXT    NOT NULL DEFAULT (date('now'))
                  CHECK (dateReported IS date(dateReported)),
    dateClosed    TEXT
                  CHECK (dateClosed IS date(dateClosed)),
    cost          REAL
                  CHECK (cost >= 0),
    CHECK (dateClosed >= dateReported),
    CHECK ((status = 'Closed') = (dateClosed IS NOT NULL))
);

-- B2  T1 accepted
INSERT INTO MaintenanceRequest (propertyNo, description)
  VALUES ('PG4', 'Boiler not working');
-- T2  FOREIGN KEY constraint failed
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PG99', 'CR56', 'SG37', 'Damp in bathroom', 'High', 'Open', '2026-09-20', NULL, NULL);
-- T3  CHECK constraint failed: priority IN ('Low','Medium','High')
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PL94', 'CR76', 'SL41', 'Broken lock', 'Urgent', 'Open', '2026-09-22', NULL, NULL);
-- T4  accepted
INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
  VALUES ('PL94', 'CR76', 'SL41', 'Leaking tap', 'Low', 'Closed', '2026-09-01', '2026-09-03', 85);
-- T5  CHECK constraint failed: (status = 'Closed') = (dateClosed IS NOT NULL)
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PL78', 'CR30', 'SL33', 'Fence down', 'Medium', 'Closed', '2026-09-10', NULL, 120);
-- T6  CHECK constraint failed: dateClosed >= dateReported
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PG16', 'CR12', 'SG14', 'Window stuck', 'Low', 'Closed', '2026-09-15', '2026-08-15', 40);
-- T7  CHECK constraint failed: cost >= 0
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PB6', 'CR91', 'SB44', 'Gutter cleared', 'Low', 'Closed', '2026-09-05', '2026-09-06', -20);
-- T8  NOT NULL constraint failed: MaintenanceRequest.description
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PA14', 'CR62', 'SA9', NULL, 'High', 'Open', '2026-09-28', NULL, NULL);
-- T9  CHECK constraint failed: dateReported IS date(dateReported)
-- INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
--   VALUES ('PG36', 'CR56', 'SG37', 'Mould on ceiling', 'Medium', 'Open', 'yesterday', NULL, NULL);
-- T10 accepted
INSERT INTO MaintenanceRequest (propertyNo, reportedBy, assignedTo, description, priority, status, dateReported, dateClosed, cost)
  VALUES ('PB6', NULL, 'SB44', 'Broken window', 'High', 'In progress', '2026-10-01', NULL, NULL);

SELECT * FROM MaintenanceRequest;   -- 3 rows

-- B3
INSERT INTO MaintenanceRequest (propertyNo, assignedTo, description, dateReported)
  VALUES ('PL21', 'SL15', 'Smoke alarm beeping', '2026-10-02');
DELETE FROM Staff WHERE staffNo = 'SL15';          -- (a)
SELECT requestNo, propertyNo, assignedTo FROM MaintenanceRequest WHERE propertyNo = 'PL21';   -- assignedTo NULL
DELETE FROM Property WHERE propertyNo = 'PL21';    -- (b)
SELECT COUNT(*) FROM MaintenanceRequest;           -- 3
-- (c) FOREIGN KEY constraint failed  (Viewing and Lease rows still reference PG4)
-- DELETE FROM Property WHERE propertyNo = 'PG4';
SELECT (SELECT COUNT(*) FROM Viewing WHERE propertyNo = 'PG4') AS viewings,
       (SELECT COUNT(*) FROM Lease   WHERE propertyNo = 'PG4') AS leases;

/* ---------------- PART D ---------------- */
-- D1
ALTER TABLE Property ADD COLUMN furnished INTEGER NOT NULL DEFAULT 0 CHECK (furnished IN (0, 1));
UPDATE Property SET furnished = 1 WHERE propertyNo IN ('PL21', 'PL94');
UPDATE Property SET furnished = 2 WHERE propertyNo = 'PL21';   -- 0 rows: PL21 was deleted in B3(b)
-- CHECK constraint failed: furnished IN (0, 1)
-- UPDATE Property SET furnished = 2 WHERE propertyNo = 'PL94';

-- D2
-- Cannot add a UNIQUE column
-- ALTER TABLE Client ADD COLUMN email TEXT UNIQUE;
ALTER TABLE Client ADD COLUMN email TEXT;
CREATE UNIQUE INDEX idxClientEmail ON Client(email);
UPDATE Client SET email = 'john.kay@example.com' WHERE clientNo = 'CR76';
-- UNIQUE constraint failed: Client.email
-- UPDATE Client SET email = 'john.kay@example.com' WHERE clientNo = 'CR56';

-- D3  Cannot add a column with non-constant default
-- ALTER TABLE Property ADD COLUMN dateListed TEXT DEFAULT (date('now'));

-- D4
CREATE TABLE Lease_new (
  leaseNo       INTEGER PRIMARY KEY,
  clientNo      TEXT NOT NULL REFERENCES Client(clientNo)     ON DELETE RESTRICT,
  propertyNo    TEXT NOT NULL REFERENCES Property(propertyNo) ON DELETE RESTRICT,
  rent          REAL NOT NULL CHECK (rent > 0),
  paymentMethod TEXT CHECK (paymentMethod IN ('Visa','Cash','Cheque','Direct Debit')),
  deposit       REAL CHECK (deposit >= 0),
  rentStart     TEXT NOT NULL CHECK (rentStart IS date(rentStart)),
  rentFinish    TEXT CHECK (rentFinish IS date(rentFinish)),
  CHECK (rentFinish > rentStart)
);
INSERT INTO Lease_new SELECT * FROM Lease;
DROP TABLE Lease;
ALTER TABLE Lease_new RENAME TO Lease;
SELECT COUNT(*) FROM Lease;     -- 8
PRAGMA foreign_key_check;       -- no rows

-- D5
-- CHECK constraint failed: rentFinish > rentStart
-- INSERT INTO Lease VALUES (10999, 'CR74', 'PG21', 600, 'Visa', 1200, '2026-10-01', '2025-09-30');
-- CHECK constraint failed: rentStart IS date(rentStart)
-- INSERT INTO Lease VALUES (10997, 'CR74', 'PG21', 600, 'Visa', 1200, '1 Oct 2026', NULL);

-- D6  FOREIGN KEY constraint failed
-- DROP TABLE Property;
