---
title:  "THM: SQL Injection"
date:   2024-02-23 21:00:00 +0000
categories: [WebHacking]
tags: [WebHacking]
---

![image](/assets/img/sql-inject.png)

---
Ref: 

- [THM SQL Injection](https://tryhackme.com/room/sqlinjectionlm)

- [Cheat Sheet - Command Injection](https://github.com/payloadbox/command-injection-payload-list) 

- [Request Bin Tool](https://pipedream.com/requestbin)

- [FFUF tool and wordlist - Github](https://github.com/ffuf/ffuf)

- [Crack Station Database](https://crackstation.net/)

- [Decode from Base64 format](https://www.base64decode.org/)

- [XSS Hunter Express](https://github.com/mandatoryprogrammer/xsshunter-express)

- [Link](https://www.youtube.com/)

---




Task 1  Brief
---
```SQL (Structured Query Language)``` Injection, mostly referred to as SQLi, is an attack on a web application database server that causes malicious queries to be executed. When a web application communicates with a database using input from a user that hasn't been properly validated, there runs the ```potential of an attacker being able to steal, delete or alter private and customer data and also attack the web applications authentication methods to private or customer areas```. This is why as well as ```SQLi``` being one of the oldest web application vulnerabilities, it also can be the most damaging.

In this room, you'll learn what databases are, what SQL is with some basic SQL commands, how to detect SQL vulnerabilities, ```how to exploit SQLi vulnerabilities``` and as a developer how you can protect yourself against SQL Injection.

---

What does SQL stand for?
```
Structureed Query Language
```

Task 2  What is a Database?
---

If you're not used to working with databases or exploiting them, there's probably some new terminology to get used to, so let's start with some basics on how databases are structured and how they work.



### What is a database?

A database is a way of electronically storing collections of data in an organised manner. A database is controlled by a DBMS which is an acronym for  Database Management System, DBMS's fall into two camps ```Relational``` or ```Non-Relational```, the focus of this room will be on Relational databases,  some common one's you'll come across are MySQL, Microsoft SQL Server, Access, PostgreSQL and SQLite. 

We'll explain the difference between Relational and Non-Relational databases at the end of this task but first, it's important to learn a few terms.


Within a ```DBMS```, you can have multiple databases, each containing its own set of related data. 

For example, 

you may have a database called "shop". Within this database, you want to store information about products available to purchase, users who have signed up to your online shop, and information about the orders you've received. You'd store this information separately in the database using something called ```tables```, the tables are identified with a unique name for each one. You can see this structure in the diagram below, but you can also see how a business might have other separate databases to store staff information or the accounts team.

![img](/assets/img/sql-inject01.png)

### What are tables?

A table is made up of columns and rows, a useful way to imagine a table is like a grid with the columns going across the top from left to right containing the name of the cell and the rows going from top to bottom with each one having the actual data.

![img](/assets/img/sql-inject02.png)

Columns:

Each column, better referred to as a field has a unique name per table. When creating a column, you also set the type of data it will contain, common ones being integer (numbers), strings (standard text) or dates. Some databases can contain much more complex data, such as geospatial, which contains location information. Setting the data type also ensures that incorrect information isn't stored, such as the string "hello world" being stored in a column meant for dates. If this happens, the database server will usually produce an error message. A column containing an integer can also have an auto-increment feature enabled; this gives each row of data a unique number that grows (increments) with each subsequent row, doing so creates what is called a key field, a key field has to be unique for every row of data which can be used to find that exact row in SQL queries.



Rows:

Rows or records are what contains the individual lines of data. When you add data to the table, a new row/record is created, and when you delete data, a row/record is removed.





### Relational Vs Non-Relational Databases:
```A relational database```, stores information in tables and often the tables have shared information between them, they use columns to specify and define the data being stored and rows to actually store the data. The tables will often contain a column that has a ```unique ID (primary key)``` which will then be used in other tables to reference it and cause a relationship between the tables, hence the name relational database.



```Non-relational databases``` sometimes called NoSQL on the other hand is any sort of database that ```doesn't use tables```, columns and rows to store the data, a specific database layout doesn't need to be constructed so each row of data can contain different information which can give more flexibility over a relational database.  Some popular databases of this type are ```MongoDB```, ```Cassandra``` and ```ElasticSearch```.



Now you've learnt what a database is, let's learn how we can actually talk to it using SQL.

---

What is the acronym for the software that controls a database?
```
Answer : DBMS
```
What is the name of the grid-like structure which holds the data?
```
Answer : Table
```
---

Task 3  What is SQL?
---
SQL (Structured Query Language) is a feature-rich language used for querying databases, these SQL queries are better referred to as statements.



The simplest of the commands which we'll cover in this task is used to retrieve (select), update, insert and delete data. Although somewhat similar, some databases servers have their own syntax and slight changes to how things work. All of these examples are based on a MySQL database. After learning the lessons, you'll easily be able to search for alternative syntax online for the different servers. It's worth noting that SQL syntax is not case sensitive.


--- 

### SELECT
The first query type we'll learn is the ```SELECT``` query used to retrieve data from the database. 
 

```
select * from users;
```

- The first-word SELECT tells the database we want to retrieve some data, the * tells the database we want to receive back all columns from the table. For example, the table may contain three columns (id, username and password). "from users" tells the database we want to retrieve the data from the table named users. Finally, the semicolon at the end tells the database that this is the end of the query. 

![img](/assets/img/sql-inject03.png)
```
select username,password from users;
```
- The next query is similar to the above, but this time, instead of using the * to return all columns in the database table, we are just requesting the username and password field.

---

The following query, like the first, returns all the columns by using the * selector and then the "LIMIT 1" clause forces the database only to return one row of data. 

Changing the query to "LIMIT 1,1" forces the query to skip the first result, and then "LIMIT 2,1" skips the first two results, and so on. You need to remember the first number tells the database how many results you wish to skip, and the second number tells the database how many rows to return.

```
select * from users LIMIT 1;
```
![img](/assets/img/sql-inject04.png)

Lastly, we're going to utilise the where clause; this is how we can finely pick out the exact data we require by returning data that matches our specific clauses:

```
select * from users where username='admin';
```
![img](/assets/img/sql-inject05.png)
![img](/assets/img/sql-inject06.png)
![img](/assets/img/sql-inject07.png)
![img](/assets/img/sql-inject08.png)
```
SELECT name,address,city,postcode from customers UNION SELECT company,address,city,postcode from suppliers;
```
![img](/assets/img/sql-inject09.png)
![img](/assets/img/sql-inject10.png)
![img](/assets/img/sql-inject11.png)

```
insert into users (username,password) values ('bob','password123');
```
```
update users SET username='root',password='pass123' where username='admin';
```
```
delete from users where username='martin';
```
```
delete from users;
```


What SQL statement is used to retrieve data?
```
Answer : Select
```
What SQL clause can be used to retrieve data from multiple tables?
```
Answer : Union
```
What SQL statement is used to add data?
```
Answer : Insert

```

Task 4  What is SQL Injection?
---
### What is SQL Injection?
The point wherein a web application using SQL can turn into SQL Injection is when user-provided data gets included in the SQL query.

### What does it look like?
Take the following scenario where you've come across an online blog, and each blog entry has a unique id number. The blog entries may be either set to public or private depending on whether they're ready for public release. The URL for each blog entry may look something like this:
```
https://website.thm/blog?id=1
```
From the URL above, you can see that the blog entry been selected comes from the id parameter in the query string. The web application needs to retrieve the article from the database and may use an SQL statement that looks something like the following:
```
SELECT * from blog where id=1 and private=0 LIMIT 1;
```
From what you've learned in the previous task, you should be able to work out that the SQL statement above is looking in the blog table for an article with the ```id number of 1``` and the ```private column set to 0```, which means it's able to be viewed by the public and limits the results to only one match.

As was mentioned at the start of this task, SQL Injection is introduced when user input is introduced into the database query. In this instance, the id parameter from the query string is used directly in the SQL query.

Let's pretend article id 2 is still locked as private, so it cannot be viewed on the website. We could now instead call the URL:
```
https://website.thm/blog?id=2;--
```
Which would then, in turn, produce the SQL statement:
```
SELECT * from blog where id=2;-- and private=0 LIMIT 1;
```

```
id=2;--
```
The ```semicolon``` in the URL ```signifies the end of the SQL statement```, and 
The ```two dashes``` cause everything afterwards to be ```treated as a comment```. By doing this, you're just, in fact, running the query:
```
SELECT * from blog where id=2;--
```
Which will return the article with an id of 2 whether it is set to public or not.

This was just one example of an SQL Injection vulnerability of a type called ```In-Band SQL Injection```; 

There are 3 types in total ```In-Band```, ```Blind``` and ```Out Of Band```, which we'll discuss over the next tasks.

---

What character signifies the end of an SQL query?
```
Answer: ;
```


---

Task 5  In-Band SQLi
---