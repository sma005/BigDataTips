/*When creating code, a lot of beginners have a tendency to run their code against the entire table, which is 
unnecessary. Of course when it is done, you'll have to run it and include all of the data, but when you are 
writing code, and there are over 2 billion records, this is not a good plan.

SQL has the LIMIT function for this. T-SQL uses TOP.

When initially writing code, just use a small subset of the code that you need. You can change your query 
later when you think it is correct. In this example, assume you want to pull patient information from a table 
called Patients. */

--T-SQL
SELECT TOP 1000 *
INTO #tempPatients -- so we can use this instead of the shared database
FROM Patients;

--Most other flavors of SQL
SELECT *
INTO hashtag#TempPatients -- so we can use this instead of the shared database
FROM Patients
LIMIT 1000;

/* Depending on your the rights that you have, if you can create a view that you can work from, then you will save 
your coworkers from being upset with you for tying up all of the tables. */

--T-SQL
CREATE VIEW Patients_View AS 
SELECT TOP 1000 *
FROM Patients;

--Other flavors of SQL
CREATE VIEW Patients_View AS 
SELECT *
FROM Patients
LIMIT 1000;