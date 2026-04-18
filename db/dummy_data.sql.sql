-- ============================================================
-- Hotel Database — Group 2
-- Dummy INSERT Statements for Testing
USE mydb;
-- ============================================================
-- Disable FK checks while inserting
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE review;
TRUNCATE TABLE receipt;
TRUNCATE TABLE reservation;
TRUNCATE TABLE promotional;
TRUNCATE TABLE customer_contacts;
TRUNCATE TABLE amenities;
TRUNCATE TABLE room;
TRUNCATE TABLE staff;
TRUNCATE TABLE hotel_contacts;
TRUNCATE TABLE customer;
TRUNCATE TABLE hotel;

-- ── Hotel ────────────────────────────────────────────────────
INSERT INTO hotel (hotel_id, name, street, city, country) VALUES
(1, 'Grand Phnom Penh Hotel', '123 Norodom Blvd', 'Phnom Penh', 'Cambodia'),
(2, 'Mekong River Inn', '45 Riverside Ave', 'Siem Reap', 'Cambodia');

-- ── Hotel_Contacts ───────────────────────────────────────────
INSERT INTO hotel_contacts (contact_id, hotel_id, contact_number, label) VALUES
(1, 1, '+855-23-100-001', 'Main'),
(2, 1, '+855-23-100-002', 'Reservations'),
(3, 1, '+855-23-100-003', 'Emergency'),
(4, 2, '+855-63-200-001', 'Main'),
(5, 2, '+855-63-200-002', 'Reservations');

-- ── Staff ────────────────────────────────────────────────────
INSERT INTO staff (staff_id, hotel_id, first_name, last_name, contact_number, role, conditions, salary, penalty_point) VALUES
(1, 1, 'Dara', 'Sok', '+855-12-111-001', 'manager', 'active', 1500.00, 0),
(2, 1, 'Sreyla', 'Chan', '+855-12-111-002', 'cashier', 'active', 800.00, 0),
(3, 1, 'Pisach', 'Lim', '+855-12-111-003', 'house_keeping', 'active', 600.00, 2),
(4, 2, 'Bopha', 'Keo', '+855-12-222-004', 'manager', 'active', 1400.00, 0),
(5, 2, 'Vannak', 'Pov', '+855-12-222-005', 'house_keeping', 'planned_leave', 600.00, 0);

-- ── Room ─────────────────────────────────────────────────────
INSERT INTO room (room_id, Hotel_hotel_id, number, type, price, capacity, picture_url, conditions) VALUES
(1, 1, '101', 'standard', 50.00, 2, NULL, 'free'),
(2, 1, '102', 'deluxe', 90.00, 2, NULL, 'free'),
(3, 1, '201', 'suite', 200.00, 4, NULL, 'occupied'),
(4, 2, 'A1', 'standard', 45.00, 2, NULL, 'free'),
(5, 2, 'A2', 'deluxe', 85.00, 3, NULL, 'repairing');

-- ── Amenities ────────────────────────────────────────────────
INSERT INTO amenities (amenities_id, room_id, has_wifi, bedroom_amount, bathroom_amount) VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 1, 1),
(3, 3, 1, 2, 2),
(4, 4, 1, 1, 1),
(5, 5, 0, 1, 1);

-- ── Customer ─────────────────────────────────────────────────
INSERT INTO customer (customer_id, first_name, last_name, date_of_birth, profession, nationality, is_blacklisted) VALUES
(1, 'Laisrun', 'Ly', '2003-05-15', 'Student', 'Cambodian', 0),
(2, 'James', 'Smith', '1990-08-22', 'Engineer', 'American', 0),
(3, 'Mia', 'Chen', '1985-03-10', 'Doctor', 'Chinese', 0),
(4, 'Ratha', 'Nget', '1995-11-30', 'Teacher', 'Cambodian', 1);

-- ── Customer_Contacts ────────────────────────────────────────
INSERT INTO customer_contacts (contact_id, customer_id, contact_number, label) VALUES
(1, 1, '+855-77-001-001', 'Mobile'),
(2, 1, '+855-23-001-001', 'Home'),
(3, 2, '+1-555-200-001', 'Mobile'),
(4, 3, '+86-138-000-001', 'Mobile'),
(5, 4, '+855-77-004-001', 'Mobile');

-- ── Promotional ──────────────────────────────────────────────
INSERT INTO promotional (promotional_id, statement, discounts, start_date, end_date) VALUES
(1, 'New Year Special — 20% off all rooms', 20.00, '2026-01-01', '2026-01-31'),
(2, 'Weekend Deal — 10% off standard rooms', 10.00, '2026-04-01', '2026-04-30');

-- ── Reservation ──────────────────────────────────────────────
INSERT INTO reservation (reservation_id, customer_id, room_id, check_in_date, check_out_date, status) VALUES
(1, 1, 1, '2026-04-10', '2026-04-15', 'completed'),
(2, 2, 2, '2026-04-12', '2026-04-14', 'completed'),
(3, 3, 3, '2026-04-16', '2026-04-20', 'confirmed'),
(4, 1, 4, '2026-05-01', '2026-05-05', 'pending');

-- ── Receipt ──────────────────────────────────────────────────
INSERT INTO receipt (receipt_id, customer_id, room_id, reservation_id, promotional_id, clock_in, clock_out, total_bill, is_paid) VALUES
(1, 1, 1, 1, 1, '2026-04-10 14:00:00', '2026-04-15 11:00:00', 200.00, 1),
(2, 2, 2, 2, 2, '2026-04-12 15:00:00', '2026-04-14 10:00:00', 180.00, 1);

-- ── Review ───────────────────────────────────────────────────
INSERT INTO review (review_id, customer_id, room_id, stars, statement, time, is_valid) VALUES
(1, 1, 1, 5, 'Amazing stay, very clean and samenities_idroom_idtaff was friendly!', '2026-04-15 12:00:00', 1),
(2, 2, 2, 4, 'Good room but breakfast could be better.', '2026-04-14 11:30:00', 1);

-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- Quick verify — run these after inserting
-- ============================================================
SELECT * FROM hotel;
SELECT * FROM customer;
SELECT * FROM reservation;
SELECT * FROM receipt;
select * from staff;