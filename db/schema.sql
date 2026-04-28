-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Hotel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Hotel` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Hotel` (
  `hotel_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hotel_id`),
  UNIQUE INDEX `hotel_id_UNIQUE` (`hotel_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hotel_Contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Hotel_Contacts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Hotel_Contacts` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `hotel_id` INT NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`contact_id`, `hotel_id`),
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC) VISIBLE,
  INDEX `fk_Hotel_Contacts_Hotel1_idx` (`hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Hotel_Contacts_Hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `mydb`.`Hotel` (`hotel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `staff_id` INT NOT NULL AUTO_INCREMENT,
  `hotel_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `role` ENUM('manager', 'cashier', 'house_keeping') NOT NULL,
  `conditions` ENUM('active', 'terminated', 'planned_leave', 'unplanned_leave') NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `penalty_point` INT NULL,
  PRIMARY KEY (`staff_id`, `hotel_id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE,
  INDEX `fk_Staff_Hotel1_idx` (`hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Staff_Hotel1`
    FOREIGN KEY (`hotel_id`)
    REFERENCES `mydb`.`Hotel` (`hotel_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Room` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Room` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `Hotel_hotel_id` INT NOT NULL,
  `number` VARCHAR(10) NOT NULL,
  `type` ENUM('standard', 'deluxe', 'suite') NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `capacity` INT NOT NULL,
  `picture_url` VARCHAR(255) NULL,
  `conditions` ENUM('free', 'occupied', 'repairing') NOT NULL,
  PRIMARY KEY (`room_id`, `Hotel_hotel_id`),
  UNIQUE INDEX `room_id_UNIQUE` (`room_id` ASC) VISIBLE,
  INDEX `fk_Room_Hotel1_idx` (`Hotel_hotel_id` ASC) VISIBLE,
  CONSTRAINT `fk_Room_Hotel1`
    FOREIGN KEY (`Hotel_hotel_id`)
    REFERENCES `mydb`.`Hotel` (`hotel_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `is_blacklisted` TINYINT NOT NULL,
  `email` VARCHAR(245) NOT NULL,
  `customer_password` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE,
  UNIQUE INDEX `Customercol_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Reservation` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Reservation` (
  `reservation_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `check_in_date` DATE NOT NULL,
  `check_out_date` DATE NOT NULL,
  `status` ENUM('pending', 'confirmed', 'cancelled', 'completed') NOT NULL,
  PRIMARY KEY (`reservation_id`, `customer_id`, `room_id`),
  UNIQUE INDEX `reservation_id_UNIQUE` (`reservation_id` ASC) VISIBLE,
  INDEX `fk_Reservation_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_Reservation_Room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_Reservation_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Reservation_Room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`Room` (`room_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer_Contacts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer_Contacts` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer_Contacts` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `contact_number` VARCHAR(20) NOT NULL,
  `label` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`contact_id`, `customer_id`),
  UNIQUE INDEX `contact_id_UNIQUE` (`contact_id` ASC) VISIBLE,
  INDEX `fk_Customer_Contacts_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Contacts_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Promotional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Promotional` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Promotional` (
  `promotional_id` INT NOT NULL AUTO_INCREMENT,
  `statement` TEXT NULL,
  `discounts` DECIMAL(5,2) NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`promotional_id`),
  UNIQUE INDEX `promotional_id_UNIQUE` (`promotional_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Receipt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Receipt` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Receipt` (
  `receipt_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `reservation_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `promotional_id` INT NOT NULL,
  `clock_in` DATETIME NOT NULL,
  `clock_out` DATETIME NULL,
  `total_bill` DECIMAL(10,2) NULL,
  `is_paid` TINYINT NOT NULL,
  PRIMARY KEY (`receipt_id`, `customer_id`, `reservation_id`, `room_id`, `is_paid`),
  UNIQUE INDEX `receipt_id_UNIQUE` (`receipt_id` ASC) VISIBLE,
  INDEX `fk_receipt_Customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_receipt_Reservation1_idx` (`reservation_id` ASC) VISIBLE,
  INDEX `fk_receipt_Room1_idx` (`room_id` ASC) VISIBLE,
  INDEX `fk_receipt_Promotional1_idx` (`promotional_id` ASC) VISIBLE,
  CONSTRAINT `fk_receipt_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_receipt_Reservation1`
    FOREIGN KEY (`reservation_id`)
    REFERENCES `mydb`.`Reservation` (`reservation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipt_Room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`Room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_receipt_Promotional1`
    FOREIGN KEY (`promotional_id`)
    REFERENCES `mydb`.`Promotional` (`promotional_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Review` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `room_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `stars` INT NOT NULL,
  `time` DATETIME NOT NULL,
  `statement` TEXT NULL,
  `is_valid` TINYINT NOT NULL,
  PRIMARY KEY (`review_id`, `room_id`, `customer_id`),
  UNIQUE INDEX `review_id_UNIQUE` (`review_id` ASC) VISIBLE,
  INDEX `fk_review_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_review_room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`Room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Amenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Amenities` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Amenities` (
  `amenities_id` INT NOT NULL AUTO_INCREMENT,
  `room_id` INT NOT NULL,
  `has_wifi` TINYINT NOT NULL,
  `bedroom_amount` INT NOT NULL,
  `bathroom_amount` INT NOT NULL,
  PRIMARY KEY (`amenities_id`, `room_id`),
  UNIQUE INDEX `amenities_id_UNIQUE` (`amenities_id` ASC) VISIBLE,
  INDEX `fk_amenities_Room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_amenities_Room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `mydb`.`Room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Customer_group` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Customer_group` (
  `Customer_group_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `adults` INT NOT NULL,
  `childs` INT NULL,
  PRIMARY KEY (`Customer_group_id`, `customer_id`),
  UNIQUE INDEX `Customer_group_id_UNIQUE` (`Customer_group_id` ASC) VISIBLE,
  INDEX `fk_Customer_group_Customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_group_Customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`room_img`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`room_img` ;

CREATE TABLE IF NOT EXISTS `mydb`.`room_img` (
  `idroom_img` INT NOT NULL,
  `Room_room_id` INT NOT NULL,
  `link` LONGTEXT NOT NULL,
  PRIMARY KEY (`idroom_img`, `Room_room_id`),
  UNIQUE INDEX `idroom_img_UNIQUE` (`idroom_img` ASC) VISIBLE,
  INDEX `fk_room_img_Room1_idx` (`Room_room_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_img_Room1`
    FOREIGN KEY (`Room_room_id`)
    REFERENCES `mydb`.`Room` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

