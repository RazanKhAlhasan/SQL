/*
1- Create route_details table using suitable data types for the fields, 
such as route_id, flight_num, origin_airport, destination_airport, aircraft_id, and 
distance_miles. Implement the check constraint for the flight number and unique 
constraint for the route_id fields. Also, make sure that the distance miles field is 
greater than 0
    */

CREATE TABLE route_details (
route_id INT,
CONSTRAINT UniqueRouteID UNIQUE (route_id),
flight_num VARCHAR(20),
CONSTRAINT CheckFlightNum CHECK (flight_num REGEXP "[A-Z0-9][A-Z0-9][AZ0-9][A-Z0-9]"), -- REGEXP IS USED WHEN WE WHAT TO CHECK A PATTERN
origin_airport VARCHAR(20),
destination_airport VARCHAR(20),
aircraft_id VARCHAR(20),
distance_miles INT,
CONSTRAINT DistanceMilesGreater CHECK (distance_miles > 0)
);


/*
2- Display all the passengers (customers) who have travelled in routes 
01 to 25. Take data from the passengers_on_flights table.
    */

SELECT * FROM passengers_on_flights
WHERE route_id BETWEEN 0 AND 25
ORDER BY route_id ASC;


/*
3- Identify the number of passengers and total revenue in business 
class from the ticket_details table
    */

SELECT COUNT(customer_id) AS NumberOfPassengers , class_id, 
SUM(Price_per_ticket) AS TotalRevenue
FROM ticket_details
WHERE class_id = "Bussiness";

/*
4- Display the full name of the customer by extracting the first name 
and last name from the customer table.
    */

SELECT COUNT(customer_id) AS NumberOfPassengers , class_id, 
SUM(Price_per_ticket) AS TotalRevenue
FROM ticket_details
WHERE class_id = "Bussiness";


/*
5- Extract the customers who have registered and booked a ticket. Use 
data from the customer and ticket_details tables.
    */

SELECT COUNT(customer_id) AS NumberOfPassengers , class_id, 
SUM(Price_per_ticket) AS TotalRevenue
FROM ticket_details
WHERE class_id = "Bussiness";


/*
6- Identify the customer’s first name and last name based on their 
customer ID and brand (Emirates) from the ticket_details table.
    */

SELECT CONCAT(first_name, " ", last_name) AS FullName, brand, p_date
FROM customer C JOIN ticket_details T 
WHERE C.customer_id = T.customer_id AND brand = "Emirates"
ORDER BY T.customer_id ASC;


/*
7- Identify the customers who have travelled by Economy Plus class 
using Group By and Having clause on the passengers_on_flights table
    */

SELECT customer_id, class_id
FROM passengers_on_flights
GROUP BY customer_id
HAVING class_id = "Economy Plus";


/*
8- Identify whether the revenue has crossed 10000 using the IF clause 
on the ticket_details table.
    */

SELECT SUM(Price_per_ticket), IF (SUM(Price_per_ticket) > 10000, "More than 
10000", "Less than 10000") AS TotalRevenue
FROM ticket_details;


/*
9- Create and grant access to a new user to perform operations on a 
database.
    */

CREATE USER junior@localhost IDENTIFIED BY 'junior123';
GRANT EXECUTE ON securitydb.* TO junior@localhost;


/*
10- Find the maximum ticket price for each class using window 
functions on the ticket_details table.
    */

SELECT *, MAX(Price_per_ticket) OVER (PARTITION BY class_id) AS MaxPrice
FROM ticket_details;


/*
11- Extract the passengers whose route ID is 4 by improving the speed 
and performance of the passengers_on_flights table.
    */

CREATE INDEX RouteId4 ON passengers_on_flights(route_id);
SELECT * FROM passengers_on_flights 
WHERE route_id = 4;


/*
12- View the execution plan of the 
passengers_on_flights table for the route ID 4.
    */

SELECT * FROM passengers_on_flights
WHERE route_id = 4;


/*
13- Calculate the total price of all tickets booked by a customer across 
different aircraft IDs using rollup function.
    */

SELECT customer_id, aircraft_id, SUM(Price_per_ticket) AS TotalTicketPrice
FROM ticket_details
GROUP BY customer_id WITH ROLLUP;

/*
14- Create a view with only business class customers along with the 
brand of airlines.
    */

CREATE VIEW BussinessClass AS 
SELECT customer_id, aircraft_id, class_id
FROM ticket_details
WHERE class_id = "Bussiness"
ORDER BY customer_id ASC;
SELECT * FROM BussinessClass;

/*
15- Create a stored procedure to get the details of all passengers flying 
between a range of routes defined in run time. Also, return an error message if the 
table doesn't exist.
    */

DELIMITER &&
CREATE PROCEDURE PassengerDetails(IN BeginRange VARCHAR(20), IN EndRange 
VARCHAR(20))
BEGIN
DECLARE IfExist BOOLEAN DEFAULT FALSE;
SELECT COUNT(*) INTO IfExist 
FROM information_schema.tables WHERE table_schema = DATABASE() AND 
table_name = "passengers_on_flights";
IF IfExist = FALSE THEN
SELECT 'ERROR: passengers_on_flights DOES NOT EXIST' AS ErrorMessage;
ELSE 
SELECT * FROM passengers_on_flights WHERE route_id BETWEEN BeginRange AND 
EndRange;
END IF;
END &&
DELIMITER ;
CALL PassengerDetails(4 , 20);


/*
16- Create a stored procedure that extracts all the details from the 
routes table where the travelled distance is more than 2000 miles.
    */

DELIMITER &&
CREATE PROCEDURE RouteDetails()
BEGIN
SELECT * FROM routes WHERE distance_miles > 2000;
END &&
DELIMITER ;
CALL RouteDetails();

/*
17- Create a stored procedure that groups the distance travelled by 
each flight into three categories. The categories are, short distance travel (SDT) for 
>=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, 
and long-distance travel (LDT) for >6500.
    */

DELIMITER &&
CREATE PROCEDURE DistanceTravelled() 
BEGIN
SELECT *,
CASE
WHEN distance_miles >= 0 AND distance_miles <= 2000 THEN "Short Distance Travel 
(SDT)"
WHEN distance_miles >= 2000 AND distance_miles <= 6500 THEN "Intermediate 
Distance Travel (IDT)"
WHEN distance_miles > 6500 THEN "Long Distance Travel (LDT)"
END AS DistanceTravelledCategories
FROM routes;
END &&
DELIMITER ;
CALL DistanceTravelled();


/*
18- Extract ticket purchase date, customer ID, class ID and specify if 
the complimentary services are provided for the specific class using a stored 
function in stored procedure on the ticket_details table.
Condition:
If the class is Business and Economy Plus, then complimentary services are given as 
Yes, else it is No
    */

DELIMITER &&
CREATE FUNCTION ComplimentaryServices(class_id VARCHAR(20)) RETURNS VARCHAR(20) 
DETERMINISTIC
BEGIN
IF class_id = "Bussiness" THEN RETURN "YES";
ELSEIF class_id = "Economy Plus" THEN RETURN "YES";
ELSE RETURN "NO";
END IF;
END &&
DELIMITER ;
SELECT *, ComplimentaryServices(class_id) AS ComplimentaryService FROM ticket_details;


/*
19- Extract the first record of the customer whose last name ends with 
Scott using a cursor from the customer table.
    */

SQL Code:
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
