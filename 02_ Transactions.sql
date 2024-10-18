/*To continue with the theme of turning SQL queries that you write in class to queries 
that work with big data, here is another tip...

Transactions are what is needed for any query that has an UPDATE, DELETE, MERGE, or INSERT. 
If anything goes wrong, you can undo the previous changes, instead of having to worry if a query only ran 
partly, meaning the data in the table is corrupt. SELECT statements do not get marked in the transaction, because 
nothing is changed.
*/
The three statements are...
BEGIN TRANSACTION --start the transaction
ROLLBACK TRANSACTION --cancel the transaction
COMMIT TRANSACTION --apply the transaction

/*(You can name transactions, but let's focus on these statements themselves.) */

/*Examples:
You want to see what it would look like if you were to update a table, and see if an existing table 
would accept the new changes in the updates you make. */

BEGIN TRANSACTION;

UPDATE changedTable
SET val_1 = 'new value to test'
WHERE val_1 = 'condition';

SELECT * 
FROM needToCheckTable

ROLLBACK TRANSACTION;

/*If the results are good, and you get the green light to make the update, then you just need to do the following... */

BEGIN TRANSACTION;

UPDATE changedTable
SET val_1 = 'new value to test'
WHERE val_1 = 'condition';

COMMIT TRANSACTION;

/*You'll want to do it this way, because if the query hangs and does not complete, you'll get a corrupt table. 
You'll also be able to see the transaction in the logs, and can kill the transaction, and you'll know that you do 
not have corrupt data.`     ``

You can get more complex queries by using statements such as IF...ELSE, and global variables alongside with transactions. */