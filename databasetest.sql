CREATE DATABASE counselor_db;

USE counselor_db;

CREATE TABLE Counselors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    specialization VARCHAR(100)
);

CREATE TABLE Availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    counselor_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (counselor_id) REFERENCES Counselors(id) ON DELETE CASCADE
);

CREATE TABLE Appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    counselor_id INT,
    client_name VARCHAR(100) NOT NULL,
    client_email VARCHAR(100) NOT NULL,
    appointment_date DATE,
    start_time TIME,
    end_time TIME,
    status ENUM('Pending', 'Confirmed', 'Canceled') DEFAULT 'Pending',
    notes TEXT,
    FOREIGN KEY (counselor_id) REFERENCES Counselors(id) ON DELETE CASCADE
);
