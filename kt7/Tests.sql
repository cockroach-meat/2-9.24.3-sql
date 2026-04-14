USE optic;

DELIMITER @@

/* =========================================================
ТЕСТ 1
Краткое описание: Проверка существования продукции
Ожидаемый результат: Указанная продукция уже есть в таблице!
Статус: ПРОЙДЕН
========================================================= */

DROP PROCEDURE IF EXISTS sp_check_product_name @@
CREATE PROCEDURE sp_check_product_name(IN p_name VARCHAR(255))
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM production
    WHERE Name = p_name;

    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Указанная продукция уже есть в таблице!';
    ELSE
        SELECT 'Название уникально, можно добавлять' AS Result;
    END IF;
END @@


/* =========================================================
ТЕСТ 2
Краткое описание: Формирование номера заявки
Ожидаемый результат: ПТ/ЗВ/0000001-24
Статус: ПРОЙДЕН
========================================================= */

DROP PROCEDURE IF EXISTS sp_create_bid_number @@
CREATE PROCEDURE sp_create_bid_number(
    IN p_contract INT,
    IN p_date DATETIME,
    IN p_employee INT
)
BEGIN
    DECLARE next_id INT;
    DECLARE year_suffix VARCHAR(2);
    DECLARE bid_number VARCHAR(50);

    SELECT IFNULL(MAX(ID),0)+1 INTO next_id FROM bids;

    SET year_suffix = DATE_FORMAT(p_date,'%y');

    SET bid_number = CONCAT(
        'ПТ/ЗВ/',
        LPAD(next_id,7,'0'),
        '-',
        year_suffix
    );

    INSERT INTO bids(Contract, Date, Employee)
    VALUES(p_contract, p_date, p_employee);

    SELECT bid_number AS BidNumber;
END @@


/* =========================================================
ТЕСТ 3
Краткое описание: Проверка удаления должности
Ожидаемый результат: Удаление должности не возможно,
она привязана к сотрудникам!
Статус: ПРОЙДЕН
========================================================= */

DROP PROCEDURE IF EXISTS sp_delete_jobtitle @@
CREATE PROCEDURE sp_delete_jobtitle(IN p_jobtitle VARCHAR(255))
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM employees
    WHERE JobTitle = p_jobtitle;

    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Удаление должности не возможно, она привязана к сотрудникам!';
    ELSE
        SELECT 'Должность можно удалить' AS Result;
    END IF;
END @@


/* =========================================================
ТЕСТ 4
Краткое описание: Добавление покупателя
с проверкой уникальности данных
Ожидаемый результат:
Указанные данные не уникальные для системы!
Статус: ПРОЙДЕН
========================================================= */

DROP PROCEDURE IF EXISTS sp_add_client @@
CREATE PROCEDURE sp_add_client(
    IN p_user INT,
    IN p_pass_series INT,
    IN p_pass_number INT,
    IN p_phone VARCHAR(12),
    IN p_email VARCHAR(255)
)
BEGIN
    DECLARE cnt INT;

    SELECT COUNT(*) INTO cnt
    FROM clients
    WHERE (PassportSeries = p_pass_series
           AND PassportNumber = p_pass_number)
       OR PhoneNumber = p_phone;

    IF cnt > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Указанные данные не уникальные для системы!';
    ELSE
        INSERT INTO clients(
            User,
            PassportSeries,
            PassportNumber,
            PhoneNumber,
            Email
        )
        VALUES(
            p_user,
            p_pass_series,
            p_pass_number,
            p_phone,
            p_email
        );

        SELECT 'Клиент успешно добавлен' AS Result;
    END IF;
END @@


/* =========================================================
ТЕСТ 5
Краткое описание:
Создание маршрутного листа для заказа
Ожидаемый результат:
Указанный заказ уже закрыт.
Статус: ПРОЙДЕН
========================================================= */

DROP PROCEDURE IF EXISTS sp_create_routelist @@
CREATE PROCEDURE sp_create_routelist(
    IN p_number INT,
    IN p_send DATETIME,
    IN p_recv DATETIME,
    IN p_deliverer INT,
    IN p_transport INT,
    IN p_order INT,
    IN p_status INT
)
BEGIN
    DECLARE order_status INT;

    SELECT Status INTO order_status
    FROM orders
    WHERE ID = p_order;

    /* Предполагается что статус 3 = закрыт */
    IF order_status = 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Указанный заказ уже закрыт.';
    ELSE
        INSERT INTO routelists(
            Number,
            SendTime,
            RecvTime,
            Deliverer,
            Transport,
            `Order`,
            Status
        )
        VALUES(
            p_number,
            p_send,
            p_recv,
            p_deliverer,
            p_transport,
            p_order,
            p_status
        );

        SELECT 'Маршрутный лист создан' AS Result;
    END IF;
END @@


DELIMITER ;



/* =========================================================
ТЕСТОВЫЕ ВЫЗОВЫ
(пример демонстрации сценариев)
========================================================= */

-- Тест 1
CALL sp_check_product_name('Чехол металлический');

-- Тест 2
CALL sp_create_bid_number(3,'2024-03-01',1);

-- Тест 3
CALL sp_delete_jobtitle('Продавец-консультант');

-- Тест 4
CALL sp_add_client(1,4356,257544,'+79633680856','test@test.ru');

-- Тест 5
CALL sp_create_routelist(
    1,
    NOW(),
    NOW(),
    1,
    1,
    4,
    1
);
