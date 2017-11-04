
-- ---
-- Globals
-- ---

-- mysql -u root -p appointmentserver < database/schema.sql

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;
DROP DATABASE IF EXISTS appointmentserver;

CREATE DATABASE appointmentserver;

USE appointmentserver;

-- ---
-- Table 'event'
--
-- ---

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `id_event` INTEGER AUTO_INCREMENT,
  `event_title` VARCHAR(50) NULL DEFAULT NULL,
  `start_day` DATE NOT NULL,
  `end_day` DATE NULL DEFAULT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `is_full_day` BINARY NOT NULL,
  `is_recurring` BINARY NOT NULL,
  `created_by` INTEGER NOT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parent_event_id` INTEGER NULL DEFAULT NULL,
  `program_id` INTEGER,
  PRIMARY KEY (`id_event`)
);

-- ---
-- Table 'recurring_pattern'
--
-- ---

DROP TABLE IF EXISTS `recurring_pattern`;

CREATE TABLE `recurring_pattern` (
  `event_id` INTEGER NOT NULL,
  `recurring_type_id` INTEGER NULL DEFAULT NULL,
  `separation_count` INTEGER NULL DEFAULT NULL,
  `max_n_occurences` INTEGER NULL DEFAULT NULL,
  `day_of_week` INTEGER NULL DEFAULT NULL,
  `week_of_month` INTEGER NULL DEFAULT NULL,
  `day_of_month` INTEGER NULL DEFAULT NULL,
  `month_of_year` INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'recurring_type'
--
-- ---

DROP TABLE IF EXISTS `recurring_type`;

CREATE TABLE `recurring_type` (
  `id_recurring_type` INTEGER AUTO_INCREMENT,
  `recurring_type` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_recurring_type`)
);

-- ---
-- Table 'event_instance_exception'
--
-- ---

DROP TABLE IF EXISTS `event_instance_exception`;

CREATE TABLE `event_instance_exception` (
  `id_event_exception` INTEGER AUTO_INCREMENT,
  `event_id` INTEGER NULL DEFAULT NULL,
  `is_rescheduled` BINARY NULL DEFAULT NULL,
  `is_cancelled` BINARY NULL DEFAULT NULL,
  `start_day` DATE NOT NULL,
  `end_day` DATE NULL DEFAULT NULL,
  `start_time` DATETIME NULL DEFAULT NULL,
  `end_time` DATETIME NOT NULL,
  `is_full_day` BINARY NULL DEFAULT NULL,
  `created_by` INTEGER NOT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `program_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_event_exception`)
);

-- ---
-- Table 'user_account'
--
-- ---

DROP TABLE IF EXISTS `user_account`;

CREATE TABLE `user_account` (
  `id_user_account` INTEGER AUTO_INCREMENT,
  `username` VARCHAR(128) NOT NULL,
  `email` VARCHAR(128) NOT NULL,
  `first_name` VARCHAR(128) NOT NULL,
  `last_name` VARCHAR(128) NOT NULL,
  `location_id` INTEGER NOT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_user_account`)
);

-- ---
-- Table 'service_provider'
--
-- ---

DROP TABLE IF EXISTS `service_provider`;

CREATE TABLE `service_provider` (
  `id_service_provider` INTEGER AUTO_INCREMENT,
  `user_account_id` INTEGER NOT NULL,
  PRIMARY KEY (`id_service_provider`)
);

-- ---
-- Table 'company'
--
-- ---

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `id_company` INTEGER AUTO_INCREMENT,
  `company_name` VARCHAR(128) NOT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_company`)
);

