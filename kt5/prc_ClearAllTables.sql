DELIMITER @@

CREATE OR REPLACE PROCEDURE `prc_ClearAllTables`()
BEGIN

DELETE FROM `additionalservices`;
DELETE FROM `production_bid`;
DELETE FROM `deliveryevents`;
DELETE FROM `routelists`;
DELETE FROM `bids`;
DELETE FROM `orders`;

DELETE FROM `deliverers`;

DELETE FROM `contracts`;

DELETE FROM `clients`;
DELETE FROM `employees`;

DELETE FROM `suppliers`;
DELETE FROM `production`;

DELETE FROM `users`;

DELETE FROM `productkind`;
DELETE FROM `orderstatus`;
DELETE FROM `deliveryeventtype`;
DELETE FROM `routeliststatus`;

/* сброс автоинкремента */

ALTER TABLE `productkind` AUTO_INCREMENT = 1;
ALTER TABLE `orderstatus` AUTO_INCREMENT = 1;
ALTER TABLE `routeliststatus` AUTO_INCREMENT = 1;
ALTER TABLE `deliveryeventtype` AUTO_INCREMENT = 1;

ALTER TABLE `production` AUTO_INCREMENT = 1;
ALTER TABLE `suppliers` AUTO_INCREMENT = 1;
ALTER TABLE `contracts` AUTO_INCREMENT = 1;
ALTER TABLE `bids` AUTO_INCREMENT = 1;

ALTER TABLE `production_bid` AUTO_INCREMENT = 1;

ALTER TABLE `users` AUTO_INCREMENT = 1;
ALTER TABLE `employees` AUTO_INCREMENT = 1;
ALTER TABLE `clients` AUTO_INCREMENT = 1;

ALTER TABLE `orders` AUTO_INCREMENT = 1;
ALTER TABLE `additionalservices` AUTO_INCREMENT = 1;

END @@

DELIMITER ;
