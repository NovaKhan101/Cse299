import express from 'express';
import bodyParser from 'body-parser';
import mysql from 'mysql2/promise';

// Create a connection pool for MySQL
const db = mysql.createPool({
  port: 3307,
  host: 'localhost',
  user: 'root',
  password: '', // Use your MySQL password
  database: 'counselor_db',
});

const app = express();
app.use(bodyParser.json());

// Add Counselor
app.post('/counselors', async (req, res) => {
  const { name, email, phone, specialization } = req.body;
  try {
    const [result] = await db.execute(
      'INSERT INTO Counselors (name, email, phone, specialization) VALUES (?, ?, ?, ?)',
      [name, email, phone, specialization]
    );
    res.status(201).json({ message: 'Counselor added!', counselorId: result.insertId });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Add Availability
app.post('/availability', async (req, res) => {
  const { counselor_id, day_of_week, start_time, end_time } = req.body;
  try {
    await db.execute(
      'INSERT INTO Availability (counselor_id, day_of_week, start_time, end_time) VALUES (?, ?, ?, ?)',
      [counselor_id, day_of_week, start_time, end_time]
    );
    res.status(201).json({ message: 'Availability added!' });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get Availability by Counselor ID
app.get('/availability/:counselor_id', async (req, res) => {
  const { counselor_id } = req.params;
  try {
    const [availability] = await db.execute(
      'SELECT * FROM Availability WHERE counselor_id = ?',
      [counselor_id]
    );
    res.json(availability);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Book an Appointment
app.post('/appointments', async (req, res) => {
  const { counselor_id, client_name, client_email, appointment_date, start_time, end_time, status, notes } = req.body;
  try {
    const [result] = await db.execute(
      'INSERT INTO Appointments (counselor_id, client_name, client_email, appointment_date, start_time, end_time, status, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [counselor_id, client_name, client_email, appointment_date, start_time, end_time, status || 'Pending', notes]
    );
    res.status(201).json({ message: 'Appointment booked!', appointmentId: result.insertId });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get Appointments by Counselor ID
app.get('/appointments/:counselor_id', async (req, res) => {
  const { counselor_id } = req.params;
  try {
    const [appointments] = await db.execute(
      'SELECT * FROM Appointments WHERE counselor_id = ?',
      [counselor_id]
    );
    res.json(appointments);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
