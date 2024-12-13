const express = require('express');
const cors = require('cors');
const app = express();

// Allow requests from your frontend's origin
app.use(cors({ origin: 'http://localhost:3001' })); // frontend's URL and port

// routes here
app.get('/api/endpoint', (req, res) => {
  // Handle the request
});

app.listen(3000, () => console.log('Backend server running on port 3000'));

app.get ('/', (req, res) => res.send('Hello World! Test for update'))
app.listen (3000, () => console.log('Server Ready'))