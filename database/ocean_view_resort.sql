-- 1. Wipe the old database
DROP DATABASE IF EXISTS ocean_view_resort_db;

-- 2. Create the new one
CREATE DATABASE ocean_view_resort_db;
USE ocean_view_resort_db;

-- 3. Create User Table (Note: password is 255 chars for BCrypt)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'STAFF'
);

-- 4. Create Reservations Table
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    contact_number VARCHAR(15) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Insert Sample Data
INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in, check_out)
VALUES ('Kasun Perera', '123 Galle Road, Colombo', '0771234567', 'Standard', '2026-02-01', '2026-02-04');

INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in, check_out)
VALUES ('Sarah Jennings', '45 Ocean View, Mirissa', '0719876543', 'Deluxe', '2026-02-10', '2026-02-12');

-- Verify
SELECT * FROM users;