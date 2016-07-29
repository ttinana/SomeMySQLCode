
/*
Write a procedure in MySQL to split a column into rows using a delimiter. 

CREATE TABLE sometbl ( ID INT, NAME VARCHAR(50) ); 
INSERT INTO sometbl VALUES (1, 'Smith'), (2, 'Julio|Jones|Falcons'), (3, 'White|Snow'), (4, 'Paint|It|Red'), (5, 'Green|Lantern'), (6, 'Brown|bag'); 
For (2), example rows would look like >> “3, white”, “3, Snow” … 
*/
-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `answer3`()
-- ---------------------------------------------
-- to execute procedure
-- call answer3();

-- Robert here is some code to create table and test procedure
-- CREATE TABLE `sometblCorrupted` (
--   `id` int(11) DEFAULT NULL,
--   `name` varchar(50) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- insert into sometblCorrupted values ( 1, 'tijana|goran|mace') 

-- ---------------------------------------------
BEGIN
	declare myDelimiter CHAR(1) default '|';
    declare id int default 0;
	declare i int default 0;
	declare occurance INT default 0; 
    declare value text;       
    declare splitted_value varchar(25);
    declare notFound int default 0;
    declare cur cursor for select sometblCorrupted.id, sometblCorrupted.name
                                         from sometblCorrupted
                                         where sometblCorrupted.name != '';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET notFound = 1;

    drop temporary table if exists sometbl;
    create temporary table sometbl(
    `id` int,
    `name` varchar(50));

    open cur;
      read_loop: loop
        fetch cur into id, value;
        if notFound then
          leave read_loop;
        end if;

        set occurance = (select length(value) - length(replace(value, myDelimiter, '')) +1);
        set i=1;
         while i <= occurance do
          set splitted_value =
          replace((select replace(substring(substring_index(value, myDelimiter, i),
          length(substring_index(value, myDelimiter, i-1)) +1), ',', '')),"|" , "");
          insert into sometbl values (id, splitted_value);
          set i = i + 1;
        end while;
      end loop;

      select * from sometbl;
    close cur;
  END