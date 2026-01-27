# Ocean View Resort – Online Room Reservation System

## 📌 Overview
Ocean View Resort is a beachside hotel in Galle that previously managed room reservations manually.
This project delivers a **Java-based web application** to automate reservations, eliminate booking conflicts,
and improve operational efficiency.

The system is developed as part of **CIS6003 – Advanced Programming** and follows
**industry-standard software engineering practices**.

---

## 🏗 Architecture
- **Architecture Style**: MVC + N-Tier
- **Presentation Layer**: JSP, HTML, CSS
- **Business Layer**: Java Servlets & Service classes
- **Data Access Layer**: DAO pattern with JDBC
- **Database Layer**: MySQL

This separation improves **scalability, maintainability, and testability**.

---

## 🔑 Core Features
- User Authentication (Login)
- Add New Room Reservations
- View Reservation Details
- Calculate & Print Bills
- Help Section for Staff
- Secure Logout & Session Handling

---

## 🌐 Distributed System & Web Services
- Deployed on **Apache Tomcat**
- REST-style servlet endpoints
- Stateless request handling
- JSON-ready architecture for future integrations

---

## 🛠 Technologies Used
| Layer | Technology |
|------|-----------|
Frontend | JSP, HTML5, CSS3 |
Backend | Java Servlets |
Architecture | MVC, DAO, Singleton |
Build Tool | Maven |
Server | Apache Tomcat |
Database | MySQL |
IDE | Eclipse |

---

## 🧠 Design Patterns Applied
- **MVC** – Separation of concerns
- **DAO** – Database abstraction
- **Singleton** – Database connection management
- **Factory** – Object creation control

These patterns improve **code reusability and flexibility**.

---

## 🧪 Testing
- Unit Testing using JUnit
- Test-Driven Development (TDD)
- Automated regression testing
- Validation & exception handling tests

---

## 📊 Reports
- Reservation Summary Reports
- Date-wise Booking Reports
- Revenue Analysis Reports
- User Activity Logs

Reports support **management decision-making**.

---

## 🗄 Database
- Fully normalized schema
- Primary & Foreign keys
- Stored procedures and triggers
- Transaction management for consistency

---

## 🔄 Version Control & Git Workflow
- Public GitHub repository
- Feature-based commits
- Branching strategy:
  - `main`
  - `develop`
  - `feature/*`
- Git tags for releases (v1.0, v1.1)

---

## 🚀 Deployment
- Deployed on Apache Tomcat (Local)
- MySQL Workbench for DB management

---

## 📈 Evaluation & Future Enhancements
**Strengths**
- Clean layered architecture
- Secure and validated inputs
- Scalable design

**Future Improvements**
- Email notifications
- Role-based access control
- Cloud deployment

---

## 👨‍🎓 Academic Context
Module: **CIS6003 – Advanced Programming**  
Assessment: **Online Room Reservation System (WRIT1)**  
Institution: ICBT Campus

---

## 📜 License
This project is developed for academic purposes only.
MIT License was selected to encourage reuse while retaining author attribution.
