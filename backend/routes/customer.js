const express = require('express');
const router = express.Router();
const db = require('../db');
const { BakongKHQR, IndividualInfo } = require('bakong-khqr');

// display rooms
router.get('/rooms', async (req, res) => {
  const { hotel_id, check_in, check_out } = req.query;
  let query = `
    SELECT r.room_id, r.number, r.type, r.price, r.capacity,
           a.has_wifi, a.bedroom_amount, a.bathroom_amount,
           MIN(ri.link) AS picture_url,
           CASE 
             WHEN r.conditions = 'repairing' THEN 'repairing'
             WHEN r.conditions = 'occupied' THEN 'occupied'
             WHEN EXISTS (
               SELECT 1 FROM reservation res 
               WHERE res.room_id = r.room_id 
               AND res.status = 'confirmed' 
               AND CURDATE() >= res.check_in_date 
               AND CURDATE() < res.check_out_date
             ) THEN 'occupied'
             ELSE 'free'
           END AS current_condition
    FROM room r
    LEFT JOIN amenities a ON r.room_id = a.room_id
    LEFT JOIN room_img ri ON r.room_id = ri.room_id
    WHERE r.hotel_id = ?`;
  const params = [hotel_id];
  if (check_in && check_out) {
    query += ` AND r.room_id NOT IN (
      SELECT room_id FROM reservation
      WHERE status IN ('pending','confirmed')
      AND NOT (? <= check_in_date OR ? >= check_out_date)
    )`;
    params.push(check_out, check_in);
  }
  query += ` GROUP BY r.room_id, r.number, r.type, r.price, r.capacity,
             a.has_wifi, a.bedroom_amount, a.bathroom_amount, r.conditions`;
  try {
    const [rows] = await db.query(query, params);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// room detail
router.get('/rooms/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [[room]] = await db.query(
      `SELECT r.room_id, r.number, r.type, r.price, r.capacity,
              CASE 
                WHEN r.conditions = 'repairing' THEN 'repairing'
                WHEN r.conditions = 'occupied' THEN 'occupied'
                WHEN EXISTS (
                  SELECT 1 FROM reservation res 
                  WHERE res.room_id = r.room_id 
                  AND res.status = 'confirmed' 
                  AND CURDATE() >= res.check_in_date 
                  AND CURDATE() < res.check_out_date
                ) THEN 'occupied'
                ELSE 'free'
              END AS current_condition,
              a.has_wifi, a.bedroom_amount, a.bathroom_amount
       FROM room r
       LEFT JOIN amenities a ON r.room_id = a.room_id
       WHERE r.room_id = ?`,
      [id]
    );
    if (!room) return res.status(404).json({ error: 'Room not found' });
    const [images] = await db.query(`SELECT link FROM room_img WHERE room_id = ?`, [id]);
    room.images = images.map(i => i.link);
    res.json(room);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// stats
router.get('/stats', async (req, res) => {
  try {
    const [[rooms]]   = await db.query('SELECT COUNT(*) AS count FROM room WHERE hotel_id = ?', [1]);
    const [[staff]]   = await db.query('SELECT COUNT(*) AS count FROM staff');
    const [[clients]] = await db.query('SELECT COUNT(*) AS count FROM customer');
    res.json({ rooms: rooms.count, staff: staff.count, clients: clients.count });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// confirm receipt payment — MUST be before /receipt/:reservation_id
router.put('/receipt/confirm/:reservation_id', async (req, res) => {
  const { reservation_id } = req.params;
  try {
    await db.query(`UPDATE reservation SET status = 'confirmed' WHERE reservation_id = ?`, [reservation_id]);
    await db.query(`UPDATE receipt SET is_paid = 1 WHERE reservation_id = ?`, [reservation_id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// QR generation — MUST be before /receipt/:reservation_id
router.get('/receipt/qr/:reservation_id', async (req, res) => {
  const { reservation_id } = req.params;
  try {
    const [[receipt]] = await db.query(
      `SELECT total_bill FROM receipt WHERE reservation_id = ?`, [reservation_id]
    );
    if (!receipt) return res.status(404).json({ error: 'Receipt not found' });

    const individualInfo = new IndividualInfo(
      '4286090199001189',
      'Laisrun LY',
      'Phnom Penh',
      'USD',
      parseFloat(receipt.total_bill),
      'KH',
      `RES-${reservation_id}`,
      '',
      '',
    );
    const { data } = BakongKHQR.generateIndividual(individualInfo);
    res.json({ qr: data.qrImage, amount: receipt.total_bill });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// get receipt by reservation_id
router.get('/receipt/:reservation_id', async (req, res) => {
  const { reservation_id } = req.params;
  try {
    const [[receipt]] = await db.query(
      `SELECT rc.*,
              DATE_FORMAT(res.check_in_date, '%Y-%m-%d') AS check_in_date,
              DATE_FORMAT(res.check_out_date, '%Y-%m-%d') AS check_out_date,
              r.number, r.type, r.price,
              c.name, c.email,
              res.status
       FROM receipt rc
       JOIN room r ON rc.room_id = r.room_id
       JOIN customer c ON rc.customer_id = c.customer_id
       JOIN reservation res ON rc.reservation_id = res.reservation_id
       WHERE rc.reservation_id = ?`,
      [reservation_id]
    );
    if (!receipt) return res.status(404).json({ error: 'Receipt not found' });
    res.json(receipt);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// create reservation + receipt
router.post('/reservation', async (req, res) => {
  const { customer_id, room_id, check_in, check_out } = req.body;
  try {
    const [conflict] = await db.query(
      `SELECT reservation_id FROM reservation 
       WHERE room_id = ? 
       AND status NOT IN ('cancelled')
       AND check_in_date < ? AND check_out_date > ?`,
      [room_id, check_out, check_in]
    );
    if (conflict.length > 0) {
      return res.status(409).json({ error: 'Room is already booked for those dates.' });
    }
    const [result] = await db.query(
      `INSERT INTO reservation (customer_id, room_id, check_in_date, check_out_date, status)
       VALUES (?, ?, ?, ?, 'pending')`,
      [customer_id, room_id, check_in, check_out]
    );
    const reservation_id = result.insertId;
    const [[room]] = await db.query(`SELECT price FROM room WHERE room_id = ?`, [room_id]);
    const nights = Math.ceil((new Date(check_out) - new Date(check_in)) / (1000 * 60 * 60 * 24));
    const total_bill = (room.price * nights).toFixed(2);
    await db.query(
      `INSERT INTO receipt (reservation_id, room_id, customer_id, clock_in, clock_out, total_bill, is_paid)
       VALUES (?, ?, ?, ?, ?, ?, 0)`,
      [reservation_id, room_id, customer_id, check_in, check_out, total_bill]
    );
    res.json({ success: true, reservation_id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// booked dates — MUST be before /reservation/:id
router.get('/reservation/booked-dates', async (req, res) => {
  const { room_id } = req.query;
  try {
    const [rows] = await db.query(
      `SELECT DATE_FORMAT(check_in_date, '%Y-%m-%d') AS check_in_date,
              DATE_FORMAT(check_out_date, '%Y-%m-%d') AS check_out_date
       FROM reservation
       WHERE room_id = ? AND status NOT IN ('cancelled')`,
      [room_id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// by-receipt — MUST be before /reservation/:id
router.get('/reservation/by-receipt/:receipt_id', async (req, res) => {
  const { receipt_id } = req.params;
  try {
    const [[reservation]] = await db.query(
      `SELECT res.reservation_id, res.customer_id, res.room_id, res.status,
              DATE_FORMAT(res.check_in_date, '%Y-%m-%d') AS check_in_date,
              DATE_FORMAT(res.check_out_date, '%Y-%m-%d') AS check_out_date,
              r.number, r.type, r.price, c.name, c.email,
              rc.is_paid, rc.receipt_id
       FROM receipt rc
       JOIN reservation res ON rc.reservation_id = res.reservation_id
       JOIN room r ON res.room_id = r.room_id
       JOIN customer c ON res.customer_id = c.customer_id
       WHERE rc.receipt_id = ?`,
      [receipt_id]
    );
    if (!reservation) return res.status(404).json({ error: 'Receipt not found' });
    res.json(reservation);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// get reservation by ID
router.get('/reservation/:id', async (req, res) => {
  const { id } = req.params;
  try {
    const [[reservation]] = await db.query(
      `SELECT res.reservation_id, res.customer_id, res.room_id, res.status,
              DATE_FORMAT(res.check_in_date, '%Y-%m-%d') AS check_in_date,
              DATE_FORMAT(res.check_out_date, '%Y-%m-%d') AS check_out_date,
              r.number, r.type, r.price, c.name, c.email
       FROM reservation res
       JOIN room r ON res.room_id = r.room_id
       JOIN customer c ON res.customer_id = c.customer_id
       WHERE res.reservation_id = ?`,
      [id]
    );
    if (!reservation) return res.status(404).json({ error: 'Reservation not found' });
    res.json(reservation);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// booking history
router.get('/reservations/:customer_id', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT res.reservation_id,
              DATE_FORMAT(res.check_in_date, '%Y-%m-%d') AS check_in_date,
              DATE_FORMAT(res.check_out_date, '%Y-%m-%d') AS check_out_date,
              res.status, r.number, r.type, r.price,
              DATEDIFF(res.check_out_date, res.check_in_date) AS duration_nights
       FROM reservation res
       JOIN room r ON res.room_id = r.room_id
       WHERE res.customer_id = ?
       ORDER BY res.check_in_date DESC`,
      [req.params.customer_id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// edit reservation dates
router.put('/reservation/:id', async (req, res) => {
  const { id } = req.params;
  const { check_in, check_out, customer_id } = req.body;
  try {
    const [[res_check]] = await db.query(
      `SELECT customer_id FROM reservation WHERE reservation_id = ?`, [id]
    );
    if (!res_check) return res.status(404).json({ error: 'Reservation not found' });
    if (res_check.customer_id != customer_id) return res.status(403).json({ error: 'Not your reservation' });
    const [conflict] = await db.query(
      `SELECT reservation_id FROM reservation
       WHERE room_id = (SELECT room_id FROM reservation WHERE reservation_id = ?)
       AND reservation_id != ?
       AND status NOT IN ('cancelled')
       AND check_in_date < ? AND check_out_date > ?`,
      [id, id, check_out, check_in]
    );
    if (conflict.length > 0) return res.status(409).json({ error: 'Room already booked for those dates' });
    await db.query(
      `UPDATE reservation SET check_in_date = ?, check_out_date = ? WHERE reservation_id = ?`,
      [check_in, check_out, id]
    );
    const [[room]] = await db.query(
      `SELECT r.price FROM room r
       JOIN reservation res ON r.room_id = res.room_id
       WHERE res.reservation_id = ?`, [id]
    );
    const nights = Math.ceil((new Date(check_out) - new Date(check_in)) / (1000 * 60 * 60 * 24));
    const total_bill = (room.price * nights).toFixed(2);
    await db.query(
      `UPDATE receipt SET clock_in = ?, clock_out = ?, total_bill = ? WHERE reservation_id = ?`,
      [check_in, check_out, total_bill, id]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// cancel reservation
router.delete('/reservation/:id', async (req, res) => {
  const { id } = req.params;
  const { customer_id } = req.body;
  try {
    const [[res_check]] = await db.query(
      `SELECT customer_id FROM reservation WHERE reservation_id = ?`, [id]
    );
    if (!res_check) return res.status(404).json({ error: 'Reservation not found' });
    if (res_check.customer_id != customer_id) return res.status(403).json({ error: 'Not your reservation' });
    await db.query(`DELETE FROM receipt WHERE reservation_id = ?`, [id]);
    await db.query(`DELETE FROM reservation WHERE reservation_id = ?`, [id]);
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// get all reviews
router.get('/reviews', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT r.review_id, c.name AS customer_name,
              ro.number AS room_number, ro.type AS room_type,
              r.stars, r.statement,
              DATE_FORMAT(r.time, '%d %b %Y') AS review_date
       FROM review r
       JOIN customer c ON r.customer_id = c.customer_id
       JOIN room ro ON r.room_id = ro.room_id
       WHERE r.is_valid = 1
       ORDER BY r.time DESC`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;