-- ---
-- Table 'location'
--
-- ---

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `id_location` INTEGER AUTO_INCREMENT,
  `address` VARCHAR(256) NOT NULL,
  `address_number` INTEGER NOT NULL,
  `zipcode` VARCHAR(8) NOT NULL,
  `phone` VARCHAR(13) NOT NULL,
  `address_comp` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_location`)
);

-- ---
-- Table 'company_employee'
--
-- ---

DROP TABLE IF EXISTS `company_employee`;

CREATE TABLE `company_employee` (
  `service_provider_id` INTEGER NOT NULL,
  `company_location_id` INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'certification'
--
-- ---

DROP TABLE IF EXISTS `certification`;

CREATE TABLE `certification` (
  `id_certification` INTEGER AUTO_INCREMENT,
  `service_provider_id` INTEGER NOT NULL,
  `certification_name` VARCHAR(128) NOT NULL,
  `provider` VARCHAR(128) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  `date_earned` DATE NOT NULL,
  PRIMARY KEY (`id_certification`)
);

-- ---
-- Table 'program'
--
-- ---

DROP TABLE IF EXISTS `program`;

CREATE TABLE `program` (
  `id_program` INTEGER AUTO_INCREMENT,
  `name` INTEGER NULL DEFAULT NULL,
  `description` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id_program`)
);

-- ---
-- Table 'class'
--
-- ---

DROP TABLE IF EXISTS `class`;

CREATE TABLE `class` (
  `id_class` INTEGER AUTO_INCREMENT,
  `description` MEDIUMTEXT NULL DEFAULT NULL,
  `day` DATE NOT NULL,
  `program_id` INTEGER NULL DEFAULT NULL,
  `max_capacity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_class`)
);

-- ---
-- Table 'class_structure'
--
-- ---

DROP TABLE IF EXISTS `class_structure`;

CREATE TABLE `class_structure` (
  `class_id` INTEGER NOT NULL,
  `exercise_id` INTEGER NOT NULL,
  `class_structure_id` INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'exercise'
--
-- ---

DROP TABLE IF EXISTS `exercise`;

CREATE TABLE `exercise` (
  `id_exercise` INTEGER AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `exercise_type_id` INTEGER NOT NULL,
  PRIMARY KEY (`id_exercise`)
);

-- ---
-- Table 'exercise_type'
--
-- ---

DROP TABLE IF EXISTS `exercise_type`;

CREATE TABLE `exercise_type` (
  `id_exercise_type` INTEGER AUTO_INCREMENT,
  `exercise_type_description` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id_exercise_type`)
);

-- ---
-- Table 'list_structure'
--
-- ---

DROP TABLE IF EXISTS `list_structure`;

CREATE TABLE `list_structure` (
  `id_list_structure` INTEGER AUTO_INCREMENT,
  `structure_name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id_list_structure`)
);

-- ---
-- Table 'customer'
--
-- ---

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id_customer` INTEGER AUTO_INCREMENT,
  `user_account_id` INTEGER NOT NULL,
  `tracker_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_customer`)
);

-- ---
-- Table 'product'
--
-- ---

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id_product` INTEGER AUTO_INCREMENT,
  `pro_name` VARCHAR(256) NULL DEFAULT NULL,
  `pro_description` MEDIUMTEXT NULL DEFAULT NULL,
  `pro_basic_unit` VARCHAR(256) NOT NULL,
  `pro_active_for_sale` BINARY NOT NULL,
  `pro_category_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_product`)
);

-- ---
-- Table 'company_location'
--
-- ---

DROP TABLE IF EXISTS `company_location`;

CREATE TABLE `company_location` (
  `id_company_location` INTEGER AUTO_INCREMENT,
  `company_id` INTEGER NOT NULL,
  `location_id` INTEGER NOT NULL,
  PRIMARY KEY (`id_company_location`)
);

-- ---
-- Table 'reservation'
--
-- ---

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `id_reservation` INTEGER AUTO_INCREMENT,
  `date` DATE NULL DEFAULT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` INTEGER NOT NULL,
  `company_location_id` INTEGER NOT NULL,
  `customer_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_reservation`)
);

-- ---
-- Table 'pro_pricing'
--
-- ---

DROP TABLE IF EXISTS `pro_pricing`;

CREATE TABLE `pro_pricing` (
  `id_pro_pricing` INTEGER AUTO_INCREMENT,
  `product_id` INTEGER NOT NULL,
  `pro_price` DOUBLE NULL DEFAULT NULL,
  `pro_time_created` DATE NOT NULL,
  `pro_date_expiry` DATE NULL DEFAULT NULL,
  `pro_is_active` BINARY NOT NULL,
  PRIMARY KEY (`id_pro_pricing`)
);

