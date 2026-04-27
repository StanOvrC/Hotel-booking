# Hotel Booking System

A full-stack Spring Boot web application for hotel reservations. It provides a user-friendly interface for guests to find and book rooms, alongside a comprehensive administrative dashboard for managing the hotel's operations, users, and bookings.

## Tech Stack
**Backend:**
* Java
* Spring Boot (Web, Data JPA, Security)
* Maven

**Database:**
* PostgreSQL

**Frontend:**
* JSP
* Bootstrap
* HTML/CSS

## Features
**Users:**
* Register and log in
* Browse available hotel rooms
* View room details
* Book rooms for specific dates
* Manage personal profiles and booking history

**Admins:**
* Full CRUD operations for rooms (add, edit, view, delete)
* Manage all user accounts

## Quick Start

1. **Database Setup:** * Create a PostgreSQL database named `hotel_booking`. 
   * Run the SQL script located at `sql scripts/scripts.sql` to initialize the database tables and insert sample data (including rooms and default users).
   
2. **Configuration:** * Verify your database credentials in `src/main/resources/application.properties`. Defaults are user `postgres` and password `root`.

3. **Run the App:**
   ```bash
   ./mvnw clean install
   ./mvnw spring-boot:run
   ```
   The application will start at http://localhost:8080/hotel-booking.

## Screenshots
**Rooms page:**
<img width="2846" height="1524" alt="image" src="https://github.com/user-attachments/assets/ff18327a-74f8-4819-8def-c81128b6eb57" />
**Room page:**
<img width="2880" height="1532" alt="image" src="https://github.com/user-attachments/assets/6d7d9b0f-2aa9-452d-beef-a198202de9b4" />
