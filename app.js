const express = require('express');
const cors = require('cors');
const pool = require('./index'); // Import the database connection

const app = express();
app.use(cors({ origin: 'http://localhost:3001' })); // Adjust if necessary

app.get('/api/users', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM users'); // Query the database
    res.json(result.rows); // Send the query result as JSON
  } catch (error) {
    console.error('Database query error:', error);
    res.status(500).json({ error: 'Database query failed' });
  }
});

app.listen(3000, () => console.log('Backend server running on port 3000'));
