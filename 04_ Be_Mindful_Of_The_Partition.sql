/*Most modern databases have a stored in partitioned. It is critical that you know how the data
is partitioned, so that you can be deliberate when writing code that pulls data from a partitioned table.

When your code takes the partiiton into account, you can shave hours from run times */


/*For example, if a company is more likely to use their most recent data rather than their historic data, 
the partition will be by year.

When you are pulling records, try to make sure to include the year in your queries. It will only check the 
partition with that year, meaning your queries will be faster.*/


/* If you look at the properites of the table you need to query, or if you right click the table, you
select the CREATE TABLE, you will see how the table is partitioned... if you have the rights to do that. 

Databricks is very efficient at storing partitioned tables.
*/

--The code could look something like this. I'm only including a few lines
CREATE TABLE Source_Table
USING DELTA
PARITIONED BY (date_column); -- This is the line. To speed up your queries, the WHERE clause should have this.
--depending on which version of SQL you are using, this line may not match exactly.
--You may have a few lines to look at after the PARTIONED BY line.

/*Different flavors of SQL will have different syntax, but you should see something about partitioning.
If you can't figure it out yourself, ask a coworker. */

--If the table is partitioned by year...
--I'm also assuming that this table will be used by another table later. **Need a temp table**

SELECT val_1, val_2, val_3
INTO #tempTable -- so we can use this instead of the shared database
FROM Source_Table
WHERE YEAR(date_column) = 2025

/*This means that if you are assigned a project, and you are not clear on the years that need to be included, then you should ask*/