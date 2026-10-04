# SQL_Project-Elevate-Labs

# ✈️ Airline Reservation System – MySQL

## 📌 Project Overview

The **Airline Reservation System** is a SQL-based database project developed using **MySQL** to manage airline flights, customers, seats, and bookings.

The project demonstrates practical implementation of **database design, normalization, constraints, SQL queries, joins, subqueries, views, and triggers**.

The system is designed to manage flight information, customer details, seat availability, bookings, and cancellations while maintaining data consistency through relational database constraints and automated triggers.

---

## 🎯 Project Objective

The main objective of this project is to design and implement a relational database system that can:

- Manage customer information
- Store and manage flight details
- Manage seats for different flights
- Create and manage flight bookings
- Track seat availability
- Search available flights
- Handle booking cancellations
- Generate booking summary reports
- Automatically update seat status using triggers

---

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **IDE:** MySQL Workbench
- **Language:** SQL
- **Version Control:** Git & GitHub

---

## 🗂️ Database Schema

The system consists of four main tables:

### 1. Customers

Stores customer information.

| Column | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `first_name` | Customer first name |
| `last_name` | Customer last name |
| `email` | Customer email |
| `phone` | Customer phone number |

### 2. Flights

Stores flight information.

| Column | Description |
|---|---|
| `flight_id` | Unique flight identifier |
| `flight_number` | Flight number |
| `airline` | Airline name |
| `source` | Departure city |
| `destination` | Arrival city |
| `departure_time` | Departure date and time |
| `arrival_time` | Arrival date and time |
| `total_seats` | Total seats available |

### 3. Seats

Stores seat information for each flight.

| Column | Description |
|---|---|
| `seat_id` | Unique seat identifier |
| `flight_id` | Associated flight |
| `seat_number` | Seat number |
| `seat_class` | Economy / Business |
| `seat_status` | Available / Booked |

### 4. Bookings

Stores customer booking information.

| Column | Description |
|---|---|
| `booking_id` | Unique booking identifier |
| `customer_id` | Customer who made the booking |
| `flight_id` | Booked flight |
| `seat_id` | Booked seat |
| `booking_date` | Date of booking |
| `booking_status` | Confirmed / Cancelled |

---

## 🔗 Entity Relationships

```text
Customers
    │
    │ customer_id
    ▼
Bookings
    │
    ├──────────────► Flights
    │                  │
    │                  │ flight_id
    │                  ▼
    └──────────────► Seats