-- ---
-- Table 'pro_discount'
--
-- ---

DROP TABLE IF EXISTS `pro_discount`;

CREATE TABLE `pro_discount` (
  `id_product_discount` INTEGER AUTO_INCREMENT,
  `product_id` INTEGER NULL DEFAULT NULL,
  `pro_discount_value` DOUBLE NULL DEFAULT NULL,
  `pro_time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pro_date_expiry` DATE NOT NULL,
  `pro_coupon_code` VARCHAR(10) NULL DEFAULT NULL,
  `pro_max_discount_amount` DOUBLE NULL DEFAULT NULL,
  `pro_max_quantity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_product_discount`)
);

-- ---
-- Table 'pro_category'
--
-- ---

DROP TABLE IF EXISTS `pro_category`;

CREATE TABLE `pro_category` (
  `id_pro_category` INTEGER AUTO_INCREMENT,
  `pro_category` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_pro_category`)
);

-- ---
-- Table 'sale'
--
-- ---

DROP TABLE IF EXISTS `sale`;

CREATE TABLE `sale` (
  `id_sale` INTEGER AUTO_INCREMENT,
  `customer_id` INTEGER NOT NULL,
  `sale_amount` DOUBLE NOT NULL,
  `sale_amount_paid` DOUBLE NULL DEFAULT NULL,
  `time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `time_paid` TIMESTAMP NULL DEFAULT NULL,
  `payment_type_id` INTEGER NOT NULL,
  `sale_status_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_sale`)
);

-- ---
-- Table 'payment_type'
--
-- ---

DROP TABLE IF EXISTS `payment_type`;

CREATE TABLE `payment_type` (
  `id_payment_type` INTEGER AUTO_INCREMENT,
  `type_name` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`id_payment_type`)
);

-- ---
-- Table 'payment_data'
--
-- ---

DROP TABLE IF EXISTS `payment_data`;

CREATE TABLE `payment_data` (
  `id_payment_data` INTEGER AUTO_INCREMENT,
  `payment_type_id` INTEGER NULL DEFAULT NULL,
  `data_name` INTEGER NULL DEFAULT NULL,
  `fee` DOUBLE NOT NULL,
  PRIMARY KEY (`id_payment_data`)
);

-- ---
-- Table 'payment_details'
--
-- ---

DROP TABLE IF EXISTS `payment_details`;

CREATE TABLE `payment_details` (
  `id_payment_details` INTEGER AUTO_INCREMENT,
  `sale_id` INTEGER NOT NULL,
  `payment_data_id` INTEGER NOT NULL,
  `value` DOUBLE NOT NULL,
  `payment_date` DATE NOT NULL,
  `have_received` BINARY NOT NULL,
  `received_by` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_payment_details`)
);

-- ---
-- Table 'pro_inventory'
--
-- ---

DROP TABLE IF EXISTS `pro_inventory`;

CREATE TABLE `pro_inventory` (
  `product_id` INTEGER NOT NULL,
  `pro_in_stock` DOUBLE NOT NULL,
  `pro_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---
-- Table 'pro_sale_item'
--
-- ---

DROP TABLE IF EXISTS `pro_sale_item`;

CREATE TABLE `pro_sale_item` (
  `id_product_sale_item` INTEGER AUTO_INCREMENT,
  `pro_quantity_sold` DOUBLE NOT NULL,
  `pro_price_per_unit` DOUBLE NOT NULL,
  `sale_id` INTEGER NULL DEFAULT NULL,
  `product_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_product_sale_item`)
);

-- ---
-- Table 'continuous_service'
--
-- ---

DROP TABLE IF EXISTS `continuous_service`;

