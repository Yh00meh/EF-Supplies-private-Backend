const express = require('express');
const cors = require('cors');
require('dotenv').config();

const { Pool } = require('pg');

const app = express();
app.use(cors({ origin: 'http://localhost:3000' })); // Adjust if necessary
app.use(express.json());

const pool = new Pool({
  user: process.env.USER,
  host: process.env.HOST,
  database: process.env.DATABASE,
  password: process.env.PASSWORD,
  port: process.env.PORT,
});

// REGISTER USER 
app.post('/api/register', async (req, res) => {
  const { name, email, password } = req.body;

  try {
    // Check if user already exists
    const userCheck = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    if (userCheck.rows.length > 0) {
      return res.status(400).json({ error: 'User already exists' });
    }

    // Insert the new user without password encryption
    const result = await pool.query(
      'INSERT INTO users (name, email, password) VALUES ($1, $2, $3) RETURNING *',
      [name, email, password]
    );

    res.status(201).json({ message: 'User registered successfully', user: result.rows[0] });
  } catch (error) {
    console.error('Error during registration:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

//  LOGIN USER 
app.post('/api/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Check if user exists
    const userCheck = await pool.query('SELECT * FROM users WHERE email = $1 AND password = $2', [email, password]);

    if (userCheck.rows.length === 0) {
      return res.status(400).json({ error: 'Invalid email or password' });
    }

    // Respond with a success message (no token needed)
    res.json({ message: 'Login successful', user: userCheck.rows[0] });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.listen(3001, () => console.log('Backend server running on port 3001'));