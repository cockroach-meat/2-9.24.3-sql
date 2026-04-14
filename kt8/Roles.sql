USE optic;

GRANT ALL PRIVILEGES
ON optic.*
TO 'admin'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_check_product_name
TO 'admin'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_bid_number
TO 'admin'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_delete_jobtitle
TO 'admin'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_add_client
TO 'admin'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_routelist
TO 'admin'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.RouteListStatus
TO 'supply_manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.DeliveryEventType
TO 'supply_manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.Deliverers
TO 'supply_manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.Transports
TO 'supply_manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.RouteLists
TO 'supply_manager'@'localhost';

GRANT SELECT, INSERT, UPDATE
ON optic.DeliveryEvents
TO 'supply_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_check_product_name
TO 'supply_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_bid_number
TO 'supply_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_delete_jobtitle
TO 'supply_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_add_client
TO 'supply_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_routelist
TO 'supply_manager'@'localhost';

GRANT SELECT
ON optic.RouteListStatus
TO 'sales_manager'@'localhost';

GRANT SELECT
ON optic.DeliveryEventType
TO 'sales_manager'@'localhost';

GRANT SELECT
ON optic.Deliverers
TO 'sales_manager'@'localhost';

GRANT SELECT
ON optic.Transports
TO 'sales_manager'@'localhost';

GRANT SELECT
ON optic.RouteLists
TO 'sales_manager'@'localhost';

GRANT SELECT
ON optic.DeliveryEvents
TO 'sales_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_check_product_name
TO 'sales_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_bid_number
TO 'sales_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_delete_jobtitle
TO 'sales_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_add_client
TO 'sales_manager'@'localhost';

GRANT EXECUTE
ON PROCEDURE optic.sp_create_routelist
TO 'sales_manager'@'localhost';

FLUSH PRIVILEGES;
