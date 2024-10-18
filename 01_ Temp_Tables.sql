/*I've been asked to help SQL programmers to convert their queries into better written ones that are optimal for big data. 

Beginners have a tendency to write one big query that fits everything. This shouldn't be done because...

 1. You tie up the all tables in your query, until it is finished. Grabbing data from the production tables and putting them into a temp table is better than tying up the production table, because multiple people are probably using the same table.
 2. Although the Query Optimizer is a valuable tool, it can't do everything.

Tip: Use temp tables so that you can have intermittent points where you can check your code. It's also easier to maintain. */

SELECT val_1, val_2, val_3
INTO #tempTable
FROM table;

/*The temp table exists in the session, until the session is killed, or it is deleted manually.

It now can be used just like a regular table.

Before SQL Server 2016 deleting a temp table looked like this... */

IF OBJECT_ID(N'tempdb..hashtag#tempTable') IS NOT NULL;
DROP TABLE #tempTable;

/*SQL Server 2016 added 'IF EXISTS'. So now, all you need is... */

DROP TABLE IF EXISTS #tempTable;

/*Everything that is in this post for the copy/pasters... */

-- Code starts here
DROP TABLE IF EXISTS #tempTable;

SELECT val_1,val_2
INTO #tempTable
FROM table_name;

--Code ends here