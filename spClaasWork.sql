Achira Wijesuriya@DESKTOP-8FO0AKP c:\xampp
# mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 10
Server version: 10.4.32-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE DATABASE StoredProcedureClassWork;
Query OK, 1 row affected (0.001 sec)

MariaDB [(none)]> USE StoredProcedureClassWork;
Database changed
MariaDB [StoredProcedureClassWork]> CREATE TABLE customers(
    ->     id INT NOT NULL,
    ->     name VARCHAR(20) NOT NULL,
    ->     age INT NOT NULL,
    ->     address VARCHAR(25),
    ->     salary DECIMAL(18,2),
    ->     PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.056 sec)

MariaDB [StoredProcedureClassWork]> INSERT INTO customers VALUES
    -> (1,'Roshan',32,'Colombo',2000.00),
    -> (2,'Kumar',25,'Kandy',1500.00),
    -> (3,'Dasun',23,'Chilaw',2000.00),
    -> (4,'Arjuna',25,'Maradana',6500.00),
    -> (5,'Kusal',27,'Moratuwa',8500.00),
    -> (6,'Pathum',22,'Kaluthara',4500.00),
    -> (7,'Dilshan',24,'Hambanthota',10000.00);
Query OK, 7 rows affected (0.026 sec)
Records: 7  Duplicates: 0  Warnings: 0

MariaDB [StoredProcedureClassWork]> DELIMITER //
MariaDB [StoredProcedureClassWork]> CREATE PROCEDURE GetCustomerInfo(IN customerAge INT)
    -> BEGIN
    ->     SELECT * FROM customers WHERE age = customerAge;
    -> END //
Query OK, 0 rows affected (0.014 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER ;
MariaDB [StoredProcedureClassWork]> CALL GetCustomerInfo(32);
+----+--------+-----+---------+---------+
| id | name   | age | address | salary  |
+----+--------+-----+---------+---------+
|  1 | Roshan |  32 | Colombo | 2000.00 |
+----+--------+-----+---------+---------+
1 row in set (0.027 sec)

Query OK, 0 rows affected (0.033 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER //
MariaDB [StoredProcedureClassWork]> CREATE PROCEDURE GetDetail(OUT total INT)
    -> BEGIN
    ->     SELECT COUNT(AGE) INTO total FROM customers WHERE age = 32;
    -> END //
Query OK, 0 rows affected (0.017 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER ;
MariaDB [StoredProcedureClassWork]> CALL GetDetail(@total);
Query OK, 1 row affected (0.013 sec)

MariaDB [StoredProcedureClassWork]> SELECT @total;
+--------+
| @total |
+--------+
|      1 |
+--------+
1 row in set (0.000 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER //
MariaDB [StoredProcedureClassWork]> CREATE PROCEDURE increaseSalary(INOUT Cust_Id INT, INOUT curr_Salary DECIMAL(18,2))
    -> BEGIN
    ->     SELECT salary INTO curr_Salary FROM customers WHERE id = Cust_Id;
    ->     SET curr_Salary = curr_Salary * 1.1;
    ->     UPDATE customers SET salary = curr_Salary WHERE id = Cust_Id;
    -> END //
Query OK, 0 rows affected (0.016 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER ;
MariaDB [StoredProcedureClassWork]> SET @customerID = 1;
Query OK, 0 rows affected (0.001 sec)

MariaDB [StoredProcedureClassWork]> SET @salary = 0.0;
Query OK, 0 rows affected (0.000 sec)

MariaDB [StoredProcedureClassWork]> CALL increaseSalary(@customerID, @salary);
Query OK, 2 rows affected (0.009 sec)

MariaDB [StoredProcedureClassWork]> SELECT @salary AS updated_salary;
+----------------+
| updated_salary |
+----------------+
|        2200.00 |
+----------------+
1 row in set (0.000 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER //
MariaDB [StoredProcedureClassWork]> CREATE PROCEDURE GetCustomerName(INOUT Cust_name VARCHAR(20))
    -> BEGIN
    ->     SELECT * FROM customers WHERE name = Cust_name;
    -> END //
Query OK, 0 rows affected (0.014 sec)

MariaDB [StoredProcedureClassWork]> DELIMITER ;
MariaDB [StoredProcedureClassWork]> SET @Cust_name = 'Roshan';
Query OK, 0 rows affected (0.001 sec)

MariaDB [StoredProcedureClassWork]> CALL GetCustomerName(@Cust_name);
+----+--------+-----+---------+---------+
| id | name   | age | address | salary  |
+----+--------+-----+---------+---------+
|  1 | Roshan |  32 | Colombo | 2200.00 |
+----+--------+-----+---------+---------+
1 row in set (0.003 sec)

Query OK, 0 rows affected (0.004 sec)

MariaDB [StoredProcedureClassWork]> SELECT * FROM customers;
+----+---------+-----+-------------+----------+
| id | name    | age | address     | salary   |
+----+---------+-----+-------------+----------+
|  1 | Roshan  |  32 | Colombo     |  2200.00 |
|  2 | Kumar   |  25 | Kandy       |  1500.00 |
|  3 | Dasun   |  23 | Chilaw      |  2000.00 |
|  4 | Arjuna  |  25 | Maradana    |  6500.00 |
|  5 | Kusal   |  27 | Moratuwa    |  8500.00 |
|  6 | Pathum  |  22 | Kaluthara   |  4500.00 |
|  7 | Dilshan |  24 | Hambanthota | 10000.00 |
+----+---------+-----+-------------+----------+
7 rows in set (0.001 sec)

MariaDB [StoredProcedureClassWork]> SELECT * FROM customers WHERE id = 1;
+----+--------+-----+---------+---------+
| id | name   | age | address | salary  |
+----+--------+-----+---------+---------+
|  1 | Roshan |  32 | Colombo | 2200.00 |
+----+--------+-----+---------+---------+
1 row in set (0.001 sec)

MariaDB [StoredProcedureClassWork]> EXIT;
Bye