const express = require('express');
const router = express.Router();
const db = require('../db');
const { requireStaff } = require('../middleware/auth');

router.use(requireStaff);

// ── Reservations ─────────────────────────────────────────────

// View all reservations with filters
router.get('/reservations', async (req, res) => {
  const { status, room_type, date } = req.query;
  let query = `SELECT res.*, c.first_name, c.last_name, r.number, r.type
               FROM reservation res
               JOIN customer c ON res.customer_id = c.customer_id
               JOIN room r ON res.room_id = r.room_id WHERE 1=1`;
  const params = [];
  if (status) { query += ' AND res.status = ?'; params.push(status); }
  if (room_type) { query += ' AND r.type = ?'; params.push(room_type); }
  if (date) { query += ' AND res.check_in_date = ?'; params.push(date); }
  query += ' ORDER BY res.check_in_date DESC';
  try {
    const [rows] = await db.query(query, params);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Confirm reservation
router.put('/reservation/:id/confirm', async (req, res) => {
  try {
    await db.query(`UPDATE reservation SET status = 'confirmed' WHERE reservation_id = ?`, [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Cancel reservation
router.put('/reservation/:id/cancel', async (req, res) => {
  try {
    await db.query(`UPDATE reservation SET status = 'cancelled' WHERE reservation_id = ?`, [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Check in customer
router.post('/checkin/:reservation_id', async (req, res) => {
  const { promotional_id } = req.body;
  try {
    const [res_rows] = await db.query(
      `SELECT * FROM reservation WHERE reservation_id = ?`, [req.params.reservation_id]
    );
    const reservation = res_rows[0];
    await db.query(`UPDATE room SET conditions = 'occupied' WHERE room_id = ?`, [reservation.room_id]);
    await db.query(`UPDATE reservation SET status = 'confirmed' WHERE reservation_id = ?`, [req.params.reservation_id]);
    await db.query(
      `INSERT INTO receipt (customer_id, room_id, reservation_id, promotional_id, clock_in, is_paid)
       VALUES (?, ?, ?, ?, NOW(), 0)`,
      [reservation.customer_id, reservation.room_id, reservation.reservation_id, promotional_id || null]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Check out customer + generate bill
router.put('/checkout/:reservation_id', async (req, res) => {
  try {
    const [rec] = await db.query(
      `SELECT rec.*, r.price, p.discounts FROM receipt rec
       JOIN room r ON rec.room_id = r.room_id
       LEFT JOIN promotional p ON rec.promotional_id = p.promotional_id
       WHERE rec.reservation_id = ?`, [req.params.reservation_id]
    );
    const receipt = rec[0];
    const [res_rows] = await db.query(
      `SELECT DATEDIFF(check_out_date, check_in_date) AS nights FROM reservation WHERE reservation_id = ?`,
      [req.params.reservation_id]
    );
    const nights = res_rows[0].nights;
    let total = receipt.price * nights;
    if (receipt.discounts) total -= (total * receipt.discounts / 100);
    await db.query(
      `UPDATE receipt SET clock_out = NOW(), total_bill = ?, is_paid = 1 WHERE reservation_id = ?`,
      [total.toFixed(2), req.params.reservation_id]
    );
    await db.query(`UPDATE room SET conditions = 'free' WHERE room_id = ?`, [receipt.room_id]);
    await db.query(`UPDATE reservation SET status = 'completed' WHERE reservation_id = ?`, [req.params.reservation_id]);
    res.json({ success: true, total_bill: total.toFixed(2) });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── Room Management ───────────────────────────────────────────

router.put('/room/:id/conditions', async (req, res) => {
  const { conditions } = req.body;
  try {
    await db.query(`UPDATE room SET conditions = ? WHERE room_id = ?`, [conditions, req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.post('/room', async (req, res) => {
  const { hotel_id, number, type, price, capacity, picture_url, conditions } = req.body;
  try {
    const [result] = await db.query(
      `INSERT INTO room (hotel_id, number, type, price, capacity, picture_url, conditions)
       VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [hotel_id, number, type, price, capacity, picture_url || null, conditions || 'free']
    );
    res.json({ success: true, room_id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/room/:id', async (req, res) => {
  const { number, type, price, capacity, picture_url, conditions } = req.body;
  try {
    await db.query(
      `UPDATE room SET number=?, type=?, price=?, capacity=?, picture_url=?, conditions=? WHERE room_id=?`,
      [number, type, price, capacity, picture_url, conditions, req.params.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── Staff Management ──────────────────────────────────────────

router.get('/staff', async (req, res) => {
  try {
    const [rows] = await db.query(`SELECT * FROM staff ORDER BY hotel_id, role`);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.post('/staff', async (req, res) => {
  const { hotel_id, first_name, last_name, contact_number, role, conditions, salary } = req.body;
  try {
    const [result] = await db.query(
      `INSERT INTO staff (hotel_id, first_name, last_name, contact_number, role, conditions, salary, penalty_points)
       VALUES (?, ?, ?, ?, ?, ?, ?, 0)`,
      [hotel_id, first_name, last_name, contact_number || null, role, conditions || 'active', salary]
    );
    res.json({ success: true, staff_id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/staff/:id', async (req, res) => {
  const { role, conditions, salary } = req.body;
  try {
    await db.query(
      `UPDATE staff SET role=?, conditions=?, salary=? WHERE staff_id=?`,
      [role, conditions, salary, req.params.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/staff/:id/penalty', async (req, res) => {
  const { points } = req.body;
  try {
    await db.query(
      `UPDATE staff SET penalty_points = penalty_points + ? WHERE staff_id = ?`,
      [points, req.params.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── Reports ───────────────────────────────────────────────────

router.get('/reports/occupancy', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT r.type, r.conditions, COUNT(*) AS count FROM room r GROUP BY r.type, r.conditions`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/reports/revenue', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT 
        SUM(total_bill) AS total_revenue,
        COUNT(*) AS total_receipts,
        AVG(total_bill) AS avg_bill,
        MAX(total_bill) AS max_bill
       FROM receipt WHERE is_paid = 1`
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.get('/reports/stats', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT 
        AVG(DATEDIFF(check_out_date, check_in_date)) AS avg_stay_nights,
        COUNT(*) AS total_reservations,
        SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed,
        SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled
       FROM reservation`
    );
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Blacklist customer
router.put('/customer/:id/blacklist', async (req, res) => {
  try {
    await db.query(`UPDATE customer SET is_blacklisted = 1 WHERE customer_id = ?`, [req.params.id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ── Promotional ───────────────────────────────────────────────

router.post('/promotional', async (req, res) => {
  const { statement, discounts, start_date, end_date } = req.body;
  try {
    await db.query(
      `INSERT INTO promotional (statement, discounts, start_date, end_date) VALUES (?, ?, ?, ?)`,
      [statement, discounts, start_date, end_date]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

router.put('/promotional/:id', async (req, res) => {
  const { statement, discounts, start_date, end_date } = req.body;
  try {
    await db.query(
      `UPDATE promotional SET statement=?, discounts=?, start_date=?, end_date=? WHERE promotional_id=?`,
      [statement, discounts, start_date, end_date, req.params.id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
