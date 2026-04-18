const express = require('express');
const router = express.Router();
const db = require('../db');

// Customer login (by name + DOB — simple, no password for now)
router.post('/customer/login', async (req, res) => {
  const { first_name, last_name, date_of_birth } = req.body;
  try {
    const [rows] = await db.query(
      `SELECT customer_id, first_name, last_name, is_blacklisted 
       FROM customer WHERE first_name = ? AND last_name = ? AND date_of_birth = ?`,
      [first_name, last_name, date_of_birth]
    );
    if (rows.length === 0) return res.status(404).json({ error: 'Customer not found' });
    if (rows[0].is_blacklisted) return res.status(403).json({ error: 'Account is blacklisted' });
    res.json({ success: true, customer: rows[0] });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Staff login (by staff_id + role — simple for school project)
router.post('/staff/login', async (req, res) => {
  const { staff_id, role } = req.body;
  try {
    const [rows] = await db.query(
      `SELECT staff_id, first_name, last_name, role, conditions 
       FROM staff WHERE staff_id = ? AND role = ?`,
      [staff_id, role]
    );
    if (rows.length === 0) return res.status(404).json({ error: 'Staff not found' });
    if (rows[0].conditions === 'fired') return res.status(403).json({ error: 'Account inactive' });
    res.json({ success: true, staff: rows[0], token: process.env.STAFF_SECRET });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// Customer register
router.post('/customer/register', async (req, res) => {
  const { first_name, last_name, date_of_birth, profession, nationality } = req.body;
  try {
    const [result] = await db.query(
      `INSERT INTO customer (first_name, last_name, date_of_birth, profession, nationality, is_blacklisted)
       VALUES (?, ?, ?, ?, ?, 0)`,
      [first_name, last_name, date_of_birth, profession || null, nationality]
    );
    res.json({ success: true, customer_id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = router;