CREATE TABLE `continuous_service` (
  `id_continuous_service` INTEGER AUTO_INCREMENT,
  `cos_name` VARCHAR(256) NULL DEFAULT NULL,
  `cos_description` VARCHAR(4000) NULL DEFAULT NULL,
  `cos_basic_unit` VARCHAR(256) NULL DEFAULT NULL,
  `cos_active_for_sale` BINARY NULL DEFAULT NULL,
  `cos_category_id` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_continuous_service`)
);

-- ---
-- Table 'cos_category'
--
-- ---

DROP TABLE IF EXISTS `cos_category`;

CREATE TABLE `cos_category` (
  `id_cos_category` INTEGER AUTO_INCREMENT,
  `cos_category` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_cos_category`)
);

-- ---
-- Table 'cos_pricing'
--
-- ---

DROP TABLE IF EXISTS `cos_pricing`;

CREATE TABLE `cos_pricing` (
  `id_cos_pricing` INTEGER AUTO_INCREMENT,
  `continuous_service_id` INTEGER NULL DEFAULT NULL,
  `cos_price` DOUBLE NOT NULL,
  `cos_time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cos_date_expiry` DATE NULL DEFAULT NULL,
  `cos_is_active` BINARY NOT NULL,
  PRIMARY KEY (`id_cos_pricing`)
);

-- ---
-- Table 'cos_discount'
--
-- ---

DROP TABLE IF EXISTS `cos_discount`;

CREATE TABLE `cos_discount` (
  `id_cos_discount` INTEGER AUTO_INCREMENT,
  `continuous_service_id` INTEGER NOT NULL,
  `cos_discount_value` DOUBLE NOT NULL,
  `cos_time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cos_date_expiry` DATE NOT NULL,
  `cos_coupon_code` VARCHAR(10) NULL DEFAULT NULL,
  `cos_max_discount_amount` DOUBLE NULL DEFAULT NULL,
  `cos_max_quantity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_cos_discount`)
);

-- ---
-- Table 'cos_sale_item'
--
-- ---

DROP TABLE IF EXISTS `cos_sale_item`;

CREATE TABLE `cos_sale_item` (
  `id_cos_sale_item` INTEGER AUTO_INCREMENT,
  `cos_quantity_sold` DOUBLE NOT NULL,
  `cos_price_per_unity` DOUBLE NOT NULL,
  `sale_id` INTEGER NULL DEFAULT NULL,
  `continuous_service_id` INTEGER NULL DEFAULT NULL,
  `cos_start_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cos_end_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_cos_sale_item`)
);

-- ---
-- Table 'one_time_service'
--
-- ---

DROP TABLE IF EXISTS `one_time_service`;

CREATE TABLE `one_time_service` (
  `id_one_time_service` INTEGER AUTO_INCREMENT,
  `ots_name` VARCHAR(256) NOT NULL,
  `ots_description` VARCHAR(4000) NOT NULL,
  `ots_basic_unit` VARCHAR(256) NOT NULL,
  `ots_active_for_sale` BINARY NOT NULL,
  `ots_category_id` INTEGER NOT NULL,
  PRIMARY KEY (`id_one_time_service`)
);

-- ---
-- Table 'ots_category'
--
-- ---

DROP TABLE IF EXISTS `ots_category`;

CREATE TABLE `ots_category` (
  `id_ots_category` INTEGER AUTO_INCREMENT,
  `ots_category` VARCHAR(256) NULL DEFAULT NULL,
  PRIMARY KEY (`id_ots_category`)
);

-- ---
-- Table 'ots_pricing'
--
-- ---

DROP TABLE IF EXISTS `ots_pricing`;

CREATE TABLE `ots_pricing` (
  `id_ots_pricing` INTEGER AUTO_INCREMENT,
  `one_time_service_id` INTEGER NULL DEFAULT NULL,
  `ots_price` DOUBLE NOT NULL,
  `ots_time_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ots_date_expiry` DATE NOT NULL,
  `ots_is_active` BINARY NOT NULL,
  PRIMARY KEY (`id_ots_pricing`)
);

-- ---
-- Table 'ots_discount'
--
-- ---

DROP TABLE IF EXISTS `ots_discount`;

