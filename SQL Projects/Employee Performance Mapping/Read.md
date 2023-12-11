# Employee Performance Mapping 💼

Raise the organization's performance by extracting specific data from employee's database by using **SQL**.


## Table of Contents 🗒️ 📝
- [Project Description](#project-description)
- [Database Structure](#database-structure)
- [Analysis Tasks](#analysis-tasks)
- [Contact Information](#contact-information)


## Project Description 👩‍🏫
Generate reports on employee details, their performance, and the projects they have been involved in. These reports will help the HR department analyze the employee database and extract specific data based on different requirements.
To facilitate a better understanding of employee performance, managers have provided performance ratings for each employee.
In this project we will find the maximum salary among employees, ensure that all job positions meet the organization's profile standards, calculate bonuses to determine additional expenses, and identify employees who require training to improve overall performance.

## Database Structure 📁
The project database consists of the following tables:

### emp_record_table 👩‍💼👨‍💼
This table contains information about all the employees.

Columns:
- `EMP_ID`: ID of the employee
- `FIRST_NAME`: First name of the employee
- `LAST_NAME`: Last name of the employee
- `GENDER`: Gender of the employee
- `ROLE`: Post of the employee
- `DEPT`: Field of the employee
- `EXP`: Years of experience the employee has
- `COUNTRY`: Country in which the employee is presently living
- `CONTINENT`: Continent in which the country is located
- `SALARY`: Salary of the employee
- `EMP_RATING`: Performance rating of the employee
- `MANAGER_ID`: The manager under whom the employee is assigned
- `PROJ_ID`: The project on which the employee is working or has worked on

### Proj_table 🧑‍💻
This table contains information about the projects.

Columns:
- `PROJECT_ID`: ID for the project
- `PROJ_Name`: Name of the project
- `DOMAIN`: Field of the project
- `START_DATE`: Day the project began
- `CLOSURE_DATE`: Day the project was or will be completed
- `DEV_QTR`: Quarter in which the project was scheduled
- `STATUS`: Current status of the project

### Data_science_team 📄
This table contains information about all the employees in the Data Science team.

Columns:
- `EMP_ID`: ID of the employee
- `FIRST_NAME`: First name of the employee
- `LAST_NAME`: Last name of the employee
- `GENDER`: Gender of the employee
- `ROLE`: Post of the employee
- `DEPT`: Field of the employee
- `EXP`: Years of experience the employee has
- `COUNTRY`: Country in which the employee is presently living
- `CONTINENT`: Continent in which the country is located

## Analysis Tasks 🔍
To analyze the project database and generate reports, the following tasks are required:
- Fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the 
employee record table, and make a list of employees and details of their department.
- Fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING 
if the EMP_RATING is: 
less than two
greater than four 
between two and four
- Concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance 
department from the employee table and then give the resultant column alias as NAME.
- List only those employees who have someone reporting to them. Also, show the 
number of reporters (including the President).
-  List down all the employees from the healthcare and finance departments using union.
-  List down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, 
DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.
- Calculate the minimum and the maximum salary of the employees in each role. - Assign ranks to each employee based on their experience.
- Create a view that displays employees in various countries whose salary is more than six thousand.
- Find employees with experience of more than ten years.
- Create a stored procedure to retrieve the details of the employees whose experience is more than three years.
- Check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
- Find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
- Calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
- Calculate the average salary distribution based on the continent and country.


## Contact Information 📩
For any questions, suggestions, or inquiries related to the Employee Performance Mapping Project, please reach out to:

Razan Alhasan
  - Email: Alhasan.razan1@gmail.com

We value your feedback and are committed to providing the best possible support and assistance for your project analysis needs.

Thank you for using the Employee Performance Mapping Project! 🙏
