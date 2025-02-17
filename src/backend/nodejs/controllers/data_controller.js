const express = require('express');
const router = express.Router();
const { Pool } = require('pg');
const fs = require('fs');
const path = require('path');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL
});

// データ保存処理
router.post('/data', async (req, res) => {
  try {
    const { temperature, humidity, soilCondition } = req.body;
    const query = `
      INSERT INTO field_data (temperature, humidity, soil_condition)
      VALUES ($1, $2, $3)
      RETURNING *;
    `;
    const values = [temperature, humidity, soilCondition];
    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// データ取得処理
router.get('/data', async (req, res) => {
  try {
    const query = 'SELECT * FROM field_data ORDER BY created_at DESC';
    const result = await pool.query(query);
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

// CSV出力処理
router.get('/data/export', async (req, res) => {
  try {
    const query = 'SELECT * FROM field_data ORDER BY created_at DESC';
    const result = await pool.query(query);
    
    const csvData = result.rows.map(row => {
      return `${row.id},${row.temperature},${row.humidity},${row.soil_condition},${row.created_at}`;
    }).join('\n');
    
    const filePath = path.join(__dirname, '../exports/data.csv');
    fs.writeFileSync(filePath, 'id,temperature,humidity,soil_condition,created_at\n' + csvData);
    
    res.download(filePath);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server Error');
  }
});

module.exports = router;