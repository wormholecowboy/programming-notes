-- DATA TYPES
VARCHAR()
CHAR()
TEXT

INT
SMALLINT
BIGINT
SERIAL
DECIMAL

DATE
TIME
TIMESTAMP
INTERVAL

BOOLEAN
ENUM
  CREATE TYPE type_name AS ENUM("val", [...])
ARRAY

-- STRING MANIPULATION

-- LEFT and RIGHT
-- returns char up to num
LEFT(column, num of char from left)

-- POSITION
-- returns position of char or string
POSITION("string" IN column)
POSITION(other_coumn IN column)

-- SUBSTRING
-- selects based on index start and length, can be combined with position and left/right
SUBSTRING(column/string from start_position [for num_of_chars] )
SUBSTRING(name from 2 for 3)

-- EXTRACT
-- returns segment of a date type
EXTRACT(field from column)
EXTRACT(DAY from timestamp_column)

-- TO_CHAR
-- returns strings format of date/time type
TO_CHAR(date_column, output_format)
TO_CHAR(date, "MM-YYYY")

-- REPLACE
-- find and replace string
REPLACE(column, old text, new text)


-- CREATE DATABASE & TABLE
CREATE DATABASE <name>
CREATE SCHEMA <name>

-- COLUMNS
DROP TABLE <name>
-- truncate deletes all data in table
TRUNCATE table_name

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,  // increments on creation
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    customer_id INT CHECK (customer_id > 0)     // check a constraint
    customer_id CONSTRANT constraint_name INT CHECK (customer_id > 0)     // named constraint
);

-- foreign keys
CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- rename a column
ALTER TABLE table_name
RENAME COLUMN old_column_name TO new_column_name;

-- add a column
ALTER TABLE users
ADD COLUMN email VARCHAR(255) NOT NULL;

-- drop a column
ALTER TABLE name DROP COLUMN name

-- adjust column constraints
ALTER TABLE table name
ALTER COLUMN column SET NOT NULL
ALTER COLUNN col TYPE TEXT

-- add constraint to multiple columns at once
ALTER TABLE table
ADD CONSTRAINT name
UNIQUE(col1, col2)


-- ROWS

-- insert a new row
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);

-- insert multi new rows
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...),
        (value1, value2)

-- update a value
UPDATE users
SET email = 'new_email@example.com'
WHERE user_id = 123;

-- delete a row
delete from customers
WHERE customer_id = 123;

-- delete all rows
TRUNCATE TABLE <table.name> 

-- merge (update, delete, and insert all in one, merges values from 2 tables)

MERGE INTO Table1 as T1
USING Table2 as T2
WHEN MATCED THEN
    UPDATE SET
        T1.Title = T2.Title
WHEN NOT MATCHED THEN
    INSERT (Id, Title)
    VALUES (T2.Id, T2.Title)




-- DATES
-- format examples
SELECT TIMESTAMP "2024-01-01T03:03:00"
SELECT DATE "2024-01-01"
SELECT DATE "April 1, 2024"
SELECT CURRENT_DATE
SELECT CURRENT_TIME
SELECT CURRENT_TIMESTAMP

-- time zone
SELECT TIMESTAMP WITH TIME ZONE "2024-01-01 03:03:00-04"

-- truncate date
DATE_TRUN("month", DATE "04-03-2024")  // truncates to 1st of month
DATE_TRUN("year", DATE "04-03-2024")  // truncates to 1st of year
DATE_TRUN("hour", TIMESTAMP "04-03-2024 04:03:00")  // truncates to start of hour

-- find diff between dates
AGE(DATE "04-01-2024", DATE "03-01-2024")
-- can also do timestamps and current date

-- cast as date, time, timestamp.
SELECT "2024-01-01"::date

-- return interval data type from difference
SELECT "2024-01-01"::date - "2023-01-01"::date

-- create time intervals
SELECT INTERVAL "1 day 2 hours 30 minutes"
SELECT NOW() + INTERVAL "1 day"
SELECT AGE(NOW(), '2021-01-01')

-- create relative date column
SELECT date_column + 1


-- TIMEZONES
SELECT current_setting("timezone")  // returns setting for db

-- timestamp data type
column_name timestamp   // no conversion
column_name timestamptz  // will convert to db's time zone if passed utc offset
INSERT INTO Column_name ("2023-01-01 15:30:00 -0700")

-- convert timezones
column_name at time zone ("American/Denver")
or
timzone("American/Denver", column_name)


-- ENUMS
CREATE TYPE name AS ENUM("values", "more values")   // order is respected
 

-- GROUPING

-- ROLLUP
-- Creates pre-defined grouping sets. Better than trying to union together sel statements.
-- CUBE works the same way, but shows all permutations of the column combos
SELECT
    col1, col2, col3
FROM table
GROUP BY
ROLLUP(
   col1, col2, col3   // col1 will have highest priority
)
ORDER BY 1,2,3


-- ARRAYS
-- create
array_column INTEGER[]

-- insert
VALUES (array[1,2,3,4])

