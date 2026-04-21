-- Перечень продукции
SELECT
p.`Article`,
p.`Name`,
p.`Productor`,
p.`Price`,
p.`Count`,
k.`Kind`
FROM `production` p
JOIN `productkind` k ON p.`Kind` = k.`ID`
ORDER BY k.`Kind`;

-- Сотрудники
SELECT
u.`LastName`,
u.`FirstName`,
u.`MiddleName`,
u.`Login`,
e.`JobTitle`
FROM `employees` e
JOIN `users` u ON e.`User` = u.`ID`;

-- Покупатели
SELECT
u.`LastName`,
u.`FirstName`,
u.`MiddleName`,
c.`PassportSeries`,
c.`PassportNumber`,
c.`PhoneNumber`,
c.`Email`
FROM `clients` c
JOIN `users` u ON c.`User` = u.`ID`;

-- Договоры
SELECT
s.`Name`,
s.`OKPO`,
s.`Address`,
c.`FormDate`,
c.`Till`
FROM `contracts` c
JOIN `suppliers` s ON c.`Supplier` = s.`ID`;

-- Заявки
SELECT
b.`ID` AS `Bid`,
c.`ID` AS `Contract`,
b.`Date`,
u.`Login`,
p.`Article`,
pb.`Count`
FROM `bids` b
JOIN `contracts` c ON b.`Contract` = c.`ID`
JOIN `employees` e ON b.`Employee` = e.`ID`
JOIN `users` u ON e.`User` = u.`ID`
JOIN `production_bid` pb ON pb.`Bid` = b.`ID`
JOIN `production` p ON pb.`Production` = p.`ID`
ORDER BY b.`ID`;

-- Заказы
SELECT
o.`ID`,
cl.`PhoneNumber`,
o.`Receipt`,
o.`DateTime`,
pg.`Article` AS `Glasses`,
pl.`Article` AS `Lenses`,
o.`CreationDate`,
u.`Login`,
s.`Text` AS `Status`,
o.`Check`,
o.`InputMoney`,
o.`Payback`
FROM `orders` o
JOIN `clients` cl ON o.`Client` = cl.`ID`
JOIN `employees` e ON o.`Employee` = e.`ID`
JOIN `users` u ON e.`User` = u.`ID`
JOIN `production` pg ON o.`Glasses` = pg.`ID`
JOIN `production` pl ON o.`Linzes` = pl.`ID`
JOIN `orderstatus` s ON o.`Status` = s.`ID`;

-- Дополнительные услуги
SELECT
o.`ID` AS `OrderID`,
p.`Article`,
p.`Name`
FROM `additionalservices` a
JOIN `orders` o ON a.`Order` = o.`ID`
JOIN `production` p ON a.`Product` = p.`ID`;
