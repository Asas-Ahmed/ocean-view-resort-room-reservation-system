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
    guest_email VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    contact_number VARCHAR(15) NOT NULL,
    room_type VARCHAR(50) NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. System Settings Table
CREATE TABLE system_settings (
    setting_id INT PRIMARY KEY AUTO_INCREMENT,
    config_key VARCHAR(50) UNIQUE NOT NULL,
    config_value VARCHAR(100) NOT NULL
);

-- 5. Seed Data
INSERT INTO system_settings (config_key, config_value) 
VALUES ('total_capacity', '50');

-- Sample Reservations for Ocean View Resort
INSERT INTO reservations (guest_name, guest_email, address, contact_number, room_type, check_in, check_out) VALUES
-- European Guests
('Emily Watson', 'emily.w@ukmail.co.uk', '42 High St, London, UK', '442079460958', 'Deluxe', '2026-03-01', '2026-03-07'),
('Hans Müller', 'hans.m@berlin.de', 'Leipziger Str. 12, Berlin, Germany', '4930123456', 'Suite', '2026-03-02', '2026-03-05'),
('Luca Rossi', 'l.rossi@italy.it', 'Via Roma 15, Rome, Italy', '39061234567', 'Standard', '2026-03-05', '2026-03-10'),
('Chloé Dubois', 'chloe.d@paris.fr', 'Rue de Rivoli, Paris, France', '331426034', 'Deluxe', '2026-03-10', '2026-03-15'),
('Sven Larsson', 'sven.l@stockholm.se', 'Vasagatan 22, Stockholm, Sweden', '468123456', 'Standard', '2026-03-12', '2026-03-14'),

-- North American Guests
('John Smith', 'jsmith@gmail.com', '742 Evergreen Terrace, Springfield, USA', '15550199', 'Suite', '2026-03-01', '2026-03-10'),
('Sarah Jenkins', 's.jenkins@yahoo.ca', '123 Maple Leaf Dr, Toronto, Canada', '14165550123', 'Deluxe', '2026-03-04', '2026-03-08'),
('Michael Brown', 'mbrown@outlook.com', '456 Ocean Ave, Miami, USA', '13055550111', 'Standard', '2026-03-15', '2026-03-20'),
('Jessica Miller', 'jess.m@gmail.com', '890 Broadway, NYC, USA', '12125550144', 'Suite', '2026-03-18', '2026-03-25'),
('David Wilson', 'dave.wilson@me.com', '55 Sunset Blvd, LA, USA', '13105550199', 'Deluxe', '2026-03-20', '2026-03-22'),

-- Asian & Middle Eastern Guests
('Akira Tanaka', 'tanaka.a@tokyo.jp', 'Shinjuku-ku, Tokyo, Japan', '81312345678', 'Suite', '2026-03-02', '2026-03-06'),
('Li Wei', 'li.wei@shanghai.cn', 'Nanjing Road, Shanghai, China', '862112345678', 'Deluxe', '2026-03-05', '2026-03-12'),
('Ahmed Al-Mansour', 'ahmed.m@dubai.ae', 'Sheikh Zayed Rd, Dubai, UAE', '97141234567', 'Suite', '2026-03-08', '2026-03-15'),
('Kim Ji-Hoon', 'jihoon.kim@seoul.kr', 'Gangnam-gu, Seoul, South Korea', '82212345678', 'Standard', '2026-03-10', '2026-03-13'),
('Priya Sharma', 'priya.s@mumbai.in', 'Marine Drive, Mumbai, India', '912212345678', 'Deluxe', '2026-03-14', '2026-03-18'),
('Fatima Hassan', 'fatima.h@doha.qa', 'West Bay, Doha, Qatar', '97444123456', 'Suite', '2026-03-20', '2026-03-25'),

-- Australian & Local
('Oliver Taylor', 'oliver.t@sydney.au', 'George St, Sydney, Australia', '61212345678', 'Standard', '2026-03-22', '2026-03-28'),
('Amara Jayawardena', 'amara.j@gmail.com', '45 Kandy Road, Kandy', '0812345678', 'Standard', '2026-03-01', '2026-03-03'),
('Rohan Silva', 'rohan.s@dialog.lk', '100 Havelock Rd, Colombo 05', '0777123456', 'Deluxe', '2026-03-05', '2026-03-07'),

