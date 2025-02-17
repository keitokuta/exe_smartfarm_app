const express = require('express');
const { Pool } = require('pg');
const authRoutes = require('./routes/auth');
const dataRoutes = require('./routes/data');

const app = express();
const port = process.env.PORT || 3000;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

app.use(express.json());

app.use('/api/auth', authRoutes);
app.use('/api/data', dataRoutes);

app.get('/', (req, res) => {
  res.send('FieldMaster API is running');
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

module.exports = { app, pool };