/* =========================================================
   AIRLINE RESERVATION SYSTEM
   MySQL Project
   ========================================================= */


/* =========================================================
   1. CREATE DATABASE
   ========================================================= */

CREATE DATABASE airline_reservation;

USE airline_reservation;


/* =========================================================
   2. CREATE CUSTOMERS TABLE
   ========================================================= */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE
);


/* =========================================================
   3. CREATE FLIGHTS TABLE
   ========================================================= */

CREATE TABLE flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) UNIQUE NOT NULL,
    airline VARCHAR(50) NOT NULL,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    total_seats INT NOT NULL
);


/* =========================================================
   4. CREATE SEATS TABLE
   ========================================================= */

CREATE TABLE seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    seat_class VARCHAR(20) NOT NULL,
    seat_status VARCHAR(20) DEFAULT 'Available',

    FOREIGN KEY (flight_id)
        REFERENCES flights(flight_id),

    UNIQUE (flight_id, seat_number)
);


/* =========================================================
   5. CREATE BOOKINGS TABLE
   ========================================================= */

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    flight_id INT NOT NULL,
    seat_id INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (flight_id)
        REFERENCES flights(flight_id),

    FOREIGN KEY (seat_id)
        REFERENCES seats(seat_id)
);


/* =========================================================
   6. INSERT CUSTOMERS
   ========================================================= */

INSERT INTO customers
(first_name, last_name, email, phone)
VALUES
('Anas', 'Shaik', 'anas@gmail.com', '9876543210'),
('Rahul', 'Kumar', 'rahul@gmail.com', '9876543211'),
('Aisha', 'Khan', 'aisha@gmail.com', '9876543212'),
('Priya', 'Sharma', 'priya@gmail.com', '9876543213'),
('Arjun', 'Reddy', 'arjun@gmail.com', '9876543214');


/* =========================================================
   7. INSERT FLIGHTS
   ========================================================= */

INSERT INTO flights
(
    flight_number,
    airline,
    source,
    destination,
    departure_time,
    arrival_time,
    total_seats
)
VALUES
(
    'AI101',
    'Air India',
    'Delhi',
    'Mumbai',
    '2026-10-10 08:00:00',
    '2026-10-10 10:15:00',
    180
),
(
    '6E202',
    'IndiGo',
    'Hyderabad',
    'Bangalore',
    '2026-10-11 09:30:00',
    '2026-10-11 10:45:00',
    180
),
(
    'SG303',
    'SpiceJet',
    'Chennai',
    'Delhi',
    '2026-10-12 14:00:00',
    '2026-10-12 16:45:00',
    180
),
(
    'AI404',
    'Air India',
    'Mumbai',
    'Hyderabad',
    '2026-10-13 18:00:00',
    '2026-10-13 19:45:00',
    180
);


/* =========================================================
   8. INSERT SEATS
   ========================================================= */

INSERT INTO seats
(flight_id, seat_number, seat_class, seat_status)
VALUES
(1, '1A', 'Business', 'Available'),
(1, '1B', 'Business', 'Available'),
(1, '2A', 'Economy', 'Available'),
(1, '2B', 'Economy', 'Available'),
(1, '3A', 'Economy', 'Available'),
(1, '3B', 'Economy', 'Available'),

(2, '1A', 'Business', 'Available'),
(2, '1B', 'Business', 'Available'),
(2, '2A', 'Economy', 'Available'),
(2, '2B', 'Economy', 'Available'),
(2, '3A', 'Economy', 'Available'),
(2, '3B', 'Economy', 'Available'),

(3, '1A', 'Business', 'Available'),
(3, '1B', 'Business', 'Available'),
(3, '2A', 'Economy', 'Available'),
(3, '2B', 'Economy', 'Available'),
(3, '3A', 'Economy', 'Available'),
(3, '3B', 'Economy', 'Available'),

(4, '1A', 'Business', 'Available'),
(4, '1B', 'Business', 'Available'),
(4, '2A', 'Economy', 'Available'),
(4, '2B', 'Economy', 'Available'),
(4, '3A', 'Economy', 'Available'),
(4, '3B', 'Economy', 'Available');