-- select
WHERE 2 = ANY(column_name)  returns any array that has a 2
WHERE array[2, 4, 8]::INTEGER[] = array_column      // look for specific array

-- unnest (explode out array)
SELECT id, unnest(array_column)


-- RANGE (end excluded)
-- date type ex
numrange    // numeric
int4range   // integer

-- insert
VALUES (NUMRANGE(100, 200), INT4RANGE(200, 500))

-- select
WHERE salary @> 150     // 150 is within the range


-- NESTED DATA (map, dict)
column_name JSONB

-- insert as json blob

-- select
select column_name->>'street' AS 'street address'

-- create index to cut down query time
CREATE INDEX index_name ON table_name ((column_name->>"street"))
-- select
WHERE address->>"city] = "New York"
-- update
UPDATE table
SET address = jsonb_set(address, '{city}', '"Los Angeles"') 
WHERE name = 'John'


-- WINDOW FUNCTIONS
-- aggregate/group data without losing rows/granularity
AGG(agg_column) OVER(PARTITION BY partition_ column)

-- running total
SELECT SUM(order_total) OVER (ORDER BY order_date)
-- add this to group by something
-- partition by acts as a group by in a window function
-- is applied to results of main select
SELECT SUM(order_total) OVER (PARTITION BY customer_id ORDER BY order_date)

-- create a rank based on columns
SELECT DENSE_RANK() OVER(ORDER BY name)

-- FIRST VALUE
FIRST_VALUE(col)

-- LEAD and LAG
-- select previous or next row value
LAG(return_value [,offset[, default_value ]]) OVER (
    PARTITION BY expr1, expr2,...
	ORDER BY expr1 [ASC | DESC], expr2,...
)


-- JOINS
-- cross join
-- adds all rows together from both tables, no keys required
SELECT * FROM table
CROSS JOIN another_table

LEFT JOIN
RIGHT JOIN
INNER JOIN


-- UNION
-- must be same data type
-- column order is what matters
-- removes dups
-- UNION ALL leaves dups

-- COALESCE 
-- get rid of null values, will select the first non-null value
 SELECT id, COALESCE(column, default_value, another_order_dependent_default)


-- CASE
-- switch statment. order is very important.
SELECT name, salary, CASE
    WHEN salary < 1000 THEN "entry-level"
    WHEN salary < 5000 AND name = "Steve" THEN "mid-level"
    ELSE "exception"
    END AS class


-- CTE COMMON TABLE EXPRESSION
-- create a table inside a var
WITH cte_name AS (
    <select statement>
)

-- recursive
-- before union all is non-recursive, what you want the first value in table to be
-- after union all is recursion statement, don't forget where (base case)
WITH RECURSIVE cte_name AS (
    SELECT "2024-01-01"::date da_date
    UNION ALL
    SELECT da_date + 1
    FROM cte_name
    WHERE da_date < "2024-02-01"::date 
)


-- STORED PROCEDURES
-- good for table manipulation
-- supports transactions. does not return anything like UDF. 
CREATE OR REPLACE PROCEDURE insert_employee(
    p_name VARCHAR,
    p_dept VARCHAR
)
LANGUAGE plpsgsql
AS $$   // denotes start of fn
DECLARE
    some_var INT
BEGIN
    INSERT INTO employees (name, dept)
    VALUES (p_name, p_dept)
END;
$$;

CALL insert_employee("Brian", "Parks")


-- UDF USER DEFINED FUNCTION
-- doesn't use call, uses select intead
-- used to execute complex business logic repeatedly
-- doesn't support transactions
CREATE OR REPLACE FUNCTION average_salary (p_department_id INTEGER)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE 
	v_avg_salary NUMERIC;
BEGIN
	SELECT AVG(salary) INTO V_avg_salary
	FROM employees
	WHERE department_id = _department_id;

	RETURN v_avg_salary;
END;
$$;

select average_salary(1);


-- INDEX
Best to use on columns which you filter
-- B-Tree
For high-cardinality columns (primary key, names) 
-- Bitmap
For low-cardinality, slow to update, fast to read. storage efficient. for data warehouses. 

CREATE INDEX index_name
ON table_name
    (
    column_name
    );


-- VIEWS
CREATE VIEW name AS <query>
-- create view in memory, must be updated manually or programmatically
CREATE MATERIALIZED VIEW ...
UPDATE MATERIALIZED VIEW


-- TRANSACTIONS
START TRANSACTION;
OPERATION1;     // remove money from account
OPERATION2;   // put money in other account
SAVEPOINT s1;
OPERATION3;

ROLLBACK    // ends transaction
ROLBACK TO SAVEPOINT s1;

COMMIT;


-- TEMPORARY TABLES
CREATE TEMPORARY TABLE temp_domains (
    domain VARCHAR(255),
    new_id INT
);
DROP TEMPORARY TABLE temp_table;

-- LOAD DATA
LOAD DATA INFILE '/path/to/your/file.csv'
INTO TABLE temp_domains
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
(domain, new_id);


