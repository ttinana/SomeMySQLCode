/*
) Write a function to capitalize the first letter of a word in a given string; 
Example: initcap(UNITED states Of AmERIca ) = United States Of America 
*/

CREATE DEFINER=`root`@`localhost` FUNCTION `initcap`(input varchar(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
declare length int;
declare i int;

set length=char_length(input);
set i =0;
set input = lower(input);

while(i<length)do
--
	if(mid(input, i, 1)=' ' or i=0)
		then
			if(i<length)
            then
				set input=concat(left(input, i), upper(mid(input, i+1,1)), right(input, length-i-1));
			end if;
	end if;  
	--
	set i=i+1;
end while;

RETURN input;
END