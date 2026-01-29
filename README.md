# Ocean View Resort – Online Room Reservation System

## 📌 Overview

Ocean View Resort is a beachside hotel in Galle that previously managed room reservations manually. This project delivers a **Java-based web application** to automate reservations, eliminate booking conflicts, and improve operational efficiency.

The system is developed as part of **CIS6003 – Advanced Programming** and follows **industry-standard software engineering practices**.

---

## 🏗 Architecture

* **Architecture Style**: MVC + N-Tier
* **Presentation Layer**: JSP, HTML, CSS
* **Business Layer**: Java Servlets & Service classes
* **Data Access Layer**: DAO pattern with JDBC
* **Database Layer**: MySQL

This separation improves **scalability, maintainability, and testability**.

---

## 📁 Project Structure (N-Tier)

```text
src/main/java/com/oceanview/
├── controller/   # Servlets (The 'C' in MVC)
├── service/      # Business Logic & Calculations
├── dao/          # Database Access Objects
├── model/        # Plain Old Java Objects (POJOs)
├── util/         # Database Connection & Factories
└── filter/       # Authentication & Security

```

---

## ⚙️ Setup & Installation

1. **Database Setup**:
* Open MySQL Workbench.
* Execute the SQL script located in `/src/main/resources/db_schema.sql` to create the `ocean_view_resort_db`.


2. **IDE Import**:
* Open Eclipse or IntelliJ.
* Import the project as an **Existing Maven Project**.


3. **Server Configuration**:
* Add **Apache Tomcat 10+** to your Server Runtime.
* Right-click Project -> `Run As` -> `Run on Server`.



---

## 🔑 Default Credentials

To test the system immediately, use the following seeded accounts:

* **Admin Access**: `admin` / `admin123`
* **Staff Access**: `staff1` / `password123`

---

## 🌟 Core Features

* **User Authentication (Login)**: Secure access using BCrypt password hashing.
* **Add New Room Reservations**: Automated guest registration with unique ID generation.
* **View Reservation Details**: Search and retrieval of complete guest booking history.
* **Calculate & Print Bills**: Dynamic stay-cost calculation based on nights/room-rates with a dedicated browser-print view.
* **Help Section for Staff**: Comprehensive knowledge base for internal onboarding.
* **Secure Logout & Session Handling**: Complete session invalidation for secure system exit.

---

## 🧠 Design Patterns Applied

* **MVC** – Separation of concerns between UI and Logic.
* **DAO** – Database abstraction layer for clean data handling.
* **Singleton** – Thread-safe database connection management.
* **Factory** – Centralized room rate and service object creation.

---

## 🧪 Testing

* **Unit Testing**: Core logic verified using JUnit.
* **Validation**: Strict input handling (e.g., 10-digit contact numbers).
* **Security**: AuthFilters to prevent unauthorized URL access.

---

## 👨‍🎓 Academic Context

* **Module**: CIS6003 – Advanced Programming
* **Assessment**: Online Room Reservation System (WRIT1)
* **Institution**: ICBT Campus

---

## 📜 License

This project is developed for academic purposes only. MIT License was selected to encourage reuse while retaining author attribution.

---