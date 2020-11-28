SPOOL project.txt
SET ECHO ON
/*
CIS 353 - Database Design Project
Alexander Klein
Brendan O'Brien
Kameron Freeman
Luke Seeterlin
*/
DROP TABLE Employee;
DROP TABLE Sale;
DROP TABLE Part;
DROP TABLE Stage;
DROP TABLE Maintenance;
DROP TABLE Fix;
DROP TABLE EmPosition;
CREATE TABLE EmPosition
(
    emID INTEGER,
    ePosition CHAR(15) NOT NULL,

    --Employee must exist.
    CONSTRAINT EPC1 PRIMARY KEY (emID),
    --Position must be one of the following:
    CONSTRAINT EPC2 CHECK (ePosition IN ('sprayer', 'cashier', 'supervisor', 'stocker', 'technician')),
    --Each row must be unique.
    CONSTRAINT EPC3 UNIQUE (emID, ePosition)
);
CREATE TABLE Employee
(
    eID INTEGER PRIMARY KEY,
    eFirstName CHAR(15),
    eLastName CHAR(15) NOT NULL,
    ePay FLOAT NOT NULL,

    --ID must be tied to position.
    CONSTRAINT EC1 FOREIGN KEY (eID) REFERENCES EmPosition(emID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
            DEFERRABLE INITIALLY DEFERRED,
    --Pay must be greater than $10/hr.
    CONSTRAINT EC2 CHECK (ePay > 10.00)
);
CREATE TABLE Sale
(
    slID INTEGER,
    slItem CHAR(30) NOT NULL,
    slCost FLOAT NOT NULL,
    cashierID INTEGER,
    cashierPos CHAR(15),

    --Sale ID must be unique.
    CONSTRAINT SC1 PRIMARY KEY (slID),
    --Cashier must exist.
    CONSTRAINT SC2 FOREIGN KEY (cashierID) REFERENCES EmPosition(emID),
    --Employee must be a cashier.???
    CONSTRAINT SC3 FOREIGN KEY (cashierPos) REFERENCES EmPosition(ePosition)
);
CREATE TABLE Part
(
    pID INTEGER,
    pManufacturerName CHAR(20) NOT NULL,
    pManufacturerLocation CHAR(30) NOT NULL,
    pCost FLOAT NOT NULL,

    --Part ID must be unique.
    CONSTRAINT PAC1 PRIMARY KEY (pID)
);
CREATE TABLE Stage
(
    stID INTEGER,
    stName CHAR(15) NOT NULL,

    --Stage ID must be unique.
    CONSTRAINT STC1 PRIMARY KEY (stID)
);
CREATE TABLE Maintenance
(
    staID INTEGER,
    mDate DATE,
    mCost FLOAT NOT NULL,
    tID INTEGER,
    tPosition CHAR(15),
    severity CHAR(15) NOT NULL,

    --Stage must exist.
    CONSTRAINT MC1 FOREIGN KEY (staID) REFERENCES Stage(stID),
    --Date and stage must be unique.
    CONSTRAINT MC2 UNIQUE (staID, mDate),
    --Technician must exist.
    CONSTRAINT MC3 FOREIGN KEY (tID) REFERENCES EmPosition(emID),
    --Technician must be a technician.???
    CONSTRAINT MC4 FOREIGN KEY (tPosition) REFERENCES EmPosition(ePosition),
    --Severity must be one of the following:
    CONSTRAINT MC5 CHECK (severity IN ('minor', 'major', 'catastrophic'))
);
CREATE TABLE Fix
(
    fDate DATE,
    paID INTEGER, 
    teID INTEGER,
    tePosition CHAR(15),

    --Part must exist.
    CONSTRAINT MC1 FOREIGN KEY (paID) REFERENCES Part(pID),
    --Date and part must be unique.
    CONSTRAINT MC2 UNIQUE (paID, fDate),
    --Technician must exist.
    CONSTRAINT MC3 FOREIGN KEY (teID) REFERENCES EmPosition(emID),
    --Technician must be a technician.???
    CONSTRAINT MC4 FOREIGN KEY (tePosition) REFERENCES EmPosition(ePosition)
);
--
SET FEEDBACK OFF
/*< The INSERT statements that populate the tables>
Important: Keep the number of rows in each table small enough so that the results of your
queries can be verified by hand. See the Sailors database as an example.*/
SET FEEDBACK ON
COMMIT;
--
/*< One query (per table) of the form: SELECT * FROM table; in order to display your database >*/
--
/*< The SQL queries>. Include the following for each query:
− A comment line stating the query number and the feature(s) it demonstrates
(e.g. -- Q25 – correlated subquery).
− A comment line stating the query in English.
− The SQL code for the query.*/
--
/*< The insert/delete/update statements to test the enforcement of ICs >
Include the following items for every IC that you test (Important: see the next section titled
“Submit a final report” regarding which ICs you need to test).
− A comment line stating: Testing: < IC name>
− A SQL INSERT, DELETE, or UPDATE that will test the IC.*/
COMMIT;
--
SPOOL OFF
