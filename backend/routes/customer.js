const express = require('express');
const router = express.Router();
const db = require('../db');

// display rooms
router.get('/rooms', async (req, res) => {
  const { hotel_id } = req.query;
  try {
    const [rows] = await db.query(
      `SELECT r.room_id, r.number, r.type, r.price, r.capacity,
              a.has_wifi, a.bedroom_amount, a.bathroom_amount,
              GROUP_CONCAT(ri.link) AS images
       FROM Room r
       LEFT JOIN Amenities a ON r.room_id = a.room_id
       LEFT JOIN room_img ri ON r.room_id = ri.Room_room_id
       WHERE r.hotel_id = ?
       GROUP BY r.room_id, r.number, r.type, r.price, r.capacity,
                a.has_wifi, a.bedroom_amount, a.bathroom_amount`,
      [hotel_id]
    );
    const result = rows.map(r => ({
      ...r,
      images: r.images ? r.images.split(',') : []
    }));
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// Make a reservation 
router.post('/reservation', async (req, res) => {
  const { customer_id, room_id, check_in, check_out } = req.body;
  try {
    // check for overlap
    const [conflict] = await db.query(
      `SELECT reservation_id FROM Reservation 
       WHERE room_id = ? 
       AND status NOT IN ('cancelled')
       AND check_in_date < ? AND check_out_date > ?`,
      [room_id, check_out, check_in]
    );

    if (conflict.length > 0) {
      return res.status(409).json({ error: 'Room is already booked for those dates.' });
    }

    const [result] = await db.query(
      `INSERT INTO Reservation (customer_id, room_id, check_in_date, check_out_date, status)
       VALUES (?, ?, ?, ?, 'pending')`,
      [customer_id, room_id, check_in, check_out]
    );

    res.json({ success: true, reservation_id: result.insertId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
//room date
router.get('/reservation/booked-dates', async (req, res) => {
  const { room_id } = req.query;
  try {
    const [rows] = await db.query(
      `SELECT check_in_date, check_out_date FROM Reservation
       WHERE room_id = ? AND status NOT IN ('cancelled')`,
      [room_id]
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// View own booking history
router.get('/reservations/:customer_id', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT res.reservation_id, res.check_in_date, res.check_out_date, res.status,
              r.number, r.type, r.price,
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

// View receipt
router.get('/receipt/:reservation_id', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT rec.receipt_id, rec.clock_in, rec.clock_out, rec.total_bill, rec.is_paid,
              c.first_name, c.last_name,
              r.number AS room_number, r.type AS room_type,
              p.statement AS promo_statement, p.discounts
       FROM receipt rec
       JOIN customer c ON rec.customer_id = c.customer_id
       JOIN room r ON rec.room_id = r.room_id
       LEFT JOIN promotional p ON rec.promotional_id = p.promotional_id
       WHERE rec.reservation_id = ?`,
      [req.params.reservation_id]
    );
    res.json(rows[0] || null);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Submit a review
router.post('/review', async (req, res) => {
  const { customer_id, room_id, stars, statement } = req.body;
  try {
    await db.query(
      `INSERT INTO review (customer_id, room_id, stars, statement, time, is_valid)
       VALUES (?, ?, ?, ?, NOW(), 1)`,
      [customer_id, room_id, stars, statement]
    );
    res.json({ success: true });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Check active promotionals
router.get('/promotionals', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT * FROM promotional WHERE start_date <= CURDATE() AND end_date >= CURDATE()`
    );
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
