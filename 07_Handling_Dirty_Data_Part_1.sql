/*Continuing with the theme "From the classroom to big data"...

You learn a lot of functions in SQL to be able to transform data, but you aren't told when and how to use it. 
I'll use this post to talk about cleaning up text.

If you did not get the data from someone you personally know... the data is dirty.
If you got the data from an outside source... the data is dirty.
If you got the data from an API... the data is dirty.
If your supervisor didn't tell you that the data came from a clean source... the data is dirty.
If the data captured was user inputted, the data is really dirty.

If the data is dirty, there are a few things that are usually there.

There are spaces before and after text. I've always solved it LTRIM and RTRIM. Also to help fight SQL injection, I 
remove commas and semi-colons with REPLACE. The following functions will have to be subnested within each other.
*/
REPLACE(text_1,',','')
REPLACE(text_1,';','')
LTRIM(text_1)
RTRIM(text_1)

--The full statement looks like this...
SELECT REPLACE(REPLACE(LTRIM(RTRIM(text_1)),';',''),',','') AS 'text_1'

/*Phone numbers can have different formats. Personally, I like to remove all hyphens and commas. If the final version needs 
to have hyphens and commas, it can be added later. The following function has already been added to a lot of databases, but 
just it case it hasn't it should be added. It uses regex to comb through the text and only keeps the digits 0-9.
*/

CREATE Function [fnRemoveNonNumericCharacters](@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
    WHILE PATINDEX('%[^0-9]%', @strText) > 0
    BEGIN
        SET @strText = STUFF(@strText, PATINDEX('%[^0-9]%', @strText), 1, '')
    END
    RETURN @strText
END

--So when call the function, it will look like this...
SELECT dbo.fnRemoveNonNumericCharacters(phone_number) as 'phone_number'