CREATE TABLE `ots_discount` (
  `id_ots_discount` INTEGER AUTO_INCREMENT,
  `one_time_service_id` INTEGER NULL DEFAULT NULL,
  `ots_discount_value` DOUBLE NOT NULL,
  `ots_time_created` DATE NOT NULL,
  `ots_date_expiry` DATE NOT NULL,
  `ots_coupon_code` VARCHAR(10) NULL DEFAULT NULL,
  `ots_max_discount_amount` INTEGER NULL DEFAULT NULL,
  `ots_max_quantity` INTEGER NULL DEFAULT NULL,
  PRIMARY KEY (`id_ots_discount`)
);

-- ---
-- Table 'ots_sale_item'
--
-- ---

DROP TABLE IF EXISTS `ots_sale_item`;

CREATE TABLE `ots_sale_item` (
  `id_ots_sale_item` INTEGER AUTO_INCREMENT,
  `ots_quantity_sold` DOUBLE NOT NULL,
  `ots_price_per_unity` DOUBLE NULL DEFAULT NULL,
  `sale_id` INTEGER NOT NULL,
  `one_time_service_id` INTEGER NOT NULL,
  `ots_end_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_ots_sale_item`)
);

-- ---
-- Table 'customer_inventory'
--
-- ---

DROP TABLE IF EXISTS `customer_inventory`;

CREATE TABLE `customer_inventory` (
  `customer_id` INTEGER NOT NULL,
  `one_time_service_id` INTEGER NOT NULL,
  `ots_quantity` DOUBLE NOT NULL,
  `ots_last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ---
-- Table 'sale_status'
--
-- ---

DROP TABLE IF EXISTS `sale_status`;

CREATE TABLE `sale_status` (
  `id_sale_status` INTEGER AUTO_INCREMENT,
  `status_name` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id_sale_status`)
);

-- ---
-- Table 'customer_company'
--
-- ---

DROP TABLE IF EXISTS `customer_company`;

