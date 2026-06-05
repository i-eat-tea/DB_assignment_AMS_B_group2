-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
-- Host: Aiven Cloud    Database: defaultdb
-- Server version	8.0.30

USE defaultdb;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `is_blacklisted` tinyint NOT NULL,
  `email` varchar(245) NOT NULL,
  `customer_password` varchar(45) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id_UNIQUE` (`customer_id`),
  UNIQUE KEY `Customercol_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,0,'devid@gmail.com','pwd1','Dara Devid'),(2,0,'srunzin@gmail.com','pwd2','Sloy Srun'),(3,0,'lylaisrun11k2022@gmail.com','123','ly laisrun'),(4,0,'seavmingcute@gmail.com','123','Ly Seavming'),(5,0,'theary@gmail.com','1233','Rith Theary'),(6,1,'steavu@gmail.com','1123','Ra Dayu'),(7,0,'Bopha@gmail.com','123','Chan Bopha'),(8,0,'sokha@gmail.com','123','Kim Sokha'),(9,0,'pichpich@gmail.com','123','Pich Dara'),(10,0,'sreynichheng@gmail.com','123','Heng Sreynich'),(11,0,'vanna@gmail.com','123','Noun Vanna'),(12,0,'roschanthou@gmail.com','123','Ros Chanthou'),(13,0,'sethseth@gmail.com','123','Sok Piseth'),(14,0,'kunthea168@gmail.com','123','Mao Kunthea'),(15,0,'sokhom169@gmail.com','123','Lim Sokhom'),(16,0,'sothea@gmail.com','123','Pen Sothea'),(17,0,'soksok@gmail.com','123', 'Pen Sok'), (18, 0, 'Netsky@gmail.com', '123', 'Roeurn Phannet'), (19, 0, 'heng168@gmail.com','123','Heng Visal'), (20, 0, 'ratanak@gmail.com', '123', 'Neang Ratanak');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `hotel_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`hotel_id`),
  UNIQUE KEY `hotel_id_UNIQUE` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Grand Palace','123 Luxury Ave','Phnom Penh','Cambodia'),
(2,'City Stay','456 Business St','Phnom Penh','Cambodia'),
(500,'PHROVILLA','42p Street','Phnom Penh','Cambodia');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `number` varchar(10) NOT NULL,
  `type` enum('standard','deluxe','suite') NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `capacity` int NOT NULL,
  `picture_url` varchar(255) DEFAULT NULL,
  `conditions` enum('free','occupied','repairing') NOT NULL,
  PRIMARY KEY (`room_id`,`hotel_id`),
  UNIQUE KEY `room_id_UNIQUE` (`room_id`),
  KEY `fk_Room_Hotel1_idx` (`hotel_id`),
  CONSTRAINT `fk_Room_Hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,'101','standard',50.00,2,NULL,'free'),
(2,1,'202','suite',150.00,4,NULL,'free'),
(3,1,'102','deluxe',67.00,1,NULL,'free'),
(4,1,'103','standard',70.00,2,NULL,'free'),
(5,1,'104','standard',55.00,2,NULL,'free'),
(6,1,'105','standard',55.00,2,NULL,'free'),
(7,1,'203','deluxe',80.00,2,NULL,'free'),
(8,1,'204','deluxe',85.00,2,NULL,'free'),
(9,1,'301','suite',160.00,4,NULL,'free');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `amenities_id` int NOT NULL AUTO_INCREMENT,
  `room_id` int NOT NULL,
  `has_wifi` tinyint NOT NULL,
  `bedroom_amount` int NOT NULL,
  `bathroom_amount` int NOT NULL,
  PRIMARY KEY (`amenities_id`,`room_id`),
  UNIQUE KEY `amenities_id_UNIQUE` (`amenities_id`),
  KEY `fk_amenities_Room1_idx` (`room_id`),
  CONSTRAINT `fk_amenities_Room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,1,1,1,1),(2,3,1,1,1),(3,4,1,1,1),(4,5,1,1,1),(5,6,1,1,1),(6,7,1,1,1),(7,8,1,1,1),(8,9,1,2,2);
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;

--
-- Table structure for table `customer_contacts`
--

DROP TABLE IF EXISTS `customer_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_contacts` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `label` varchar(45) NOT NULL,
  PRIMARY KEY (`contact_id`,`customer_id`),
  UNIQUE KEY `contact_id_UNIQUE` (`contact_id`),
  KEY `fk_Customer_Contacts_Customer1_idx` (`customer_id`),
  CONSTRAINT `fk_Customer_Contacts_Customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_contacts`
--

/*!40000 ALTER TABLE `customer_contacts` DISABLE KEYS */;
INSERT INTO `customer_contacts` VALUES (1,7,'012345701','mobile'),(2,8,'012345702','mobile'),(3,9,'012345703','mobile'),(4,10,'012345704','mobile'),(5,11,'012345705','mobile'),(6,12,'012345706','mobile'),(7,13,'012345707','mobile'),(8,14,'012345708','mobile'),(9,15,'012345709','mobile'),(10,16,'012345710','mobile');
/*!40000 ALTER TABLE `customer_contacts` ENABLE KEYS */;

--
-- Table structure for table `customer_group`
--

DROP TABLE IF EXISTS `customer_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_group` (
  `Customer_group_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `adults` int NOT NULL,
  `childs` int DEFAULT NULL,
  PRIMARY KEY (`Customer_group_id`,`customer_id`),
  UNIQUE KEY `Customer_group_id_UNIQUE` (`Customer_group_id`),
  KEY `fk_Customer_group_Customer1_idx` (`customer_id`),
  CONSTRAINT `fk_Customer_group_Customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_group`