/* =========================================================
   9. INSERT BOOKINGS
   ========================================================= */

INSERT INTO bookings
(customer_id, flight_id, seat_id, booking_status)
VALUES
(1, 1, 3, 'Confirmed'),
(2, 1, 4, 'Confirmed'),
(3, 2, 9, 'Confirmed'),
(4, 3, 15, 'Confirmed'),
(5, 4, 21, 'Confirmed');


/* =========================================================
   10. BASIC SELECT QUERIES
   ========================================================= */

SELECT * FROM customers;

SELECT * FROM flights;

SELECT * FROM seats;

SELECT * FROM bookings;


/* =========================================================
   11. FLIGHT SEARCH
   ========================================================= */

SELECT
    flight_id,
    flight_number,
    airline,
    source,
    destination,
    departure_time,
    arrival_time
FROM flights
WHERE source = 'Hyderabad'
  AND destination = 'Bangalore';


/* Search flights from a city */

SELECT *
FROM flights
WHERE source = 'Delhi';


/* Search flights to a city */

SELECT *
FROM flights
WHERE destination = 'Mumbai';


/* Search flights by date */

SELECT *
FROM flights
WHERE DATE(departure_time) = '2026-10-11';


/* =========================================================
   12. AVAILABLE SEATS
   ========================================================= */

SELECT
    seat_id,
    flight_id,
    seat_number,
    seat_class
FROM seats
WHERE flight_id = 1
  AND seat_status = 'Available';


/* Available economy seats */

SELECT
    seat_id,
    seat_number,
    seat_class
FROM seats
WHERE flight_id = 1
  AND seat_class = 'Economy'
  AND seat_status = 'Available';


/* =========================================================
   13. JOIN - BOOKING + CUSTOMER
   ========================================================= */

SELECT
    b.booking_id,
    c.customer_id,
    c.first_name,
    c.last_name,
    b.booking_status
FROM bookings b
INNER JOIN customers c
    ON b.customer_id = c.customer_id;


/* =========================================================
   14. JOIN - BOOKING + FLIGHT
   ========================================================= */

SELECT
    b.booking_id,
    f.flight_number,
    f.airline,
    f.source,
    f.destination,
    b.booking_status
FROM bookings b
INNER JOIN flights f
    ON b.flight_id = f.flight_id;


/* =========================================================
   15. COMPLETE BOOKING REPORT
   ========================================================= */

SELECT
    b.booking_id,
    c.first_name,
    c.last_name,
    f.flight_number,
    f.airline,
    f.source,
    f.destination,
    s.seat_number,
    s.seat_class,
    b.booking_date,
    b.booking_status
FROM bookings b
INNER JOIN customers c
    ON b.customer_id = c.customer_id
INNER JOIN flights f
    ON b.flight_id = f.flight_id
INNER JOIN seats s
    ON b.seat_id = s.seat_id;


/* =========================================================
   16. COUNT QUERIES
   ========================================================= */

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_flights
FROM flights;

SELECT COUNT(*) AS total_bookings
FROM bookings;


/* =========================================================
   17. BOOKINGS PER CUSTOMER
   ========================================================= */

SELECT
    customer_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY customer_id;


/* =========================================================
   18. BOOKINGS PER FLIGHT
   ========================================================= */

SELECT
    flight_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY flight_id;


/* =========================================================
   19. FLIGHTS WITH MORE THAN 1 BOOKING
   ========================================================= */

SELECT
    flight_id,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY flight_id
HAVING COUNT(*) > 1;


/* =========================================================
   20. SORT BOOKINGS
   ========================================================= */

SELECT *
FROM bookings
ORDER BY booking_date DESC;


/* =========================================================
   21. SORT FLIGHTS BY DEPARTURE
   ========================================================= */

SELECT *
FROM flights
ORDER BY departure_time ASC;


/* =========================================================
   22. SUBQUERY
   ========================================================= */

/* Customers who have made bookings */

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM bookings
);


/* Flights that have bookings */

