const express = require('express');
const router = express.Router();
const db = require('../db');

// Customer login
router.post('/customer/login', async (req, res) => {
  const { name,email,password} = req.body;
  try {
    const { email, password } = req.body;
    const [rows] = await db.query(
    `SELECT customer_id, name, email, customer_password, is_blacklisted 
    FROM customer WHERE email = ? AND customer_password = ?`,
    [email, password]
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
  const { staff_id, role,password} = req.body;
  try {
    const [rows] = await db.query(
      `SELECT staff_id, first_name, last_name, role, conditions 
       FROM staff WHERE staff_id = ? AND role = ? AND password =?`,
      [staff_id, role, password]
    );
    if (rows.length === 0) return res.status(404).json({ error: 'Staff not found' });
    if (rows[0].conditions === 'terminated') return res.status(403).json({ error: 'Account inactive' });
    res.json({ success: true, staff: rows[0], token: process.env.STAFF_SECRET });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// Customer register
router.post('/customer/register', async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const [result] = await db.query(
      `INSERT INTO customer (name, email, customer_password, is_blacklisted)
       VALUES (?, ?, ?, 0)`,
      [name, email, password || null]
    );
    res.json({ 
      success: true, 
      customer: {
        customer_id: result.insertId,
        name,
        email,
        is_blacklisted: 0
      }
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = router;
