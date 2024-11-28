#					     ASSIGNMENT - 2
create database library;         # here we create a database name library -  Q1
use library;                       # here we use this database library
create table books(                 # here we create a table name of books in which we specify the entries of  the table
id int primary key auto_increment,
title varchar (255),
author varchar (100),
year  varchar (100),
genre varchar (100));
select*from books;              #here we use this syntax to check weather our table is created or not
insert into books(id,title,author,year,genre)values          # here we use insert syntax to insert the data values in table - Q2
(1,"The Great Gatsby", "F.Scott Fitzgerald", 1925, "Fiction"),
(2,"Pride and Prejudice", "Jane Austen", 1813, "Romance"),
(3,"To Kill a Mockingbird", "Harper Lee", 1960, "Fiction"),
(4,"1984", "George Orwell", 1949, "Dystopian"),
(5,"Moby Dick", "Herman Melville", 1851, "Adventure");
#Q3 Write a query to select all books where the title starts with the letter 'T' using the LIKE operator.
select*from books where title like "T%";
#Q4 Write a query to find all books where the author's last name ends with 'son' using the LIKE operator.
select*from books where author like "%son";
#Q5 Write a query to find all books where the title contains the word 'and' using the LIKE operator.
select title from books where title like "%and%";
#Q6 Write a query to retrieve all books where the title ends with the word 'bird' using the LIKE operator.
select*from books where title like "%bird";
#Q7 Write a query to find all books where the title has exactly 3 characters using the REGEXP operator.
select*from books where title regexp "___";
#Q8 Write a query to select all books where the title contains a number using the REGEXP operator.
select*from books where title regexp '[0-9]';
#Q9 Write a query to retrieve all books where the author's name starts with any letter between 'A' and 'J' using the REGEXP operator.
select*from books where author regexp '^[aj]';
#Q10 Write a query to select all books where the genre is either 'Fiction' or 'Adventure' using the REGEXP operator.
select*from books where genre regexp "fiction|adventure";
#Q11 Write a query to find all books where the title contains at least one uppercase letter using the REGEXP operator.
select*from books where title regexp "_T";
#Q12 Write a query to find all books where the year of publication is between 1800 and 1950 using the LIKE operator.
select*from books where year like '18%' or year like '19%';
#Q13 Write a query to retrieve all book
# where the author's name contains exactly two words using the REGEXP operator.
select*from books where author regexp '[ae]';
#Q14 Write a query to find all books where the title starts with the letter 'P' and contains exactly two words using the REGEXP operator.
select*from books where title regexp"p[a-zA-Z]";
#Q15 Write a query to find all books where the title contains any special characters (e.g., '!', '@', '#', etc.) using the REGEXP operator.
select*from books where title regexp "'@','#','!'";