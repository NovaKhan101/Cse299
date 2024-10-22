CREATE DATABASE counselor_db;

USE counselor_db;

CREATE TABLE Counselors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    specialization VARCHAR(100)
);

INSERT INTO Counselors (name, email, phone, specialization) VALUES
('Nova Khan', 'Nova.khan@gmail.com', '01798327965', 'Clinical Psychologist'),
('Abu Bokar', 'Abu.bokar@yahoo.com', '01976543210', 'Marriage Counselor'),
('Nayeem Ayman', 'Nayeem.Ayman@gmail.com', '01457891230', 'Child Psychologist'),
('Fariha Shorna', 'Fariha.Shorna@hotmail.com', '01781234560', 'Addiction Therapist'),
('Navila Suche', 'Navila.Suche@example.com', '01316549870', 'Career Counselor');

CREATE TABLE Availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    counselor_id INT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time TIME,
    end_time TIME,
    FOREIGN KEY (counselor_id) REFERENCES Counselors(id) ON DELETE CASCADE
);

INSERT INTO Availability (counselor_id, day_of_week, start_time, end_time) VALUES
(1, 'Monday', '09:00:00', '12:00:00'),
(1, 'Wednesday', '14:00:00', '17:00:00'),
(2, 'Tuesday', '10:00:00', '13:00:00'),
(2, 'Thursday', '15:00:00', '18:00:00'),
(3, 'Friday', '09:00:00', '12:00:00'),
(3, 'Saturday', '10:00:00', '14:00:00'),
(4, 'Monday', '10:00:00', '15:00:00'),
(4, 'Thursday', '09:00:00', '12:00:00'),
(5, 'Wednesday', '13:00:00', '17:00:00');

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

(1, 'Sahida khan', 'Sahida.khan@gmail.com', '2024-10-22', '09:30:00', '10:30:00', 'Confirmed', 'First session'),
(1, 'Asef Aqtab', 'Asef.Aqtab@gmail.com', '2024-10-23', '11:00:00', '12:00:00', 'Pending', 'Follow-up on progress'),
(2, 'Nawshin tabassum', 'Nawshin.tabassum@eyahoo.com', '2024-10-24', '15:00:00', '16:00:00', 'Canceled', 'Rescheduled due to conflict'),
(3, 'Saif Ali', 'Saif.Ali@hotmail.com', '2024-10-25', '10:00:00', '11:00:00', 'Confirmed', 'Discuss behavioral issues'),
(4, 'Joy hossain', 'Joy.Hossain@gmail.com', '2024-10-26', '09:00:00', '10:00:00', 'Confirmed', 'Address substance dependency'),
(5, 'Siraj Khan', 'Siraj.khan@gmail.com', '2024-10-27', '13:30:00', '14:30:00', 'Pending', 'Career consultation for new role');
