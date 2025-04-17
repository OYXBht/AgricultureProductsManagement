CREATE SCHEMA `demo` DEFAULT CHARACTER SET utf8 ;
use demo;

CREATE TABLE `user` (
  `user_id` INT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `role` ENUM('ADMIN', 'USER') NOT NULL DEFAULT 'USER',
  `status` ENUM('ENABLED', 'DISABLED') NOT NULL DEFAULT 'ENABLED',
  `email` VARCHAR(100),
  `phone` VARCHAR(20),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
);
CREATE TABLE `category` (
  `category_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL
);
CREATE TABLE `product` (
  `product_id` INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` TEXT,
  `price` DECIMAL(10,2) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `category_id` INT NOT NULL,
  `status` ENUM('ON_SALE', 'OFF_SALE') NOT NULL DEFAULT 'ON_SALE',
  `image_url` VARCHAR(255),
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  FOREIGN KEY (`category_id`) REFERENCES `category`(`category_id`) ON DELETE RESTRICT
);
CREATE TABLE `order` (
  `order_id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `order_number` VARCHAR(50) UNIQUE NOT NULL,
  `total_amount` DECIMAL(10,2) NOT NULL,
  `payment_status` ENUM('PAID', 'UNPAID') NOT NULL DEFAULT 'UNPAID',
  `shipping_status` ENUM('SHIPPED', 'UNSHIPPED') NOT NULL DEFAULT 'UNSHIPPED',
  `receiving_status` ENUM('RECEIVED', 'UNRECEIVED') NOT NULL DEFAULT 'UNRECEIVED',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
);
CREATE TABLE `order_item` (
  `order_item_id` INT PRIMARY KEY AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price_at_order` DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
);