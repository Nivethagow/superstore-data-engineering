-- ============================================================
-- Superstore Retail Database - DDL Schema (OLTP)
-- Source: superstore_db_full_backup.sql
-- Engine: MySQL InnoDB | Charset: utf8mb4
-- ============================================================

-- Geographic hierarchy (load bottom-up: region → state → city)

CREATE TABLE `region` (
  `region_id` int NOT NULL AUTO_INCREMENT,
  `region` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `state` (
  `state` varchar(30) NOT NULL,
  `region_id` int DEFAULT NULL,
  PRIMARY KEY (`state`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `state_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `zip` int DEFAULT NULL,
  PRIMARY KEY (`city_id`),
  UNIQUE KEY `city` (`city`,`state`,`zip`),
  KEY `state` (`state`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`state`) REFERENCES `state` (`state`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Product hierarchy (load: category → subcategory → manufactory → product)

CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(30) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `subcategory` (
  `subcategory_id` int NOT NULL AUTO_INCREMENT,
  `subcategory` varchar(30) NOT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`subcategory_id`),
  UNIQUE KEY `subcategory` (`subcategory`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `manufactory` (
  `manufactory_id` int NOT NULL AUTO_INCREMENT,
  `manufactory` varchar(30) NOT NULL,
  PRIMARY KEY (`manufactory_id`),
  UNIQUE KEY `manufactory` (`manufactory`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `subcategory_id` int DEFAULT NULL,
  `manufactory_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `subcategory_id` (`subcategory_id`),
  KEY `manufactory_id` (`manufactory_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategory` (`subcategory_id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`manufactory_id`) REFERENCES `manufactory` (`manufactory_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Customer

CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(30) NOT NULL,
  `segment` varchar(30) DEFAULT NULL,
  `city_id` int DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Orders

CREATE TABLE `orders` (
  `order_id` varchar(30) NOT NULL,
  `order_date` date NOT NULL,
  `ship_date` date NOT NULL,
  `customer_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Order line items

CREATE TABLE `orders_detail` (
  `orders_detail_id` int NOT NULL AUTO_INCREMENT,
  `order_id` varchar(30) DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `profit` float DEFAULT NULL,
  `profit_margin` float DEFAULT NULL,
  PRIMARY KEY (`orders_detail_id`),
  UNIQUE KEY `order_id` (`order_id`,`product_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `orders_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Staging table (raw CSV ingest via SSIS)

CREATE TABLE `stg_superstore_data` (
  `Surrogate_Key` bigint NOT NULL AUTO_INCREMENT,
  `order_id` varchar(30) DEFAULT NULL,
  `order_date` varchar(50) DEFAULT NULL,
  `ship_date` varchar(50) DEFAULT NULL,
  `customer` varchar(30) DEFAULT NULL,
  `manufactory` varchar(30) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `segment` varchar(30) DEFAULT NULL,
  `category` varchar(30) DEFAULT NULL,
  `subcategory` varchar(30) DEFAULT NULL,
  `region` varchar(30) DEFAULT NULL,
  `zip` int DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `profit` float DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `sales` float DEFAULT NULL,
  `profit_margin` float DEFAULT NULL,
  `Load_Timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Surrogate_Key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
