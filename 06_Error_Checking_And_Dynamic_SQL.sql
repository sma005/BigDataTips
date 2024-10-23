/*Sometimes, you want to put in a precaution to make sure that you do not update the wrong server.

This is assuming that you have a DEV/STAGING/PRODUCTION environment setup. (Other systems have BRONZE/SILVER/GOLD)

I'm going to use DEV/STAGING/PRODUCTION.

I'm also going to assume that you know variables that are denoted with a @ 
and global variables which are denoted with a @@

I'll cover those at a later date. The main focus here is how to make sure that
make sure that you are running your code in the correct environment.

*/

--Say you want to have code that will change the last name of a patient...

UPDATE Patients
SET Last_Name = 'Johnson'
WHERE PatientID = 42186

/*There are a couple of ways you can do it.

Either you put in a check to make sure that you are using the right server, you can explicity name the server that you are using, or 
you can use dynamic SQL

*/
-----------------------------------------------------------------------------------------------------------------------
--Option 1
--This is explicity named. You will have to manually go in and change the code.
--Simple
--Unfortunately, there is no error checking, or let you know if you're in the wrong environment.
--Note... The double period (..) is just a shortcut for the database owner (.dbo.). The full name is DEV.dbo.Patients 
UPDATE DEV..Patients
SET Last_Name = 'Johnson'
WHERE PatientID = 42186

-----------------------------------------------------------------------------------------------------------------------
--Option 2
--Check to see if you are on the right server. Useful if there are multiple times you call a table.
--If you aren't logged into the correct server, it will fail. It will throw an error if you're on the wrong server.
--Dynamic SQL can be used here, but I wanted to split error checking and dynamic SQL into different queries. Easier to follow.
BEGIN TRANSACTION

DECLARE @intendedServer VARCHAR(30);
DECLARE @patientID_to_find INT, @last_name_change NVARCHAR(100);

SET @intendedServer = 'DEV';

SET @patientID_to_find = 42186;
SET @last_name_change = 'Johnson';

IF @@SERVERNAME = @intendedServer
  BEGIN TRY --Dynamic SQL can be inserted here
    UPDATE DEV..Patients
    SET Last_Name = @last_name_change
    WHERE PatientID = @patientID_to_find;

    COMMIT TRANSACTION;
  END TRY

  BEGIN CATCH
    IF (@@TRANCOUNT = 0) --Global variable that shows transaction count
        PRINT 'PatientID ' + @patientID_to_find + 'not found'
        ROLLBACK TRANSACTION;
  END CATCH

ELSE 
  BEGIN
    PRINT 'The expected server is ' + @intendedServer + ' but the current server is ' + @@SERVERNAME;
    ROLLBACK TRANSACTION;
  END;

END;

-----------------------------------------------------------------------------------------------------------------------
--Option 3
--Will run on the current server. Useful if there are multiple times you call a table.
--Dynamic SQL is one of the most advanced.
--This is ready to be wrapped in a stored procedure.
--You can add a TRY/CATCH to make this similar to Option 2 if needed.
--I've intentially left out error checking, so that it's easier to spot what's going on.
--Dynamic SQl requires you to use NVACHAR datatype

BEGIN TRANSACTION

DECLARE @patientID_to_find INT, @last_name_change NVARCHAR(100);

SET @patientID_to_find = 42186;
SET @last_name_change = N'Johnson';

DECLARE @SQL NVARCHAR(1000);
SET @SQL = N'UPDATE '+ @@SERVERNAME + '..Patients SET Last_Name = '+ @last_name_change +' WHERE PatientID = ' + @patientID_to_find;

EXEC (@SQL)

PRINT 'Script ran on server: '+ @@SERVERNAME;

END TRANSACTION

--To use Dynamic SQL, all you do is set a variable that is a string in the form of a SQL statement, and use the EXEC command.
--regex is commonly used with dynamic SQL for more information go to https://reqchecker.eu/manual/extract_syntax.html
--https://www.atlassian.com/data/sql/how-regex-works-in-sql is another useful link


--And now with Error checking and Dynamic SQL combined...
BEGIN TRANSACTION

DECLARE @intendedServer NVARCHAR(30);
DECLARE @patientID_to_find INT, @last_name_change NVARCHAR(100);

SET @intendedServer = 'DEV';

SET @patientID_to_find = 42186;
SET @last_name_change = 'Johnson';

IF @@SERVERNAME = @intendedServer
  BEGIN TRY
     DECLARE @SQL NVARCHAR(1000);
     SET @SQL = N'UPDATE '+ @@SERVERNAME + '..Patients SET Last_Name = '+ @last_name_change +' WHERE PatientID = ' + @patientID_to_find;

     EXEC (@SQL)
    COMMIT TRANSACTION;
  END TRY

  BEGIN CATCH
    IF (@@TRANCOUNT = 0)
        PRINT 'PatientID ' + @patientID_to_find + 'not found'
        ROLLBACK TRANSACTION;
  END CATCH

ELSE 
  BEGIN
    PRINT 'The expected server is ' + @intendedServer + ' but the current server is ' + @@SERVERNAME;
    ROLLBACK TRANSACTION;
  END;

END;

