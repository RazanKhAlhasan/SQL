USE air_cargo_analysis;

-- 2
CREATE TABLE route_details (
route_id INT,
CONSTRAINT UniqueRouteID UNIQUE (route_id),
flight_num VARCHAR(20),
CONSTRAINT CheckFlightNum CHECK (flight_num REGEXP "[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]"), -- REGEXP IS USED WHEN WE WHAT TO CHECK A PATTERN
origin_airport VARCHAR(20),
destination_airport VARCHAR(20),
aircraft_id VARCHAR(20),
distance_miles INT,
CONSTRAINT DistanceMilesGreater CHECK (distance_miles > 0)
);

-- 3

SELECT * FROM passengers_on_flights
WHERE route_id BETWEEN 0 AND 25
ORDER BY route_id ASC;

-- 4

SELECT COUNT(customer_id) AS NumberOfPassengers , class_id, SUM(Price_per_ticket) AS TotalRevenue
FROM ticket_details
WHERE class_id = "Bussiness";

-- 5

SELECT CONCAT(first_name, " ", last_name) AS FullName FROM customer;

-- 6

SELECT customer_id, CONCAT(first_name, " ", last_name) AS FullName, p_date, Price_per_ticket, brand
FROM customer C NATURAL INNER JOIN ticket_details T 
ORDER BY customer_id ASC;

-- 7

SELECT CONCAT(first_name, " ", last_name) AS FullName, brand, p_date
FROM customer C JOIN ticket_details T 
WHERE C.customer_id = T.customer_id AND brand = "Emirates"
ORDER BY T.customer_id ASC;

-- 8

SELECT customer_id, class_id
FROM passengers_on_flights
GROUP BY customer_id
HAVING class_id = "Economy Plus";

-- 9

SELECT SUM(Price_per_ticket), IF (SUM(Price_per_ticket) > 10000, "More than 10000", "Less than 10000") AS TotalRevenue
FROM ticket_details;

-- 10 

CREATE USER junior@localhost IDENTIFIED BY 'junior123';
GRANT EXECUTE ON securitydb.* TO junior@localhost;

-- 11

SELECT *, MAX(Price_per_ticket) OVER (PARTITION BY class_id) AS MaxPrice
FROM ticket_details;

-- 12

CREATE INDEX RouteId4 ON passengers_on_flights(route_id);

SELECT * FROM passengers_on_flights 
WHERE route_id = 4;

-- 13
-- EXECUTION PLAN
SELECT * FROM passengers_on_flights
WHERE route_id = 4;

-- 14

SELECT customer_id, aircraft_id, SUM(Price_per_ticket) AS TotalTicketPrice
FROM ticket_details
GROUP BY customer_id WITH ROLLUP;

-- 15

CREATE VIEW BussinessClass AS 
SELECT customer_id, aircraft_id, class_id
FROM ticket_details
WHERE class_id = "Bussiness"
ORDER BY customer_id ASC;

SELECT * FROM BussinessClass;

-- 16

DELIMITER &&
CREATE PROCEDURE PassengerDetails(IN BeginRange VARCHAR(20), IN EndRange VARCHAR(20))
BEGIN
DECLARE IfExist BOOLEAN DEFAULT FALSE;
SELECT COUNT(*) INTO IfExist 
FROM information_schema.tables WHERE table_schema = DATABASE() AND table_name = "passengers_on_flights";
IF IfExist = FALSE THEN
SELECT 'ERROR: passengers_on_flights DOES NOT EXIST' AS ErrorMessage;
ELSE 
SELECT * FROM passengers_on_flights WHERE route_id BETWEEN BeginRange AND EndRange;
END IF;
END &&
DELIMITER ;

CALL PassengerDetails(4 , 20);

-- 17

DELIMITER &&
CREATE PROCEDURE RouteDetails()
BEGIN
SELECT * FROM routes WHERE distance_miles > 2000;
END &&
DELIMITER ;

CALL RouteDetails();

-- 18

DELIMITER &&
CREATE PROCEDURE DistanceTravelled() 
BEGIN
SELECT *,
CASE
WHEN distance_miles >= 0 AND distance_miles <= 2000 THEN "Short Distance Travel (SDT)"
WHEN distance_miles >= 2000 AND distance_miles <= 6500 THEN "Intermediate Distance Travel (IDT)"
WHEN distance_miles > 6500 THEN "Long Distance Travel (LDT)"
END AS DistanceTravelledCategories
FROM routes;
END &&
DELIMITER ;

CALL DistanceTravelled();

-- 19

DELIMITER &&
CREATE FUNCTION ComplimentaryServices(class_id VARCHAR(20)) RETURNS VARCHAR(20)  DETERMINISTIC
BEGIN
IF class_id = "Bussiness" THEN RETURN "YES";
ELSEIF class_id = "Economy Plus" THEN RETURN "YES";
ELSE RETURN "NO";
END IF;
END &&
DELIMITER ;

SELECT *, ComplimentaryServices(class_id) AS ComplimentaryService FROM ticket_details;

-- 20

DROP PROCEDURE LNameCheck;


DELIMITER $$
CREATE PROCEDURE LNameCheck() 
   BEGIN
   DECLARE last_name VARCHAR(20);
   DECLARE customer_id INT;
   DECLARE LoopFinish INT DEFAULT 0;
   DECLARE cur CURSOR FOR SELECT customer_id, last_name
   FROM customer
   WHERE last_name LIKE '%Scott'
   ORDER BY customer_id ASC;
   DECLARE CONTINUE HANDLER FOR NOT FOUND SET LoopFinish = 1;
   OPEN cur;
   Get_Cus:LOOP
   FETCH cur INTO customer_id,last_name;
   IF LoopFinish = 1 THEN
   LEAVE Get_Cus;
   END IF;
   END LOOP Get_Cus;
   END $$
   DELIMITER ;
   
   CALL LNameCheck();



DELIMITER $$
CREATE PROCEDURE LNameCheck() 
   BEGIN
   DECLARE last_name VARCHAR(20);
   DECLARE customer_id INT;
   DECLARE cur CURSOR FOR SELECT customer_id, last_name
   FROM customer
   WHERE last_name LIKE '%Scott'
   ORDER BY customer_id ASC;
   OPEN cur;
   FETCH NEXT FROM cur INTO customer_id,last_name;
   CLOSE cur;
   END $$
   DELIMITER ;







