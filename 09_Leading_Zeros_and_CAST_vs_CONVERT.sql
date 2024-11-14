/* Sometimes you need to convert an integer to have leading zeros. This is good for limited sets with 
a user id.

You have to figure out how many lead numbers you want. In this case, it is 5
You have to make sure that the numbers in sequence fit in the schema, or the
RIGHT() function will cut it off.

In this following example, we are going to use 5 digits.
*/

SELECT RIGHT('00000' + CAST(c.CustomerID AS varchar(5)),5) AS CustomerID
FROM Customers c;

/*
For good code...
Make sure that the number of zeros match with the variable length.
Don't forget table aliases

If you were converting to anything else besides a varchar, TRY_CAST would be better to use.
TRY_CAST() will result in a NULL if the conversion fails. A query can be made to fill in all of the
missing values with whatever logic you need.

Once again, using CAST() instead of TRY_CAST() is fine to use, because converting to a varchar doesn't spit conversion errors.
*/ 

/*
--Other general things to know about CAST()
A failed CAST() raises an error. if you were converting something to an INT, where text
would be an error, you would use a TRY_CAST. A TRY_CAST() will convert to a NULL value.

CONVERT() can also be used in T-SQL, 
T-SQL has more funcitonality, but because it has
more functionality, it isn't needed for this, and CAST performs a little faster than CONVERT()

CAST() maintains numeric integrity better. Rounding errors can happen with CONVERT().

CAST() is typically used for simple conversions
CONVERT() is used when some additional formatting needs to happen, and can only be used with T-SQL.

CAST() also preserves precision. For DECIMAL and NUMERIC types, Convert can cause rounding errors.
A good rule of thumb is to to use CAST if there is no extra special formatting that has to be done.

More information about CAST() and CONVERT() can be found at...

https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver16&redirectedfrom=MSDN
*/
