USE optic;

CREATE TABLE IF NOT EXISTS RouteListStatus (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Status VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS DeliveryEventType (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Deliverers (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Employee INT NOT NULL,
    PhoneNumber VARCHAR(12) NOT NULL,

    CONSTRAINT fk_Deliverers_Employee FOREIGN KEY (Employee) REFERENCES Employees(ID)
);

CREATE TABLE IF NOT EXISTS Transports (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Mark VARCHAR(255) NOT NULL,
    Number VARCHAR(12) NOT NULL,
    Color VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS RouteLists (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Number INT NOT NULL,
    FormDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    SendTime DATETIME NOT NULL,
    RecvTime DATETIME NOT NULL,
    Deliverer INT NOT NULL,
    Transport INT NOT NULL,
    `Order` INT NOT NULL,
    Status INT NOT NULL,

    CONSTRAINT fk_RouteLists_Deliverer FOREIGN KEY (Deliverer) REFERENCES Deliverers(ID),
    CONSTRAINT fk_RouteLists_Transport FOREIGN KEY (Transport) REFERENCES Transports(ID),
    CONSTRAINT fk_RouteLists_Order FOREIGN KEY (`Order`) REFERENCES Orders(ID),
    CONSTRAINT fk_RouteLists_Status FOREIGN KEY (Status) REFERENCES RouteListStatus(ID)
);

CREATE TABLE IF NOT EXISTS DeliveryEvents (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    RouteList INT NOT NULL,
    Type INT NOT NULL,
    Time DATETIME DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_DeliveryEvents_RouteList FOREIGN KEY (RouteList) REFERENCES RouteLists(ID),
    CONSTRAINT fk_DeliveryEvents_Type FOREIGN KEY (Type) REFERENCES DeliveryEventType(ID)
);
