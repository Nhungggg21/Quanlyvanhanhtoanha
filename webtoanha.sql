CREATE TABLE `apartment` (
  `ApartmentID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Area` int(11) DEFAULT NULL,
  `NumberOffBedroom` int(11) DEFAULT NULL,
  `Code` varchar(255) DEFAULT NULL,
  `ElectricId` int(11) DEFAULT NULL,
  `WaterId` int(11) NOT NULL,
  `Description` text DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `BuildingId` int(11) NOT NULL,
  `FloorId` int(11) NOT NULL,
  `ContractCode` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



CREATE TABLE `debtstatements` (
  `InvoiceCode` varchar(50) NOT NULL,
  `InvoicePeriod` varchar(50) DEFAULT NULL,
  `DueDate` date DEFAULT NULL,
  `OutstandingDebt` int(11) DEFAULT NULL,
  `Discount` int(11) DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `PaidAmount` int(11) DEFAULT NULL,
  `RemainingBalance` int(11) DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `ApartmentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `debtstatementdetail` (
    `InvoiceCode` varchar(50) NOT NULL,
    `ServiceCode` varchar(50) NOT NULL,
    `Quantity` int(11) DEFAULT 0,
    `UnitPrice` int(11) DEFAULT 0,
    `Discount` int(11) DEFAULT 0,
    `PaidAmount` int(11) DEFAULT 0,
    `RemainingBalance` int(11) DEFAULT 0,
    `IssueDate` date,
    PRIMARY KEY (`InvoiceCode`, `ServiceCode`),
    FOREIGN KEY (`InvoiceCode`) REFERENCES `debtstatements`(`InvoiceCode`) ON DELETE CASCADE,
    FOREIGN KEY (`ServiceCode`) REFERENCES `services`(`ServiceCode`) ON DELETE CASCADE
);




CREATE TABLE `departments` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Code` varchar(50) UNIQUE NOT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `DepartmentManagerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;



CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `PaymentType` varchar(50) DEFAULT NULL,
  `IssueDate` date DEFAULT NULL,
  `AccountingDate` date DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `ResidentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `receipts` (
  `ReceiptID` int(11) NOT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  `TransactionType` varchar(50) DEFAULT NULL,
  `ReceiptType` varchar(50) DEFAULT NULL,
  `Total` int(11) DEFAULT NULL,
  `AmountDue` int(11) DEFAULT NULL,
  `Payer` varchar(255) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `AccountingDate` date DEFAULT NULL,
  `Content` text DEFAULT NULL,
  `ResidentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unico----------------------------------


CREATE TABLE `resident` (
  `ID` int(11) NOT NULL,
  `NationalId` varchar(50) DEFAULT NULL,
  `Dob` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE ResidentApartment (
    ResidentId INT NOT NULL,
    ApartmentId INT NOT NULL,
    Relationship VARCHAR(100),
    PRIMARY KEY (ResidentId, ApartmentId),
    FOREIGN KEY (ResidentId) REFERENCES Resident(ID) ON DELETE CASCADE,
    FOREIGN KEY (ApartmentId) REFERENCES Apartment(ApartmentID) ON DELETE CASCADE
);


CREATE TABLE Companies (
    CompanyId INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Name VARCHAR(255) NOT NULL
);


CREATE TABLE TownShips (
    TownShipId INT PRIMARY KEY AUTO_INCREMENT,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Name VARCHAR(255) NOT NULL,
    CompanyId INT NOT NULL,
    FOREIGN KEY (CompanyId) REFERENCES Companies(CompanyId) ON DELETE CASCADE
);


CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address TEXT NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(255),
    Deadlock DATE,
    Description TEXT,
    OperationId VARCHAR(50),
    TownShipId INT NOT NULL,
    ManagerId INT NOT NULL,
    Status VARCHAR(50) DEFAULT 'active',
    FOREIGN KEY (TownShipId) REFERENCES TownShips(TownShipId) ON DELETE CASCADE,
    FOREIGN KEY (ManagerId) REFERENCES Staffs(ID) ON DELETE SET NULL
)

CREATE TABLE PaymentInformation (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    AccountName VARCHAR(255) NOT NULL,
    AccountNumber VARCHAR(50) NOT NULL,
    Bank VARCHAR(255) NOT NULL,
    Branch VARCHAR(255),
    ProjectId INT NOT NULL,
    AutoTransaction TINYINT(1) DEFAULT 0,
    AutoReconciliation TINYINT(1) DEFAULT 0,
    FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);

CREATE TABLE Buildings (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Code VARCHAR(50) UNIQUE NOT NULL,
    Status VARCHAR(50) DEFAULT 'active',
    ProjectId INT NOT NULL,
    FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);

CREATE TABLE Floors (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Code VARCHAR(50) UNIQUE NOT NULL,
    BuildingId INT NOT NULL,
    FOREIGN KEY (BuildingId) REFERENCES Buildings(ID) ON DELETE CASCADE
);


CREATE TABLE `staffs` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Position` varchar(100) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `NationalID` varchar(50) DEFAULT NULL,
  `Status` varchar(50) DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE StaffProjects (
    ProjectId INT NOT NULL,
    StaffId INT NOT NULL,
    PRIMARY KEY (ProjectId, StaffId),
    FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY (StaffId) REFERENCES Staffs(ID) ON DELETE CASCADE
);


CREATE TABLE `users` (
  `UserId` int(11) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `PhoneNumber` varchar(20) DEFAULT NULL,
  `Position` varchar(255) DEFAULT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `ResidentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `services` (
  `ServiceCode` varchar(50) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Description` text DEFAULT NULL,
  `Status` varchar(50) DEFAULT 'active',
  `Cycle` int(11) DEFAULT NULL,
  `Paydate` date DEFAULT NULL,
  `FirstDate` date DEFAULT NULL,
  `ApplyForm` date DEFAULT NULL,
  `SwitchDay` int(11) DEFAULT NULL,
  `TypeOfObject` varchar(100) DEFAULT NULL,
  `TypeOfService` varchar(100) DEFAULT NULL,
  `StartPrice` varchar(100) DEFAULT NULL,
  `CancelPrice` varchar(100) DEFAULT NULL,
  `ProjectId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE ServicePrice (
    ServiceId VARCHAR(50) NOT NULL,
    PriceId INT NOT NULL,
    PRIMARY KEY (ServiceId, PriceId),
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceCode) ON DELETE CASCADE,
    FOREIGN KEY (PriceId) REFERENCES PriceList(ID) ON DELETE CASCADE
);



CREATE TABLE `pricelist` (
  `ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `Price` int(11) NOT NULL,
  `TypeOfFee` varchar(100) DEFAULT NULL,
  `ApplyDate` date DEFAULT NULL,
  `Status` enum('active','inactive') DEFAULT 'active',
  `PriceCalculation` varchar(100) DEFAULT NULL,
  `Title` varchar(255) DEFAULT NULL,
  `PriceFrom` int(11) DEFAULT NULL,
  `PriceTo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE `vehiclecards` (
  `VehicleCardCode` varchar(50) NOT NULL,
  `Status` varchar(50) DEFAULT 'Chưa cấp phát',
  `Note` text DEFAULT NULL,
  `VehicleType` varchar(100) DEFAULT NULL,
  `NumberPlate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `vehicles` (
  `VehicleCode` varchar(50) NOT NULL,
  `TypeVehicle` varchar(100) DEFAULT NULL,
  `VehicleName` varchar(255) DEFAULT NULL,
  `NumberPlate` varchar(50) DEFAULT NULL,
  `Color` varchar(50) DEFAULT NULL,
  `Brand` varchar(100) DEFAULT NULL,
  `VehicleIdentificationNumber` varchar(100) DEFAULT NULL,
  `EngineNumber` varchar(100) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `VehicleCardCode` varchar(50) DEFAULT 
  `VehicleOwnerID` int(11) DEFAULT NULL
  `ApartmentID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE ServiceVehicles (
    ServiceId VARCHAR(50) NOT NULL,
    VehicleCode VARCHAR(50) NOT NULL,
    ApplyFeeDate DATE,
    EndFeeDate DATE,
    PRIMARY KEY (ServiceId, VehicleCode),
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceCode) ON DELETE CASCADE,
    FOREIGN KEY (VehicleCode) REFERENCES Vehicles(VehicleCode) ON DELETE CASCADE
);

CREATE TABLE Contracts (
    ContractCode VARCHAR(50) PRIMARY KEY,
    Status VARCHAR(50) DEFAULT 'active',
    CretionDate DATE,
    File TEXT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    EndDate DATE
);

CREATE TABLE ContractServices (
    ContractCode VARCHAR(50) NOT NULL,
    ServiceId VARCHAR(50) NOT NULL,
    ApplyDate DATE,
    EndDate DATE,
    PRIMARY KEY (ContractCode, ServiceId),
    FOREIGN KEY (ContractCode) REFERENCES Contracts(ContractCode) ON DELETE CASCADE,
    FOREIGN KEY (ServiceId) REFERENCES Services(ServiceCode) ON DELETE CASCADE
);

CREATE TABLE ContractAppendixs (
    ContractAppendixId INT AUTO_INCREMENT PRIMARY KEY,
    Status VARCHAR(50) DEFAULT 'active',
    CretionDate DATE,
    ContractCode VARCHAR(50),
    FOREIGN KEY (ContractCode) REFERENCES Contracts(ContractCode) ON DELETE CASCADE
);

CREATE TABLE `WaterMeterReading` (
  `WaterMeterID` int(11) NOT NULL AUTO_INCREMENT,
  `InitialReading` float DEFAULT NULL,
  `FinalReading` float DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `ClosingDate` date DEFAULT NULL,
  `Consumption` float DEFAULT NULL,
  `ApartmentID` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  PRIMARY KEY (`WaterMeterID`),
  FOREIGN KEY (`ApartmentID`) REFERENCES `apartment`(`ApartmentID`) ON DELETE CASCADE,
  FOREIGN KEY (`StaffID`) REFERENCES `staffs`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `ElectricityMeterReading` (
  `ElectricityMeterID` int(11) NOT NULL AUTO_INCREMENT,
  `InitialReading` float DEFAULT NULL,
  `FinalReading` float DEFAULT NULL,
  `Image` varchar(255) DEFAULT NULL,
  `ClosingDate` date DEFAULT NULL,
  `Consumption` float DEFAULT NULL,
  `ApartmentID` int(11) NOT NULL,
  `StaffID` int(11) NOT NULL,
  PRIMARY KEY (`ElectricityMeterID`),
  FOREIGN KEY (`ApartmentID`) REFERENCES `apartment`(`ApartmentID`) ON DELETE CASCADE,
  FOREIGN KEY (`StaffID`) REFERENCES `staffs`(`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

