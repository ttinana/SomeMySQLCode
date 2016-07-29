/*
User story:
I have a table for bugs from a bug tracking software; let’s call the table “bugs”. 
The table has four columns (id, open_date, close_date, severity). 
On any given day a bug is open if the open_date is on or before that day 
and close_date is after that day. For example, a bug is open on “2012-01-01”, 
if it’s created on or before “2012-01-01” and closed on or after “2012-01-02”. 
I want a SQL to show number of bugs open for a range of dates. 
*/

-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `a_bug`(fromDate date, toDate date)
BEGIN
declare fromDateInt integer;
declare toDateInt integer;

set fromDateInt = fromDate +0;
set toDateInt = toDate +0;

  label_bug: LOOP
    SET fromDateInt = fromDateInt + 1;
    IF fromDateInt < toDateInt THEN
		select count(*) as res
		from test.bugs
		where open_date<=fromDate
		and fromDate<= close_date;
    END IF;
    LEAVE label_bug;
  END LOOP label_bug;
END