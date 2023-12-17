# Air Cargo Analysis 🛫

Improve the company’s operability and becomes more customer-centric and a favorable choice for air travel by identifying the regular customers to provide offers, analyze the busiest route which helps to increase the number of aircraft required and prepare an analysis to determine the ticket sales details. 🎇


## Table of Contents 📝
- [Project Description](#project-description)
- [Database Structure](#database-structure)
- [Analysis Tasks](#analysis-tasks)
- [Contact Information](##Contact-Information)


## Project Description 👩‍🏫
Generate reports on regular passengers, busiest routs and ticket sales details, these reports will help the company to provide specific offers and determine the ticket sales details which will increase the company’s proficiency and producibility. 

## Database Structure 📁
The project database consists of the following tables:

### Customer 🧑 👧
This table contains information of the customers.
Columns:
- `customer_id`: ID of the customer
- `first_name`: First name of the customer
- `last_name`: Last name of the customer
- `date_of_birth`: Date of birth of the customer
- `gender`: Gender of the customer
### passengers_on_flights 💺 🧘
This table contains information about the travel details
Columns:
- `aircraft_id`: ID of each aircraft in a brand
- `route_id`: Route ID of the departure and arrival locations
- `customer_id`: ID of the customer
- `depart`: Departure place from the airport
- `arrival`: Arrival place at the airport
- `seat_num`: Unique seat number for each passenger
- `class_id`: ID of the travel class
- `travel_date`: Travel date of each passenger
- `flight_num`: Specific flight number for each route

### ticket_details 🎫
This table contains information about the ticket details.
Columns:
- `p_date`: Ticket purchase date
- `customer_id`: ID of the customer
- `aircraft_id`: ID of each aircraft in a brand
- `class_id`: ID of travel class
- `no_of_tickets`: Number of tickets purchased
- `a_code`: Code of each airport
- `price_per_ticket`: Price of a ticket
- `brand`: Aviation service provider for each aircraft

### routes 
This table contains information about the route details.
Columns:
- `Route_id`: Route ID of the departure and arrival locations
- `Flight_num`: Specific flight number for each route
- `Origin_airport`: Departure location
- `Destination_airport`: Arrival location
- `Aircraft_id`: ID of each aircraft in a brand
- `Distance_miles`: Distance between the departure and arrival locations

## Analysis Tasks 🔍
To analyze the project database and generate reports, the following tasks are required:
-	Display all the passengers (customers) who have travelled in routes 01 to 25. 
-	Identify the number of passengers and total revenue in business class.
-	Display the full name of the customer by extracting the first name and last name.
-	Extract the customers who have registered and booked a ticket.
-	Identify the customer’s first name and last name based on their customer ID and brand (Emirates).
-	Identify the customers who have travelled by Economy Plus class.
-	Identify whether the revenue has crossed 10000.
-	Create and grant access to a new user to perform operations on a database.
-	Find the maximum ticket price for each class.
-	Extract the passengers whose route ID is 4 by improving the speed and performance.
-	View the execution plan of the passengers_on_flights table.
-	Calculate the total price of all tickets booked by a customer across different aircraft IDs.
-	Create a view with only business class customers along with the brand of airlines.
-	Create a stored procedure to get the details of all passengers flying between a range of routes defined in run time. Also, return an error message if the table doesn't exist.
-	Create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.
-	Create a stored procedure that groups the distance travelled by each flight into three categories. The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500.
-	Extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific class using a stored function in stored procedure. 
-	Extract the first record of the customer whose last name ends with Scott using a cursor.

## Contact Information 📩
For any questions, suggestions, or inquiries related to the Air Cargo Analysis Project, please reach out to:

Razan Alhasan
  - Email: Alhasan.razan1@gmail.com

We value your feedback and are committed to providing the best possible support and assistance for your project analysis needs.

Thank you for checking out the Air Cargo Analysis Project! 🙏
