/*One thing I see from beginning SQL programmers, is that they will use unnecessary joins when writing queries

The example I'm going to use, pulls the same data from different sources.

*/

--This is bad code. Don't do this...
SELECT ISNULL(t1.val_1,t2.val_1) AS val_1, ISNULL(t1.val_2,t2.val_2) AS val_2, ISNULL(t1.val_3, t2.val_3) AS val_3,
 CASE
 WHEN t1.val1 NOT NULL THEN 'From Table 1'
 WHEN t2.val1 NOT NULL THEN 'From Table 2'
END AS 'TableSource'
FROM #tempTable_1 t1
OUTER JOIN #tempTable_2 t2
ON t1.id = t2.id
/*In the previous example, you have a whole lot of joining for no reason. JOINS take time, and drives the time complexity up
Essentially, you have to read the first table, and go through a loop trying to match all records of t2 on t1 */


/*If the information needed from both columns have the same datatypes, and you have the same type of information that can
stack neatly on top of each other, then you are better off using a UNION or a UNION ALL statement*/

--Note: All columns in both tables have to be the same.
--If you use an INTO statement, it can only go on the first query
--If you use any other statement that typically goes after the WHERE clause (ORDER BY, GROUP BY, HAVING), it goes in the last query
--You can have multiple UNION statements

SELECT t1.val_1, t1.val_2, t1.val_3, 'From Table 1' AS 'TableSource'
FROM #tempTable_1 t1

UNION

SELECT t2.val_1, t2.val_2, t2.val_3, 'From Table 2' AS 'TableSource'
FROM #tempTable_2.t2


--UNION removes duplicates. If you want to keep duplicates
UNION ALL
--instead of UNION

/*The time complexity in this statement is O(n). It only has to go through each record once*/
/*Yes, the SQL optimizer will do it's best to make the query work better, the SQL optimizer isn't perfect*/

/*For additional information, you can look up "time complexity". 
The first query has a time complexity of O(n^2) 
The first query has a time complexity of O(n)

A further explanation of time complexity can be shown here:
https://www.geeksforgeeks.org/understanding-time-complexity-simple-examples/ */ 