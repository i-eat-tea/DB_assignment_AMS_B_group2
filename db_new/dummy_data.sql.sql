USE `mydb`;

-- 1. Insert Hotel
INSERT INTO `Hotel` (`name`, `street`, `city`, `country`) VALUES 
('Grand Palace', '123 Luxury Ave', 'Phnom Penh', 'Cambodia'),
('City Stay', '456 Business St', 'Phnom Penh', 'Cambodia');

-- 2. Insert Staff
INSERT INTO `Staff` (`hotel_id`, `first_name`, `last_name`, `password`, `contact_number`, `role`, `conditions`, `salary`) VALUES 
(1, 'John', 'Doe', 'pass123', '012345678', 'manager', 'active', 2500.00),
(1, 'Jane', 'Smith', 'pass123', '099887766', 'house_keeping', 'active', 1200.00);

-- 3. Insert Room
INSERT INTO `Room` (`Hotel_hotel_id`, `number`, `type`, `price`, `capacity`, `conditions`) VALUES 
(1, '101', 'standard', 50.00, 2, 'free'),
(1, '202', 'suite', 150.00, 4, 'free');

-- 4. Insert Customer
INSERT INTO `Customer` (`is_blacklisted`, `email`, `customer_password`, `name`) VALUES 
(0, 'alice@example.com', 'pwd1', 'Alice Johnson'),
(0, 'bob@example.com', 'pwd2', 'Bob Brown');

-- 5. Insert Reservation
INSERT INTO `Reservation` (`customer_id`, `room_id`, `check_in_date`, `check_out_date`, `status`) VALUES 
(1, 1, '2026-05-01', '2026-05-05', 'confirmed');

-- 6. Insert Promotional
INSERT INTO `Promotional` (`statement`, `discounts`, `start_date`, `end_date`) VALUES 
('Summer Sale', 10.00, '2026-05-01', '2026-06-01');

-- 7. Insert Receipt
INSERT INTO `Receipt` (`customer_id`, `reservation_id`, `room_id`, `promotional_id`, `clock_in`, `total_bill`, `is_paid`) VALUES 
(1, 1, 1, 1, '2026-05-01 14:00:00', 200.00, 0);

-- 8. Insert Amenities
INSERT INTO `Amenities` (`room_id`, `has_wifi`, `bedroom_amount`, `bathroom_amount`) VALUES 
(1, 1, 1, 1);