CREATE TABLE `customer_company` (
  `company_location_id` INTEGER NOT NULL,
  `customer_id` INTEGER NOT NULL,
  `sale_id` INTEGER NOT NULL
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE `event` ADD FOREIGN KEY (created_by) REFERENCES `service_provider` (`id_service_provider`);
ALTER TABLE `event` ADD FOREIGN KEY (program_id) REFERENCES `program` (`id_program`);
ALTER TABLE `recurring_pattern` ADD FOREIGN KEY (event_id) REFERENCES `event` (`id_event`);
ALTER TABLE `recurring_pattern` ADD FOREIGN KEY (recurring_type_id) REFERENCES `recurring_type` (`id_recurring_type`);
ALTER TABLE `event_instance_exception` ADD FOREIGN KEY (event_id) REFERENCES `event` (`id_event`);
ALTER TABLE `event_instance_exception` ADD FOREIGN KEY (created_by) REFERENCES `service_provider` (`id_service_provider`);
ALTER TABLE `event_instance_exception` ADD FOREIGN KEY (program_id) REFERENCES `program` (`id_program`);
ALTER TABLE `user_account` ADD FOREIGN KEY (location_id) REFERENCES `location` (`id_location`);
ALTER TABLE `service_provider` ADD FOREIGN KEY (user_account_id) REFERENCES `user_account` (`id_user_account`);
ALTER TABLE `company_employee` ADD FOREIGN KEY (service_provider_id) REFERENCES `service_provider` (`id_service_provider`);
ALTER TABLE `company_employee` ADD FOREIGN KEY (company_location_id) REFERENCES `company_location` (`id_company_location`);
ALTER TABLE `certification` ADD FOREIGN KEY (service_provider_id) REFERENCES `service_provider` (`id_service_provider`);
ALTER TABLE `class` ADD FOREIGN KEY (program_id) REFERENCES `program` (`id_program`);
ALTER TABLE `class_structure` ADD FOREIGN KEY (class_id) REFERENCES `class` (`id_class`);
ALTER TABLE `class_structure` ADD FOREIGN KEY (exercise_id) REFERENCES `exercise` (`id_exercise`);
ALTER TABLE `class_structure` ADD FOREIGN KEY (class_structure_id) REFERENCES `list_structure` (`id_list_structure`);
ALTER TABLE `exercise` ADD FOREIGN KEY (exercise_type_id) REFERENCES `exercise_type` (`id_exercise_type`);
ALTER TABLE `customer` ADD FOREIGN KEY (user_account_id) REFERENCES `user_account` (`id_user_account`);
ALTER TABLE `product` ADD FOREIGN KEY (pro_category_id) REFERENCES `pro_category` (`id_pro_category`);
ALTER TABLE `company_location` ADD FOREIGN KEY (company_id) REFERENCES `company` (`id_company`);
ALTER TABLE `company_location` ADD FOREIGN KEY (location_id) REFERENCES `location` (`id_location`);
ALTER TABLE `reservation` ADD FOREIGN KEY (created_by) REFERENCES `user_account` (`id_user_account`);
ALTER TABLE `reservation` ADD FOREIGN KEY (company_location_id) REFERENCES `company_location` (`id_company_location`);
ALTER TABLE `reservation` ADD FOREIGN KEY (customer_id) REFERENCES `customer` (`id_customer`);
ALTER TABLE `pro_pricing` ADD FOREIGN KEY (product_id) REFERENCES `product` (`id_product`);
ALTER TABLE `pro_discount` ADD FOREIGN KEY (product_id) REFERENCES `product` (`id_product`);
ALTER TABLE `sale` ADD FOREIGN KEY (customer_id) REFERENCES `customer` (`id_customer`);
ALTER TABLE `sale` ADD FOREIGN KEY (payment_type_id) REFERENCES `payment_type` (`id_payment_type`);
ALTER TABLE `sale` ADD FOREIGN KEY (sale_status_id) REFERENCES `sale_status` (`id_sale_status`);
ALTER TABLE `payment_data` ADD FOREIGN KEY (payment_type_id) REFERENCES `payment_type` (`id_payment_type`);
ALTER TABLE `payment_details` ADD FOREIGN KEY (sale_id) REFERENCES `sale` (`id_sale`);
ALTER TABLE `payment_details` ADD FOREIGN KEY (payment_data_id) REFERENCES `payment_data` (`id_payment_data`);
ALTER TABLE `payment_details` ADD FOREIGN KEY (received_by) REFERENCES `service_provider` (`id_service_provider`);
ALTER TABLE `pro_inventory` ADD FOREIGN KEY (product_id) REFERENCES `product` (`id_product`);
ALTER TABLE `pro_sale_item` ADD FOREIGN KEY (sale_id) REFERENCES `sale` (`id_sale`);
ALTER TABLE `pro_sale_item` ADD FOREIGN KEY (product_id) REFERENCES `product` (`id_product`);
ALTER TABLE `continuous_service` ADD FOREIGN KEY (cos_category_id) REFERENCES `cos_category` (`id_cos_category`);
ALTER TABLE `cos_pricing` ADD FOREIGN KEY (continuous_service_id) REFERENCES `continuous_service` (`id_continuous_service`);
ALTER TABLE `cos_discount` ADD FOREIGN KEY (continuous_service_id) REFERENCES `continuous_service` (`id_continuous_service`);
ALTER TABLE `cos_sale_item` ADD FOREIGN KEY (sale_id) REFERENCES `sale` (`id_sale`);
ALTER TABLE `cos_sale_item` ADD FOREIGN KEY (continuous_service_id) REFERENCES `continuous_service` (`id_continuous_service`);
ALTER TABLE `one_time_service` ADD FOREIGN KEY (ots_category_id) REFERENCES `ots_category` (`id_ots_category`);
ALTER TABLE `ots_pricing` ADD FOREIGN KEY (one_time_service_id) REFERENCES `one_time_service` (`id_one_time_service`);
ALTER TABLE `ots_discount` ADD FOREIGN KEY (one_time_service_id) REFERENCES `one_time_service` (`id_one_time_service`);
ALTER TABLE `ots_sale_item` ADD FOREIGN KEY (sale_id) REFERENCES `sale` (`id_sale`);
ALTER TABLE `ots_sale_item` ADD FOREIGN KEY (one_time_service_id) REFERENCES `one_time_service` (`id_one_time_service`);
ALTER TABLE `customer_inventory` ADD FOREIGN KEY (customer_id) REFERENCES `customer` (`id_customer`);
ALTER TABLE `customer_company` ADD FOREIGN KEY (company_location_id) REFERENCES `company_location` (`id_company_location`);
ALTER TABLE `customer_company` ADD FOREIGN KEY (customer_id) REFERENCES `customer` (`id_customer`);
ALTER TABLE `customer_company` ADD FOREIGN KEY (sale_id) REFERENCES `sale` (`id_sale`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `event` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `recurring_pattern` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `recurring_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `event_instance_exception` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `user_account` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `service_provider` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `company` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `location` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `company_employee` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `certification` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `program` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `class` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `class_structure` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `exercise` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `exercise_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `list_structure` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `customer` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `product` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `company_location` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `reservation` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `pro_pricing` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `pro_discount` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `pro_category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `sale` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `payment_type` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `payment_data` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `payment_details` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `pro_inventory` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `pro_sale_item` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `continuous_service` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cos_category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cos_pricing` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cos_discount` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `cos_sale_item` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `one_time_service` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ots_category` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ots_pricing` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ots_discount` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `ots_sale_item` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `customer_inventory` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `sale_status` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `customer_company` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `event` (`id_event`,`event_title`,`start_day`,`end_day`,`start_time`,`end_time`,`is_full_day`,`is_recurring`,`created_by`,`time_created`,`parent_event_id`,`program_id`) VALUES
-- ('','','','','','','','','','','','');
-- INSERT INTO `recurring_pattern` (`event_id`,`recurring_type_id`,`separation_count`,`max_n_occurences`,`day_of_week`,`week_of_month`,`day_of_month`,`month_of_year`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `recurring_type` (`id_recurring_type`,`recurring_type`) VALUES
-- ('','');
-- INSERT INTO `event_instance_exception` (`id_event_exception`,`event_id`,`is_rescheduled`,`is_cancelled`,`start_day`,`end_day`,`start_time`,`end_time`,`is_full_day`,`created_by`,`time_created`,`program_id`) VALUES
-- ('','','','','','','','','','','','');
-- INSERT INTO `user_account` (`id_user_account`,`username`,`email`,`first_name`,`last_name`,`location_id`,`time_created`) VALUES
-- ('','','','','','','');
-- INSERT INTO `service_provider` (`id_service_provider`,`user_account_id`) VALUES
-- ('','');
-- INSERT INTO `company` (`id_company`,`company_name`,`time_created`) VALUES
-- ('','','');
-- INSERT INTO `location` (`id_location`,`address`,`address_number`,`zipcode`,`phone`,`address_comp`) VALUES
-- ('','','','','','');
-- INSERT INTO `company_employee` (`service_provider_id`,`company_location_id`) VALUES
-- ('','');
-- INSERT INTO `certification` (`id_certification`,`service_provider_id`,`certification_name`,`provider`,`description`,`date_earned`) VALUES
-- ('','','','','','');
-- INSERT INTO `program` (`id_program`,`name`,`description`) VALUES
-- ('','','');
-- INSERT INTO `class` (`id_class`,`description`,`day`,`program_id`,`max_capacity`) VALUES
-- ('','','','','');
-- INSERT INTO `class_structure` (`class_id`,`exercise_id`,`class_structure_id`) VALUES
-- ('','','');
-- INSERT INTO `exercise` (`id_exercise`,`name`,`exercise_type_id`) VALUES
-- ('','','');
-- INSERT INTO `exercise_type` (`id_exercise_type`,`exercise_type_description`) VALUES
-- ('','');
-- INSERT INTO `list_structure` (`id_list_structure`,`structure_name`) VALUES
-- ('','');
-- INSERT INTO `customer` (`id_customer`,`user_account_id`,`tracker_id`) VALUES
-- ('','','');
-- INSERT INTO `product` (`id_product`,`pro_name`,`pro_description`,`pro_basic_unit`,`pro_active_for_sale`,`pro_category_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `company_location` (`id_company_location`,`company_id`,`location_id`) VALUES
-- ('','','');
-- INSERT INTO `reservation` (`id_reservation`,`date`,`start_time`,`end_time`,`time_created`,`created_by`,`company_location_id`,`customer_id`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `pro_pricing` (`id_pro_pricing`,`product_id`,`pro_price`,`pro_time_created`,`pro_date_expiry`,`pro_is_active`) VALUES
-- ('','','','','','');
-- INSERT INTO `pro_discount` (`id_product_discount`,`product_id`,`pro_discount_value`,`pro_time_created`,`pro_date_expiry`,`pro_coupon_code`,`pro_max_discount_amount`,`pro_max_quantity`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `pro_category` (`id_pro_category`,`pro_category`) VALUES
-- ('','');
-- INSERT INTO `sale` (`id_sale`,`customer_id`,`sale_amount`,`sale_amount_paid`,`time_created`,`time_paid`,`payment_type_id`,`sale_status_id`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `payment_type` (`id_payment_type`,`type_name`) VALUES
-- ('','');
-- INSERT INTO `payment_data` (`id_payment_data`,`payment_type_id`,`data_name`,`fee`) VALUES
-- ('','','','');
-- INSERT INTO `payment_details` (`id_payment_details`,`sale_id`,`payment_data_id`,`value`,`payment_date`,`have_received`,`received_by`) VALUES
-- ('','','','','','','');
-- INSERT INTO `pro_inventory` (`product_id`,`pro_in_stock`,`pro_last_update`) VALUES
-- ('','','');
-- INSERT INTO `pro_sale_item` (`id_product_sale_item`,`pro_quantity_sold`,`pro_price_per_unit`,`sale_id`,`product_id`) VALUES
-- ('','','','','');
-- INSERT INTO `continuous_service` (`id_continuous_service`,`cos_name`,`cos_description`,`cos_basic_unit`,`cos_active_for_sale`,`cos_category_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `cos_category` (`id_cos_category`,`cos_category`) VALUES
-- ('','');
-- INSERT INTO `cos_pricing` (`id_cos_pricing`,`continuous_service_id`,`cos_price`,`cos_time_created`,`cos_date_expiry`,`cos_is_active`) VALUES
-- ('','','','','','');
-- INSERT INTO `cos_discount` (`id_cos_discount`,`continuous_service_id`,`cos_discount_value`,`cos_time_created`,`cos_date_expiry`,`cos_coupon_code`,`cos_max_discount_amount`,`cos_max_quantity`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `cos_sale_item` (`id_cos_sale_item`,`cos_quantity_sold`,`cos_price_per_unity`,`sale_id`,`continuous_service_id`,`cos_start_time`,`cos_end_time`) VALUES
-- ('','','','','','','');
-- INSERT INTO `one_time_service` (`id_one_time_service`,`ots_name`,`ots_description`,`ots_basic_unit`,`ots_active_for_sale`,`ots_category_id`) VALUES
-- ('','','','','','');
-- INSERT INTO `ots_category` (`id_ots_category`,`ots_category`) VALUES
-- ('','');
-- INSERT INTO `ots_pricing` (`id_ots_pricing`,`one_time_service_id`,`ots_price`,`ots_time_created`,`ots_date_expiry`,`ots_is_active`) VALUES
-- ('','','','','','');
-- INSERT INTO `ots_discount` (`id_ots_discount`,`one_time_service_id`,`ots_discount_value`,`ots_time_created`,`ots_date_expiry`,`ots_coupon_code`,`ots_max_discount_amount`,`ots_max_quantity`) VALUES
-- ('','','','','','','','');
-- INSERT INTO `ots_sale_item` (`id_ots_sale_item`,`ots_quantity_sold`,`ots_price_per_unity`,`sale_id`,`one_time_service_id`,`ots_end_date`) VALUES
-- ('','','','','','');
-- INSERT INTO `customer_inventory` (`customer_id`,`one_time_service_id`,`ots_quantity`,`ots_last_update`) VALUES
-- ('','','','');
-- INSERT INTO `sale_status` (`id_sale_status`,`status_name`) VALUES
-- ('','');
-- INSERT INTO `customer_company` (`company_location_id`,`customer_id`,`sale_id`) VALUES
-- ('','','');