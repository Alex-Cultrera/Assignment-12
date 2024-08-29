CREATE SCHEMA IF NOT EXISTS `pizza_restaurant_orders` ;

USE `pizza_restaurant_orders`;

CREATE TABLE IF NOT EXISTS `customers` (
  `phone_number` VARCHAR(15) NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`customer_id`));
  
  CREATE TABLE IF NOT EXISTS `orders` (
  `date_time` DATETIME NOT NULL,
  `day_of_week` VARCHAR(10),
  `order_total_price` DECIMAL(4,2),
  `order_number` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order_number`));
  
  CREATE TABLE IF NOT EXISTS `items` (
  `pizza_type` VARCHAR(18) NOT NULL,
  `pizza_unit_price` DECIMAL(4,2),
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

DELIMITER $$
CREATE PROCEDURE UpdateDayOfWeek()
BEGIN
    UPDATE `orders`
    SET `day_of_week` = DAYNAME(date_time)
    WHERE `order_number` > 0;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE UpdateUnitPrice()
BEGIN
    UPDATE `items`
    SET `pizza_unit_price` = CASE
		WHEN `pizza_type` = 'Pepperoni & Cheese' THEN 7.99
		WHEN `pizza_type` = 'Vegetarian' THEN 9.99
		WHEN `pizza_type` = 'Meat Lovers' THEN 14.99
		WHEN `pizza_type` = 'Hawaiian' THEN 12.99
		ELSE `pizza_unit_price`
	END
    WHERE `pizza_type` IN ('Pepperoni & Cheese', 'Vegetarian', 'Meat Lovers', 'Hawaiian');
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE UpdateOrderTotalPrice()
BEGIN
    UPDATE `orders` o
    JOIN (
		SELECT oi.order_number, SUM(i.pizza_unit_price * oi.quantity) AS total_price
		FROM order_items oi
		JOIN items i ON oi.pizza_type = i.pizza_type
		GROUP BY oi.order_number
    )resulting_table ON o.order_number = resulting_table.order_number
SET o.order_total_price = resulting_table.total_price
WHERE o.order_number > 0;
END$$
DELIMITER ;





