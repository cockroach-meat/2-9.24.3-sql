CREATE DATABASE IF NOT EXISTS KT3;
USE KT3;

DELIMITER @@

DROP PROCEDURE IF EXISTS AddReference@@

CREATE PROCEDURE AddReference(IN childTableName VARCHAR(255), IN childColumnName VARCHAR(255), IN parentTableName VARCHAR(255), IN parentColumnName VARCHAR(255))
BEGIN
    DECLARE fkName VARCHAR(510);
    DECLARE statement TEXT;
    DECLARE fkExists BOOLEAN;

    SET fkName = CONCAT('fk_ref_', childTableName, '_', parentTableName);

    SET fkExists = (
        SELECT COUNT(1)
        FROM information_schema.TABLE_CONSTRAINTS
        WHERE CONSTRAINT_SCHEMA = DATABASE()
          AND CONSTRAINT_NAME = fkName
          AND CONSTRAINT_TYPE = 'FOREIGN KEY'
          AND TABLE_NAME = childTableName
    );

    IF fkExists = 0 THEN
        SET @statement = CONCAT(
            'ALTER TABLE ', childTableName,
            ' ADD CONSTRAINT ', fkName,
            ' FOREIGN KEY (`', childColumnName, '`)',
            ' REFERENCES ', parentTableName,
            ' (`', parentColumnName, '`)'
        );

        PREPARE stmt FROM @statement;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END@@

DROP PROCEDURE IF EXISTS CreateTables@@

CREATE PROCEDURE CreateTables()
BEGIN
    CREATE TABLE IF NOT EXISTS Production (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Productor       VARCHAR(255) NOT NULL,
        `Count`         INT NOT NULL,
        Price           INT NOT NULL,
        Article         VARCHAR(255) NOT NULL,
        Description     VARCHAR(255) NOT NULL,
        Kind            INT NOT NULL,
        Name            VARCHAR(255) NOT NULL,
        GlassType       VARCHAR(255) NOT NULL,
        Properties      VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS OrderStatus (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        `Text`          VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Orders (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Client          INT NOT NULL,
        Receipt         VARCHAR(255) NOT NULL,
        `DateTime`      DATETIME NOT NULL,
        Glasses         INT NOT NULL,
        Linzes          INT NOT NULL,
        CreationDate    DATETIME NOT NULL,
        Employee        INT NOT NULL,
        Status          INT NOT NULL,
        `Check`         VARCHAR(255) NOT NULL,
        PaymentType     INT NOT NULL,
        InputMoney      DECIMAL(8,2) NOT NULL,
        Payback         DECIMAL(8,2) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Suppliers (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Name            VARCHAR(255) NOT NULL,
        OKPO            VARCHAR(255) NOT NULL,
        Address         VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Contracts (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        FormDate        DATETIME NOT NULL,
        Till            DATETIME NOT NULL,
        Supplier        INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Bids (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Contract        INT NOT NULL,
        `Date`          DATETIME NOT NULL,
        Employee        INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS AdditionalServices (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        `Order`         INT NOT NULL,
        Product         INT NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Employees (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        `User`          INT NOT NULL,
        JobTitle        VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS ProductKind (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Kind            VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Clients (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        `User`          INT NOT NULL,
        PassportSeries  INT NOT NULL,
        PassportNumber  INT NOT NULL,
        PhoneNumber     VARCHAR(12) NOT NULL,
        Email           VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Users (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Login           VARCHAR(255) NOT NULL,
        Password        VARCHAR(255) NOT NULL,
        FirstName       VARCHAR(255) NOT NULL,
        LastName        VARCHAR(255) NOT NULL,
        MiddleName      VARCHAR(255) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Production_Bid (
        ID              INT PRIMARY KEY AUTO_INCREMENT,
        Production      INT NOT NULL,
        Bid             INT NOT NULL,
        `Count`         INT NOT NULL
    );

    CALL AddReference('Orders', 'Client', 'Clients', 'ID');
    CALL AddReference('Orders', 'Glasses', 'Production', 'ID');
    CALL AddReference('Orders', 'Linzes', 'Production', 'ID');
    CALL AddReference('Orders', 'Employee', 'Employees', 'ID');
    CALL AddReference('Orders', 'Status', 'OrderStatus', 'ID');

    CALL AddReference('Contracts', 'Supplier', 'Suppliers', 'ID');
    
    CALL AddReference('Bids', 'Contract', 'Contracts', 'ID');
    CALL AddReference('Bids', 'Employee', 'Employees', 'ID');

    CALL AddReference('Employees', 'User', 'Users', 'ID');

    CALL AddReference('Clients', 'User', 'Users', 'ID');

    CALL AddReference('AdditionalServices', 'Order', 'Orders', 'ID');
    CALL AddReference('AdditionalServices', 'Product', 'Production', 'ID');

    CALL AddReference('Production_Bid', 'Production', 'Production', 'ID');
    CALL AddReference('Production_Bid', 'Bid', 'Bids', 'ID');

    CALL AddReference('Production', 'Kind', 'ProductKind', 'ID');
END@@

DROP PROCEDURE IF EXISTS RecreateTables@@

CREATE PROCEDURE RecreateTables()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE table_name VARCHAR(64);
    DECLARE cur CURSOR FOR SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = DATABASE();
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    REPEAT
        FETCH cur INTO table_name;
        IF NOT done THEN
            SET @sql = CONCAT('SELECT "', table_name, '"');
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
        END IF;
    UNTIL done END REPEAT;

    CLOSE cur;
END@@

DELIMITER ;
