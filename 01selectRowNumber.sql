/*
Write a query to rank order the following table in MySQL by votes, display the rank as one of the columns. 
CREATE TABLE votes ( name CHAR(10), votes INT ); 
INSERT INTO votes VALUES 
('Smith',10), ('Jones',15), ('White',20), ('Black',40), ('Green',50), ('Brown',20); 
*/


set @rownumber:=0;
select name, votes, rank 
from (
select @rownumber:= @rownumber +1 as rank, votes, name
from votes
 group by votes, name
order by votes desc
) as result