SELECT *
FROM flights
WHERE flight_id IN (
    SELECT flight_id
    FROM bookings
);


/* =========================================================
   23. UPDATE BOOKING
   ========================================================= */

UPDATE bookings
SET booking_status = 'Cancelled'
WHERE booking_id = 1;


/* =========================================================
   24. UPDATE SEAT
   ========================================================= */

UPDATE seats
SET seat_status = 'Available'
WHERE seat_id = 3;


/* =========================================================
   25. BOOKING SUMMARY VIEW
   ========================================================= */

CREATE VIEW booking_summary AS
SELECT
    b.booking_id,
    c.first_name,
    c.last_name,
    c.email,
    f.flight_number,
    f.airline,
    f.source,
    f.destination,
    f.departure_time,
    f.arrival_time,
    s.seat_number,
    s.seat_class,
    b.booking_date,
    b.booking_status
FROM bookings b
INNER JOIN customers c
    ON b.customer_id = c.customer_id
INNER JOIN flights f
    ON b.flight_id = f.flight_id
INNER JOIN seats s
    ON b.seat_id = s.seat_id;


/* View booking summary */

SELECT *
FROM booking_summary;


/* Confirmed bookings */

SELECT *
FROM booking_summary
WHERE booking_status = 'Confirmed';


/* =========================================================
   26. FLIGHT AVAILABILITY VIEW
   ========================================================= */

CREATE VIEW flight_availability AS
SELECT
    f.flight_id,
    f.flight_number,
    f.airline,
    f.source,
    f.destination,
    COUNT(s.seat_id) AS total_seats,
    SUM(
        CASE
            WHEN s.seat_status = 'Available'
            THEN 1
            ELSE 0
        END
    ) AS available_seats,
    SUM(
        CASE
            WHEN s.seat_status = 'Booked'
            THEN 1
            ELSE 0
        END
    ) AS booked_seats
FROM flights f
LEFT JOIN seats s
    ON f.flight_id = s.flight_id
GROUP BY
    f.flight_id,
    f.flight_number,
    f.airline,
    f.source,
    f.destination;


/* View flight availability */

SELECT *
FROM flight_availability;


/* =========================================================
   27. TRIGGER - AFTER BOOKING
   ========================================================= */

DELIMITER $$

CREATE TRIGGER after_booking_insert
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN

    UPDATE seats
    SET seat_status = 'Booked'
    WHERE seat_id = NEW.seat_id;

END $$

DELIMITER ;


/* =========================================================
   28. TRIGGER - AFTER CANCELLATION
   ========================================================= */

DELIMITER $$

CREATE TRIGGER after_booking_cancel
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN

    IF NEW.booking_status = 'Cancelled'
       AND OLD.booking_status <> 'Cancelled' THEN

        UPDATE seats
        SET seat_status = 'Available'
        WHERE seat_id = NEW.seat_id;

    END IF;

END $$

DELIMITER ;


/* =========================================================
   29. TEST BOOKING TRIGGER
   ========================================================= */

INSERT INTO bookings
(customer_id, flight_id, seat_id, booking_status)
VALUES
(1, 2, 10, 'Confirmed');


/* Check seat */

SELECT *
FROM seats
WHERE seat_id = 10;


/* =========================================================
   30. TEST CANCELLATION TRIGGER
   ========================================================= */

UPDATE bookings
SET booking_status = 'Cancelled'
WHERE booking_id = 6;


/* Check seat after cancellation */

SELECT *
FROM seats
WHERE seat_id = 10;


/* =========================================================
   31. SHOW TABLES
   ========================================================= */

SHOW TABLES;


/* =========================================================
   32. DESCRIBE TABLES
   ========================================================= */

DESC customers;

DESC flights;

DESC seats;

DESC bookings;


/* =========================================================
   33. SHOW VIEWS
   ========================================================= */

SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';


/* =========================================================
   34. SHOW TRIGGERS
   ========================================================= */

SHOW TRIGGERS;


/* =========================================================
   END OF AIRLINE RESERVATION SYSTEM
   ========================================================= */