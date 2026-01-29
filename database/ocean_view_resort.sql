-- 1. Wipe and Recreate
DROP DATABASE IF EXISTS ocean_view_resort_db;
CREATE DATABASE ocean_view_resort_db;
USE ocean_view_resort_db;

-- 2. User Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'STAFF'
);

-- 3. Reservations Table
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

-- 4. NEW: System Settings Table
CREATE TABLE system_settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    config_key VARCHAR(50) UNIQUE NOT NULL,
    config_value VARCHAR(100) NOT NULL
);

-- 5. Seed Data
INSERT INTO system_settings (config_key, config_value) 
VALUES ('total_capacity', '50');

INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in, check_out)
VALUES ('Kasun Perera', '123 Galle Road, Colombo', '0771234567', 'Standard', '2026-02-01', '2026-02-04');

INSERT INTO reservations (guest_name, address, contact_number, room_type, check_in, check_out)
VALUES ('Sarah Jennings', '45 Ocean View, Mirissa', '0719876543', 'Deluxe', '2026-02-10', '2026-02-12');

-- Verify
SELECT * FROM users;
SELECT * FROM reservations;
SELECT * FROM system_settings;