/*Continuing with the theme "From the classroom to big data"...
More SQL tips:
I assumed that this was well known, but I've talked to a few beginner developers, and they didn't know that
this was an option...

I recently received a csv that had a comma delimiter, and an address column that was sometimes formatted like this: 
  111 Main St. ,Columbus, OH, 43205

and sometimes formatted like this:
  111 Main St. Columbus, OH 43205

and sometimes formatted like this:
  111 Main St. Columbus OH 43205

The easiest thing to do (and what is going to happen in this case) is that I'm going to request that they send the same file, and
change the delimiter to a pipe " | ". 
This little used key is located above the return key, and you have to hold shift. Excel gives you the ability to change the delimiter to a pipe.
If the data can't be resubmitted, then you're going to have to parse through the data, and contain the address line with a double 
quotation mark. ex: "111 Main St., Columbus, OH 43205" 

*/