--

/*!40000 ALTER TABLE `customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_group` ENABLE KEYS */;

--
-- Table structure for table `hotel_contacts`
--

DROP TABLE IF EXISTS `hotel_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_contacts` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `contact_number` varchar(45) NOT NULL,
  `label` varchar(45) NOT NULL,
  PRIMARY KEY (`contact_id`,`hotel_id`),
  UNIQUE KEY `contact_id_UNIQUE` (`contact_id`),
  KEY `fk_Hotel_Contacts_Hotel1_idx` (`hotel_id`),
  CONSTRAINT `fk_Hotel_Contacts_Hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_contacts`
--

/*!40000 ALTER TABLE `hotel_contacts` DISABLE KEYS */;
INSERT INTO `hotel_contacts` VALUES (1,1,'023456789','reception'),(2,1,'0977244733','front desk'),(3,1,'096123456','reservations');
/*!40000 ALTER TABLE `hotel_contacts` ENABLE KEYS */;

--
-- Table structure for table `promotional`
--

DROP TABLE IF EXISTS `promotional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotional` (
  `promotional_id` int NOT NULL AUTO_INCREMENT,
  `statement` text,
  `discounts` decimal(5,2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`promotional_id`),
  UNIQUE KEY `promotional_id_UNIQUE` (`promotional_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotional`
--

/*!40000 ALTER TABLE `promotional` DISABLE KEYS */;
INSERT INTO `promotional` VALUES (1,'Children Day',10.00,'2026-05-31','2026-06-02');
/*!40000 ALTER TABLE `promotional` ENABLE KEYS */;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `reservation_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `room_id` int NOT NULL,
  `check_in_date` date NOT NULL,
  `check_out_date` date NOT NULL,
  `status` enum('pending','confirmed','cancelled','completed') NOT NULL,
  `customer_group_id` int DEFAULT NULL,
  PRIMARY KEY (`reservation_id`,`customer_id`,`room_id`),
  UNIQUE KEY `reservation_id_UNIQUE` (`reservation_id`),
  KEY `fk_Reservation_Customer1_idx` (`customer_id`),
  KEY `fk_Reservation_Room1_idx` (`room_id`),
  CONSTRAINT `fk_Reservation_Customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_Reservation_Room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (19,3,1,'2026-05-25','2026-05-26','completed',NULL),
(20,5,2,'2026-05-25','2026-05-26','completed',NULL),
(21,7,1,'2026-05-26','2026-05-27','completed',NULL),
(22,15,1,'2026-05-27','2026-05-28','confirmed',NULL),
(23,18,2,'2026-05-26','2026-05-28','cancelled',NULL),
(24,5,1,'2026-05-30','2026-05-31','confirmed',NULL),
(25,20,2,'2026-05-27','2026-05-28','pending',NULL),
(26,16,3,'2026-05-27','2026-05-28','pending',NULL),
(27,10,2,'2026-05-29','2026-05-30','cancelled',NULL),
(28,12,3,'2026-05-28','2026-05-30','completed',NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `receipt_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `reservation_id` int NOT NULL,
  `room_id` int NOT NULL,
  `promotional_id` int DEFAULT NULL,
  `clock_in` date DEFAULT NULL,
  `clock_out` date DEFAULT NULL,
  `total_bill` decimal(10,2) DEFAULT NULL,
  `is_paid` tinyint NOT NULL,
  PRIMARY KEY (`receipt_id`,`customer_id`,`reservation_id`,`room_id`,`is_paid`),
  UNIQUE KEY `receipt_id_UNIQUE` (`receipt_id`),
  KEY `fk_receipt_Customer1_idx` (`customer_id`),
  KEY `fk_receipt_Reservation1_idx` (`reservation_id`),
  KEY `fk_receipt_Room1_idx` (`room_id`),
  KEY `fk_receipt_Promotional1_idx` (`promotional_id`),
  CONSTRAINT `fk_receipt_Customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_receipt_Promotional1` FOREIGN KEY (`promotional_id`) REFERENCES `promotional` (`promotional_id`),
  CONSTRAINT `fk_receipt_Reservation1` FOREIGN KEY (`reservation_id`) REFERENCES `reservation` (`reservation_id`),
  CONSTRAINT `fk_receipt_Room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (12,5,19,1,NULL,'2026-05-25','2026-05-30',50.00,1),
(13,7,20,2,NULL,'2026-05-25','2026-05-30',150.00,1),
(14,15,21,1,NULL,'2026-05-26','2026-05-30',50.00,1),
(15,18,22,1,NULL,'2026-05-27','2026-05-28',50.00,0),
(16,5,23,2,NULL,'2026-05-26','2026-05-28',300.00,1),
(17,20,20,2,NULL,'2026-05-26','2026-05-30',150.00,1),
(18,16,24,1,NULL,'2026-05-30','2026-05-31',1.00,0),
(19,10,25,2,NULL,'2026-05-27','2026-05-28',150.00,0),
(20,12,26,3,NULL,'2026-05-27','2026-05-28',67.00,0),
(21,1,27,2,NULL,'2026-05-29','2026-05-30',150.00,0),
(22,2,28,3,NULL,'2026-05-28','2026-05-27',134.00,1),
(23,3,28,3,NULL,'2026-05-27','2026-05-27',134.00,1),
(24,4,19,1,NULL,'2026-05-30','2026-05-30',50.00,1),
(25,6,20,2,NULL,'2026-05-30','2026-05-30',150.00,1),
(26,8,21,1,NULL,'2026-05-30','2026-05-30',50.00,1),
(27,9,21,1,NULL,'2026-05-30','2026-05-30',50.00,1);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `room_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `stars` int NOT NULL,
  `time` datetime NOT NULL,
  `statement` text,
  `is_valid` tinyint NOT NULL,
  PRIMARY KEY (`review_id`,`room_id`,`customer_id`),
  UNIQUE KEY `review_id_UNIQUE` (`review_id`),
  KEY `fk_review_customer1_idx` (`customer_id`),
  KEY `fk_review_room1_idx` (`room_id`),
  CONSTRAINT `fk_review_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_review_room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES
-- Room 1: 18 reviews (IDs 1-18), mixed customers
(1,1,20,1,'2026-05-29 10:29:35','I never knew Cambodia had a hotel with such an insanely stunning view and princess-treatment service!',1),
(2,1,15,5,'2026-05-30 11:00:00','Absolutely stunning view! The room service was incredibly fast and the bed felt like sleeping on a cloud.',1),
(3,1,10,4,'2026-05-30 12:15:00','Very clean room and lovely boutique styling. Only downside was the Wi-Fi dropped out once or twice during my Zoom call.',1),
(4,1,5,2,'2026-05-30 13:30:00','The AC unit was making a weird rattling noise all night. Staff tried to fix it but it kept me awake. Disappointed.',1),
(5,1,1,5,'2026-05-30 14:45:00','Phrovilla is an absolute gem! Perfect location, walking distance to everything, and beautifully designed spaces.',1),
(6,1,3,3,'2026-05-30 15:00:00','Girls, this hotel is a hidden gem in Cambodia. If you are a queen, you deserve the royal treatment this place gives!',1),
(7,1,7,5,'2026-05-30 16:20:00','Extremely helpful staff at the front desk. Checked me in early without any hassle. Will definitely book again!',1),
(8,1,9,5,'2026-05-30 17:10:00','The architectural blend of modern luxury and local Cambodian charm is stunning. Phrovilla exceeded all expectations.',1),
(9,1,11,4,'2026-05-30 18:05:00','Perfect boutique experience. Quiet, peaceful, and beautifully landscaped grounds. Will definitely be returning next semester!',1),
(10,1,13,3,'2026-05-30 19:22:00','The room design was lovely, but the breakfast options were somewhat limited. Everything else was exceptional.',1),
(11,1,17,5,'2026-05-30 20:40:00','An absolute sanctuary in Phnom Penh. The staff treated us like royalty from check-in to checkout.',1),
(12,1,19,5,'2026-05-30 21:15:00','Flawless execution! Clean sheets, pristine bathroom, and a very cozy atmosphere. Highly recommended!',1),
(13,1,18,2,'2026-05-30 22:01:00','Water pressure in the shower was a bit weak during peak morning hours. The room itself was gorgeous though.',1),
(14,1,16,4,'2026-05-30 22:30:00','Great location for our database assignment group meetings. High-speed internet worked perfectly throughout the lobby.',1),
(15,1,14,5,'2026-05-30 23:12:00','Incredible attention to detail. Loved the complementary refreshments and local treats provided in the room.',1),
(16,1,12,4,'2026-05-30 23:45:00','Very comfortable mattress and excellent soundproofing. Had a wonderfully restful night of sleep.',1),
(17,1,8,4,'2026-05-31 08:10:00','Clean and comfortable room. The staff was friendly and welcoming. Good value for the price.',1),
(18,1,6,3,'2026-05-31 09:30:00','Room was decent but housekeeping could be more thorough. The lobby area is beautiful though.',1),
-- Room 2: 6 reviews (IDs 19-24)
(19,2,1,5,'2026-05-30 11:00:00','Absolutely stunning view! The room service was incredibly fast and the bed felt like sleeping on a cloud.',1),
(20,2,2,4,'2026-05-30 12:15:00','Very clean room and lovely boutique styling. Only downside was the Wi-Fi dropped out once or twice during my Zoom call.',1),
(21,2,3,2,'2026-05-30 13:30:00','The AC unit was making a weird rattling noise all night. Staff tried to fix it but it kept me awake. Disappointed.',1),
(22,2,4,5,'2026-05-30 14:45:00','Phrovilla is an absolute gem! Perfect location, walking distance to everything, and beautifully designed spaces.',1),
(23,2,5,3,'2026-05-30 15:00:00','Decent stay for the assignment project demo. Standard features match the code layout perfectly.',1),
(24,2,10,5,'2026-05-30 16:20:00','Extremely helpful staff at the front desk. Checked me in early without any hassle. Will definitely book again!',1),
-- Room 3: 5 reviews (IDs 25-29)
(25,3,3,5,'2026-05-30 17:25:33','The buffet in here is an other level because they have litterly everthing',1),
(26,3,4,4,'2026-05-31 10:00:00','Very spacious deluxe room. The bathroom was spotless and the shower pressure was great.',1),
(27,3,11,2,'2026-05-31 11:30:00','Expected more from a deluxe room. The minibar was not restocked and room service was slow.',1),
(28,3,12,5,'2026-05-31 13:00:00','Loved everything about this room. The decor is elegant and the bed is incredibly comfortable.',1),
(29,3,13,4,'2026-05-31 14:30:00','Good stay overall. The room was clean and quiet. Would recommend for solo travellers.',1),
-- Room 4: 5 reviews (IDs 30-34)
(30,4,1,4,'2026-05-31 09:00:00','Solid standard room at a fair price. The Wi-Fi was fast and the staff were polite.',1),
(31,4,2,5,'2026-05-31 10:15:00','Exceeded my expectations for a standard room. Very clean and the bed was very comfy.',1),
(32,4,5,3,'2026-05-31 11:45:00','Decent room but the view was not great. The bathroom was clean though and the TV worked well.',1),
(33,4,14,2,'2026-05-31 13:00:00','Noise from the corridor was quite loud at night. Might want to request a quieter floor.',1),
(34,4,15,5,'2026-05-31 14:15:00','Fantastic value for money. Friendly staff and a very pleasant stay. Will come back for sure.',1),
(35,4,6,1,'2026-05-31 09:05:00','Very disappointing. The room smelled musty and the AC was not working properly.',1),
(36,4,7,4,'2026-05-31 10:30:00','Nice clean room on a good floor. The breakfast included was a pleasant bonus.',1),
(37,4,8,5,'2026-05-31 12:00:00','Great value room. Everything was spotless and the staff were attentive and helpful.',1),
(38,4,9,3,'2026-05-31 13:30:00','Room was okay but a bit small for two people. The shower was hot and the bed was soft.',1),
(39,4,16,4,'2026-05-31 15:00:00','Comfortable stay. The room was clean and the amenities were well maintained.',1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;

--
-- Table structure for table `room_img`
--

DROP TABLE IF EXISTS `room_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_img` (
  `idroom_img` int NOT NULL AUTO_INCREMENT,
  `room_id` int NOT NULL,
  `link` longtext NOT NULL,
  PRIMARY KEY (`idroom_img`,`room_id`),
  UNIQUE KEY `idroom_img_UNIQUE` (`idroom_img`),
  KEY `fk_room_img_Room1_idx` (`room_id`),
  CONSTRAINT `fk_room_img_Room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_img`
--

/*!40000 ALTER TABLE `room_img` DISABLE KEYS */;
INSERT INTO `room_img` VALUES (1,1,'https://db-assignment-ams-b-group2.onrender.com/customer/img/lova.gif'),(2,2,'https://db-assignment-ams-b-group2.onrender.com/customer/img/cute.gif'),(3,1,'https://db-assignment-ams-b-group2.onrender.com/customer/img/cute.gif'),(4,1,'https://db-assignment-ams-b-group2.onrender.com/customer/img/chisa.gif'),(5,3,'https://db-assignment-ams-b-group2.onrender.com/customer/img/lova.gif'),(6,4,'https://db-assignment-ams-b-group2.onrender.com/customer/img/room_4.png');
/*!40000 ALTER TABLE `room_img` ENABLE KEYS */;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `contact_number` varchar(45) NOT NULL,
  `role` enum('manager','cashier','house_keeping') NOT NULL,
  `conditions` enum('active','terminated','planned_leave','unplanned_leave') NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `penalty_point` int DEFAULT 0,
  PRIMARY KEY (`staff_id`,`hotel_id`),
  UNIQUE KEY `staff_id_UNIQUE` (`staff_id`),
  KEY `fk_Staff_Hotel1_idx` (`hotel_id`),
  CONSTRAINT `fk_Staff_Hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES
(1,1,'Seavming','Ly','pass123','012345678','manager','active',24999.99,0),
(2,1,'Moeung','Devit','pass123','099887766','house_keeping','active',1200.00,0),
(3,1,'ly','laisrun','pass123','0885130520','cashier','active',2000.00,1),
(4,1,'Dara','Chea','pass123','012456789','manager','active',3500.00,0),
(5,1,'Sophea','Keo','pass123','096321456','manager','active',4200.00,0),
(6,1,'Vutha','Nget','pass123','097654321','cashier','active',900.00,0),
(7,1,'Ratana','Oun','pass123','012765432','cashier','active',850.00,2),
(8,1,'Kosal','Prum','pass123','096543210','cashier','active',950.00,0),
(9,1,'Sreyleak','Hak','pass123','099123456','house_keeping','active',450.00,0),
(10,1,'Borey','Sam','pass123','012876543','house_keeping','active',400.00,0),
(11,1,'Channary','Ros','pass123','096234567','house_keeping','active',500.00,1),
(12,1,'Pisey','Touch','pass123','097345678','house_keeping','active',420.00,0),
(13,1,'Makara','Sok','pass123','099456789','house_keeping','active',480.00,0),
(14,1,'Vicheka','Noun','pass123','012567890','house_keeping','planned_leave',430.00,0),
(15,1,'Sreynit','Khim','pass123','096678901','house_keeping','active',460.00,3);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-02 10:57
select  * from staff;
select  * from room;
select  * from room_img;
select  * from customer;
select  * from reservation;