-- More Mixed
('Carlos Mendez', 'carlos.m@madrid.es', 'Gran Via, Madrid, Spain', '34911234567', 'Deluxe', '2026-04-01', '2026-04-05'),
('Sofia Oliveira', 'sofia.o@lisbon.pt', 'Av. Liberdade, Lisbon, Portugal', '351211234567', 'Standard', '2026-04-02', '2026-04-06'),
('Yuki Sato', 'yuki.s@osaka.jp', 'Chuo-ku, Osaka, Japan', '81612345678', 'Suite', '2026-04-05', '2026-04-10'),
('Elena Popova', 'elena.p@moscow.ru', 'Arbat St, Moscow, Russia', '74951234567', 'Standard', '2026-04-10', '2026-04-15'),
('Maria Garcia', 'maria.g@mexico.mx', 'Paseo de la Reforma, Mexico City', '525512345678', 'Deluxe', '2026-04-15', '2026-04-20'),
('Andre Santos', 'andre.s@rio.br', 'Copacabana, Rio de Janeiro', '552112345678', 'Standard', '2026-04-18', '2026-04-22'),
('Thomas Wright', 't.wright@manchester.uk', 'Deansgate, Manchester, UK', '441611234567', 'Suite', '2026-04-20', '2026-04-25'),
('Noah Schneider', 'noah.s@vienna.at', 'Mariahilfer Str, Vienna', '4311234567', 'Standard', '2026-04-25', '2026-04-30'),
('Mia Larsen', 'mia.l@oslo.no', 'Karl Johans gate, Oslo', '4722123456', 'Suite', '2026-05-01', '2026-05-05'),
('Lucas Meyer', 'l.meyer@zurich.ch', 'Bahnhofstrasse, Zurich', '41441234567', 'Deluxe', '2026-05-02', '2026-05-07'),
('Grace Chen', 'grace.c@singapore.sg', 'Orchard Road, Singapore', '6561234567', 'Standard', '2026-05-05', '2026-05-10'),
('Omar Farooq', 'omar.f@islamabad.pk', 'F-7 Markaz, Islamabad', '92511234567', 'Suite', '2026-05-08', '2026-05-12'),
('Santi Rodriguez', 'santi.r@bogota.co', 'Calle 72, Bogota', '5711234567', 'Standard', '2026-05-12', '2026-05-16'),
('Lars Jensen', 'lars.j@cph.dk', 'Strøget, Copenhagen', '4533123456', 'Suite', '2026-05-15', '2026-05-20'),
('Zoe Williams', 'zoe.w@perth.au', 'Hay St, Perth', '61812345678', 'Standard', '2026-05-20', '2026-05-25'),
('Adam Kowalski', 'adam.k@warsaw.pl', 'Nowy Świat, Warsaw', '48221234567', 'Suite', '2026-05-22', '2026-05-28'),
('Sofia Petrova', 'sofia.p@sofia.bg', 'Vitosha Blvd, Sofia', '35921234567', 'Deluxe', '2026-05-25', '2026-05-30'),
('Ben Smith', 'ben.s@capetown.za', 'Long St, Cape Town', '27211234567', 'Standard', '2026-06-01', '2026-06-05'),
('Felix Fischer', 'felix.f@munich.de', 'Marienplatz, Munich', '4989123456', 'Deluxe', '2026-06-05', '2026-06-10'),
('Sara Lund', 'sara.l@helsinki.fi', 'Esplanadi, Helsinki', '3589123456', 'Standard', '2026-06-08', '2026-06-12'),
('Hugo Silva', 'hugo.s@lisbon.pt', 'Rua Augusta, Lisbon', '351219876543', 'Suite', '2026-06-10', '2026-06-15'),
('Oscar Wilde', 'oscar.w@dublin.ie', 'Grafton St, Dublin', '35311234567', 'Standard', '2026-06-15', '2026-06-20'),
('Ivan Drago', 'ivan.d@moscow.ru', 'Red Square, Moscow', '74959999999', 'Suite', '2026-06-18', '2026-06-22');

-- 6. Verification
SHOW TABLES;

DESCRIBE users;
SELECT * FROM users;

DESCRIBE reservations;
SELECT * FROM reservations;

DESCRIBE system_settings;
SELECT * FROM system_settings;