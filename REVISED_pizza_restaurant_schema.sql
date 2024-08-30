CREATE SCHEMA IF NOT EXISTS `pizza_restaurant_orders` ;

USE `pizza_restaurant_orders`;

CREATE TABLE IF NOT EXISTS `customers` (
  `phone_number` VARCHAR(15) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`customer_id`));
  
  CREATE TABLE IF NOT EXISTS `orders` (
  `date_time` DATETIME NOT NULL,
  `order_number` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order_number`));
  
  CREATE TABLE IF NOT EXISTS `items` (
  `pizza_type` VARCHAR(18) NOT NULL,
  PRIMARY KEY (`pizza_type`));
  
  CREATE TABLE IF NOT EXISTS `customer_orders` (
   `customer_id` INT,
   `order_number` INT,
   FOREIGN KEY (`customer_id`) references `customers` (`customer_id`),
   FOREIGN KEY (`order_number`) references `orders` (`order_number`)
);
 
 CREATE TABLE IF NOT EXISTS `order_items` (
  `order_number` INT,
  `pizza_type` VARCHAR(18),
  `quantity` INT,
  PRIMARY KEY (`order_number`, `pizza_type`),
  FOREIGN KEY (`order_number`) references `orders` (`order_number`),
  FOREIGN KEY (`pizza_type`) references `items` (`pizza_type`)
);

------------------------






	
	
