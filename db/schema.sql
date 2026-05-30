-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.30

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES (1,1,1,1,1),(2,3,1,1,1),(3,4,1,1,1);
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,0,'alice@example.com','pwd1','Alice Johnson'),(2,0,'bob@example.com','pwd2','Bob Brown'),(3,0,'lylaisrun11k2022@gmail.com','123','ly laisrun'),(4,0,'1234','123','1234'),(5,0,'123','123','123456'),(6,1,'Dayou','123','Ra');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `customer_contacts` WRITE;
/*!40000 ALTER TABLE `customer_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_contacts` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `customer_group` WRITE;
/*!40000 ALTER TABLE `customer_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_group` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Grand Palace','123 Luxury Ave','Phnom Penh','Cambodia'),(2,'City Stay','456 Business St','Phnom Penh','Cambodia'),(500,'PHROVILLA','42p Street','Phnom Penh','Cambodia');
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `hotel_contacts` WRITE;
/*!40000 ALTER TABLE `hotel_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `hotel_contacts` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `promotional` WRITE;
/*!40000 ALTER TABLE `promotional` DISABLE KEYS */;
INSERT INTO `promotional` VALUES (1,'Summer Sale',10.00,'2026-05-01','2026-06-01');
/*!40000 ALTER TABLE `promotional` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (12,3,19,1,NULL,'2026-05-25','2026-05-30',50.00,1),(13,3,20,2,NULL,'2026-05-25','2026-05-30',150.00,1),(14,3,21,1,NULL,'2026-05-26','2026-05-30',50.00,1),(15,3,22,1,NULL,'2026-05-27','2026-05-28',50.00,0),(16,3,23,2,NULL,'2026-05-26','2026-05-28',300.00,1),(17,3,20,2,NULL,'2026-05-26','2026-05-30',150.00,1),(18,3,24,1,NULL,'2026-05-30','2026-05-31',1.00,0),(19,3,25,2,NULL,'2026-05-27','2026-05-28',150.00,0),(20,3,26,3,NULL,'2026-05-27','2026-05-28',67.00,0),(21,3,27,2,NULL,'2026-05-29','2026-05-30',150.00,0),(22,3,28,3,NULL,'2026-05-28','2026-05-27',134.00,1),(23,3,28,3,NULL,'2026-05-27','2026-05-27',134.00,1),(24,3,19,1,NULL,'2026-05-30','2026-05-30',50.00,1),(25,3,20,2,NULL,'2026-05-30','2026-05-30',150.00,1),(26,3,21,1,NULL,'2026-05-30','2026-05-30',50.00,1),(27,3,21,1,NULL,'2026-05-30','2026-05-30',50.00,1);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (19,3,1,'2026-05-25','2026-05-26','completed',NULL),(20,3,2,'2026-05-25','2026-05-26','completed',NULL),(21,3,1,'2026-05-26','2026-05-27','completed',NULL),(22,3,1,'2026-05-27','2026-05-28','confirmed',NULL),(23,3,2,'2026-05-26','2026-05-28','cancelled',NULL),(24,3,1,'2026-05-30','2026-05-31','confirmed',NULL),(25,3,2,'2026-05-27','2026-05-28','pending',NULL),(26,3,3,'2026-05-27','2026-05-28','pending',NULL),(27,3,2,'2026-05-29','2026-05-30','cancelled',NULL),(28,3,3,'2026-05-28','2026-05-30','completed',NULL);
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,3,1,'2026-05-29 10:29:35','the floor rape me',1),(2,1,3,5,'2026-05-30 11:00:00','Absolutely stunning view! The room service was incredibly fast and the bed felt like sleeping on a cloud.',1),(3,1,3,4,'2026-05-30 12:15:00','Very clean room and lovely boutique styling. Only downside was the Wi-Fi dropped out once or twice during my Zoom call.',1),(4,1,3,2,'2026-05-30 13:30:00','The AC unit was making a weird rattling noise all night. Staff tried to fix it but it kept me awake. Disappointed.',1),(5,1,3,5,'2026-05-30 14:45:00','Phrovilla is an absolute gem! Perfect location, walking distance to everything, and beautifully designed spaces.',1),(6,1,3,3,'2026-05-30 15:00:00','Decent stay for the assignment project demo. Standard features match the code layout perfectly.',1),(7,1,3,5,'2026-05-30 16:20:00','Extremely helpful staff at the front desk. Checked me in early without any hassle. Will definitely book again!',1),(8,1,3,5,'2026-05-30 17:10:00','The architectural blend of modern luxury and local Cambodian charm is stunning. Phrovilla exceeded all expectations.',1),(9,1,3,4,'2026-05-30 18:05:00','Perfect boutique experience. Quiet, peaceful, and beautifully landscaped grounds. Will definitely be returning next semester!',1),(10,1,3,3,'2026-05-30 19:22:00','The room design was lovely, but the breakfast options were somewhat limited. Everything else was exceptional.',1),(11,1,3,5,'2026-05-30 20:40:00','An absolute sanctuary in Phnom Penh. The staff treated us like royalty from check-in to checkout.',1),(12,1,3,5,'2026-05-30 21:15:00','Flawless execution! Clean sheets, pristine bathroom, and a very cozy atmosphere. Highly recommended!',1),(13,1,3,2,'2026-05-30 22:01:00','Water pressure in the shower was a bit weak during peak morning hours. The room itself was gorgeous though.',1),(14,1,3,4,'2026-05-30 22:30:00','Great location for our database assignment group meetings. High-speed internet worked perfectly throughout the lobby.',1),(15,1,3,5,'2026-05-30 23:12:00','Incredible attention to detail. Loved the complementary refreshments and local treats provided in the room.',1),(16,1,3,4,'2026-05-30 23:45:00','Very comfortable mattress and excellent soundproofing. Had a wonderfully restful night of sleep.',1),(17,2,3,5,'2026-05-30 11:00:00','Absolutely stunning view! The room service was incredibly fast and the bed felt like sleeping on a cloud.',1),(18,2,3,4,'2026-05-30 12:15:00','Very clean room and lovely boutique styling. Only downside was the Wi-Fi dropped out once or twice during my Zoom call.',1),(19,2,3,2,'2026-05-30 13:30:00','The AC unit was making a weird rattling noise all night. Staff tried to fix it but it kept me awake. Disappointed.',1),(20,2,3,5,'2026-05-30 14:45:00','Phrovilla is an absolute gem! Perfect location, walking distance to everything, and beautifully designed spaces.',1),(21,2,3,3,'2026-05-30 15:00:00','Decent stay for the assignment project demo. Standard features match the code layout perfectly.',1),(22,2,3,5,'2026-05-30 16:20:00','Extremely helpful staff at the front desk. Checked me in early without any hassle. Will definitely book again!',1),(23,3,3,5,'2026-05-30 17:25:33','i wat to die',1);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,'101','standard',50.00,2,NULL,'free'),(2,1,'202','suite',150.00,4,NULL,'free'),(3,1,'102','deluxe',67.00,1,NULL,'free'),(4,1,'103','standard',70.00,2,NULL,'free');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

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

LOCK TABLES `room_img` WRITE;
/*!40000 ALTER TABLE `room_img` DISABLE KEYS */;
INSERT INTO `room_img` VALUES (1,1,'http://localhost:3000/customer/img/lova.gif'),(2,2,'http://localhost:3000/customer/img/cute.gif'),(3,1,'http://localhost:3000/customer/img/cute.gif'),(4,1,'http://localhost:3000/customer/img/chisa.gif'),(5,3,'http://localhost:3000/customer/img/lova.gif'),(6,4,'http://localhost:3000/customer/img/room_4.png');
/*!40000 ALTER TABLE `room_img` ENABLE KEYS */;
UNLOCK TABLES;

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
  `penalty_point` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`,`hotel_id`),
  UNIQUE KEY `staff_id_UNIQUE` (`staff_id`),
  KEY `fk_Staff_Hotel1_idx` (`hotel_id`),
  CONSTRAINT `fk_Staff_Hotel1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,1,'John','Doe','pass123','012345678','manager','active',24999.99,NULL),(2,1,'Jane','Smith','pass123','099887766','house_keeping','active',1200.00,NULL),(3,1,'ly','laisrun','pass123','0885130520','cashier','active',2000.00,1);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-30 17:48:47
