-------------------------------------------------------------------------------
-- Предварительное удаление существующих таблиц
-------------------------------------------------------------------------------
DROP TABLE IF EXISTS LabourContract CASCADE;
DROP TABLE IF EXISTS Operator CASCADE;
DROP TABLE IF EXISTS Landlord CASCADE;
DROP TABLE IF EXISTS LeaseAgreement CASCADE;
DROP TABLE IF EXISTS Area CASCADE;
DROP TABLE IF EXISTS VendingMachine CASCADE;
DROP TABLE IF EXISTS Status CASCADE;

-------------------------------------------------------------------------------
-- Создание и заполнение таблиц
-------------------------------------------------------------------------------
-- Таблица 1. LabourContract
-------------------------------------------------------------------------------
CREATE TABLE LabourContract (
  ContractNo varchar( 8 ) NOT NULL,
  Salary numeric NOT NULL,
  DateStart date NOT NULL,
  DateFinish date,
  PhoneNumber varchar( 12 ),
  PRIMARY KEY ( ContractNo )
);

INSERT INTO LabourContract VALUES ('LC000001', 25000, '2013-01-01', '2025-01-01', '+72018592492');
INSERT INTO LabourContract VALUES ('LC000002', 16500, '2015-01-01', '2026-01-01', '+73403595462');
INSERT INTO LabourContract VALUES ('LC000003', 12450, '2011-02-01', '2020-02-01', '+75666592492');
INSERT INTO LabourContract VALUES ('LC000004', 16500, '2021-01-01', '2027-01-01', '+72014503922');
INSERT INTO LabourContract VALUES ('LC000005', 15650, '2010-05-01', '2024-05-01', '+72018456564');
INSERT INTO LabourContract VALUES ('LC000006', 16500, '2012-09-01', '2023-09-01', '+79054585493');
INSERT INTO LabourContract VALUES ('LC000007', 16500, '2014-10-01', '2025-10-01', '+73043958599');

-------------------------------------------------------------------------------
-- Таблица 2. Operator
-------------------------------------------------------------------------------
CREATE TABLE Operator (
  OperatorId varchar( 4 ) NOT NULL,
  FullName text NOT NULL,
  Gender varchar( 7 ) NOT NULL,
  BirthDate date NOT NULL,
  ContractNo varchar( 8 ) NOT NULL,
  PRIMARY KEY( OperatorId ),
  CHECK ( Gender IN ('мужской', 'женский') ),
  FOREIGN KEY ( ContractNo )
    REFERENCES LabourContract ( ContractNo )
);

INSERT INTO Operator VALUES ('O001', 'Афанасьева Татьяна Юрьевна', 'женский', '2000-03-01', 'LC000001');
INSERT INTO Operator VALUES ('O002', 'Бурлакова Ирина Геннадьевна', 'женский', '1993-06-11', 'LC000002');
INSERT INTO Operator VALUES ('O003', 'Алексеев Дмитрий Александрович', 'мужской', '2001-05-21', 'LC000003');
INSERT INTO Operator VALUES ('O004', 'Константинов Александр Сергеевич', 'мужской', '1999-11-20', 'LC000004');
INSERT INTO Operator VALUES ('O005', 'Малов Виталий Петрович', 'мужской', '1995-08-03', 'LC000005');
INSERT INTO Operator VALUES ('O006', 'Костров Виктор Денисович', 'мужской', '2002-12-09', 'LC000006');
INSERT INTO Operator VALUES ('O007', 'Василенко Татьяна Игоревна', 'женский', '1996-11-02', 'LC000007');

-------------------------------------------------------------------------------
-- Таблица 3. Landlord
-------------------------------------------------------------------------------
CREATE TABLE Landlord (
  LandlordId varchar ( 4 ) NOT NULL,
  TaxpayerNumber varchar ( 12 ) NOT NULL,
  OrganizationName text NOT NULL,
  OrganizationType varchar ( 40 ) NOT NULL,
  LegalAddress text NOT NULL,
  PRIMARY KEY ( LandlordId ),
  CHECK ( OrganizationType IN ('Индивидуальный предприниматель', 'Общество с ограниченной ответственностью',
                               'Акционерное общество', 'Публичное акционерное общество', 'Другой') )
);

INSERT INTO Landlord VALUES ('OW01', '789649439101', 'БИЗНЕС ЗОУН', 'Общество с ограниченной ответственностью', 'Каширское ш., 14, Москва, 115230');
INSERT INTO Landlord VALUES ('OW02', '239340639354', 'Петровский Алексей Александрович', 'Индивидуальный предприниматель', 'просп. Андропова, 44, Москва, 115487');
INSERT INTO Landlord VALUES ('OW03', '127880666000', 'ПАБЛИК СПЭЙС', 'Акционерное общество', 'просп. Вернадского, 1, Москва, 359342');
INSERT INTO Landlord VALUES ('OW04', '770840639108', 'Коммерческая недвижимость', 'Публичное акционерное общество', 'ул. Зеленая, 12, Москва, 439202');
INSERT INTO Landlord VALUES ('OW05', '999040639456', 'Производственное объединение Весна', 'Другой', 'ул. Мельникова, 29, Москва, 135998');

-------------------------------------------------------------------------------
-- Таблица 4. LeaseAgreement
-------------------------------------------------------------------------------
CREATE TABLE LeaseAgreement (
  AgreementNo varchar ( 8 ) NOT NULL,
  DateStart date NOT NULL,
  DateFinish date,
  MonthCost numeric,
  LandlordId varchar( 4 ) NOT NULL,  
  PRIMARY KEY ( AgreementNo ),
  FOREIGN KEY (	 LandlordId )
    REFERENCES Landlord ( LandlordId )
);

INSERT INTO LeaseAgreement VALUES ('LE000001',  '2013-01-01', '2025-01-29', 10000, 'OW01');
INSERT INTO LeaseAgreement VALUES ('LE000002', '2015-01-01', '2026-01-01', 12000, 'OW02');
INSERT INTO LeaseAgreement VALUES ('LE000003', '2011-02-01', '2020-02-01', 13500, 'OW02');
INSERT INTO LeaseAgreement VALUES ('LE000004', '2021-01-01', '2027-01-01', 9000, 'OW02');
INSERT INTO LeaseAgreement VALUES ('LE000005', '2010-05-01', '2025-01-05', 12000, 'OW03');
INSERT INTO LeaseAgreement VALUES ('LE000006', '2012-09-01', '2025-01-29', 11000, 'OW04');
INSERT INTO LeaseAgreement VALUES ('LE000007', '2014-10-01', '2025-10-01', 13000, 'OW05');
INSERT INTO LeaseAgreement VALUES ('LE000008', '2016-11-01', '2024-12-31', 8500, 'OW05');
INSERT INTO LeaseAgreement VALUES ('LE000009', '2019-02-01', '2029-02-01', 7900, 'OW05');
INSERT INTO LeaseAgreement VALUES ('LE000010', '2017-07-01', '2027-07-01', 6450, 'OW05');

-------------------------------------------------------------------------------
-- Таблица 5. Area
-------------------------------------------------------------------------------
CREATE TABLE Area (
  LocationId varchar( 5 ) NOT NULL,
  Address text NOT NULL,
  AgreementNo varchar( 8 ) NOT NULL,
  AreaSize real NOT NULL,
  PRIMARY KEY ( LocationId ),
  FOREIGN KEY ( AgreementNo )
    REFERENCES LeaseAgreement ( AgreementNo )
);

INSERT INTO Area VALUES ('A0001', 'Каширское ш., 14, Москва, 115230', 'LE000001', 1.00);
INSERT INTO Area VALUES ('A0002', 'просп. Андропова, 39, Москва, 115487', 'LE000002', 1.25);
INSERT INTO Area VALUES ('A0003', 'пр. Вернадского, 6, Москва, 119311', 'LE000003', 1.00);
INSERT INTO Area VALUES ('A0004', 'ул. Василисы Кожиной, 1, Москва, 121096', 'LE000004', 1.00);
INSERT INTO Area VALUES ('A0005', 'Пресненская наб., 10, Москва, 123317', 'LE000005', 1.5);
INSERT INTO Area VALUES ('A0006', 'Большая Переяславская ул., 15, Москва, 129110', 'LE000006', 2.00);
INSERT INTO Area VALUES ('A0007', 'ул, 3-я Мытищинская ул., 16A, Москва, 129226', 'LE000007', 1.00);
INSERT INTO Area VALUES ('A0008', 'пр-т Мира, 175, Москва, 129226', 'LE000008', 1.00);
INSERT INTO Area VALUES ('A0009', 'МКАД 87 км, 8, Москва, 127543','LE000009',  1.75);
INSERT INTO Area VALUES ('A0010', 'ул. Новосущевская, 22 строение 2, Москва, 127055', 'LE000010', 1.10);

-------------------------------------------------------------------------------
-- Таблица 6. VendingMachine
-------------------------------------------------------------------------------
CREATE TABLE VendingMachine (
  MachineId varchar ( 6 ) NOT NULL,
  Type varchar ( 22 ) NOT NULL,
  LocationId varchar ( 5 ) NOT NULL,
  OperatorId varchar ( 4 ) NOT NULL,
  PRIMARY KEY ( MachineId ),
  FOREIGN KEY ( LocationId )
    REFERENCES Area ( LocationId ),
  FOREIGN KEY ( OperatorId )
    REFERENCES Operator ( OperatorId ),
  CHECK (Type IN ('Кофе', 'Бутилированные напитки',
        'Снеки', 'Жевательная резинка', 'Мяч-прыгун',
        'Вода', 'Игрушки', 'Бахилы', 'Незамерзающая жидкость' ) )
);

INSERT INTO VendingMachine VALUES ('M00001', 'Игрушки', 'A0001', 'O001');
INSERT INTO VendingMachine VALUES ('M00002', 'Жевательная резинка', 'A0001', 'O001');
INSERT INTO VendingMachine VALUES ('M00003', 'Мяч-прыгун', 'A0001', 'O001');
INSERT INTO VendingMachine VALUES ('M00004', 'Кофе', 'A0002', 'O002');
INSERT INTO VendingMachine VALUES ('M00005', 'Снеки', 'A0003', 'O002');
INSERT INTO VendingMachine VALUES ('M00006', 'Бутилированные напитки', 'A0003', 'O002');
INSERT INTO VendingMachine VALUES ('M00007', 'Кофе', 'A0004', 'O003');
INSERT INTO VendingMachine VALUES ('M00008', 'Незамерзающая жидкость', 'A0005', 'O004');
INSERT INTO VendingMachine VALUES ('M00009', 'Вода', 'A0006', 'O005');
INSERT INTO VendingMachine VALUES ('M00010', 'Бахилы', 'A0007', 'O006');
INSERT INTO VendingMachine VALUES ('M00011', 'Вода', 'A0008', 'O005');
INSERT INTO VendingMachine VALUES ('M00012', 'Кофе', 'A0009', 'O007');
INSERT INTO VendingMachine VALUES ('M00013', 'Мяч-прыгун', 'A0009', 'O007');
INSERT INTO VendingMachine VALUES ('M00014', 'Бахилы', 'A0010', 'O006');
INSERT INTO VendingMachine VALUES ('M00015', 'Игрушки', 'A0010', 'O001');

-------------------------------------------------------------------------------
-- Таблица 7. Status
-------------------------------------------------------------------------------
CREATE TABLE Status (
  MachineId varchar ( 6 ) NOT NULL,
  DateTime timestamp NOT NULL,
  CurrentStatus varchar ( 33 ) NOT NULL,
  PRIMARY KEY ( MachineId, DateTime ),
  FOREIGN KEY ( MachineId )
    REFERENCES VendingMachine ( MachineId ),
  CHECK (CurrentStatus IN ('Исправен', 'Недостаточно расходных материалов',
        'Не исправен', 'Нет сигнала' ) )
);

INSERT INTO Status VALUES ('M00001', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00001', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00001', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00001', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00001', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00001', '2024-12-01 17:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00001', '2024-12-01 18:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00001', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00002', '2024-12-01 12:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00002', '2024-12-01 13:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00002', '2024-12-01 14:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00002', '2024-12-01 15:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00002', '2024-12-01 16:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00002', '2024-12-01 17:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00002', '2024-12-01 18:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00002', '2024-12-01 19:00:00', 'Нет сигнала');

INSERT INTO Status VALUES ('M00003', '2024-12-01 12:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00003', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00003', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00003', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00003', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00003', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00003', '2024-12-01 18:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00003', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00004', '2024-12-01 12:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00004', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00004', '2024-12-01 14:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00004', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00004', '2024-12-01 16:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00004', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00004', '2024-12-01 18:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00004', '2024-12-01 19:00:00', 'Не исправен');

INSERT INTO Status VALUES ('M00005', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00005', '2024-12-01 18:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00005', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00006', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00006', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00006', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00006', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00006', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00006', '2024-12-01 17:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00006', '2024-12-01 18:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00006', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00007', '2024-12-01 12:00:00', 'Не исправен');
INSERT INTO Status  VALUES ('M00007', '2024-12-01 13:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00007', '2024-12-01 14:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00007', '2024-12-01 15:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00007', '2024-12-01 16:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00007', '2024-12-01 17:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00007', '2024-12-01 18:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00007', '2024-12-01 19:00:00', 'Нет сигнала');

INSERT INTO Status VALUES ('M00008', '2024-12-01 12:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 13:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 14:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 15:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 16:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 17:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 18:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00008', '2024-12-01 19:00:00', 'Нет сигнала');

INSERT INTO Status VALUES ('M00009', '2024-12-01 12:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00009', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00009', '2024-12-01 14:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00009', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00009', '2024-12-01 16:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00009', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00009', '2024-12-01 18:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00009', '2024-12-01 19:00:00', 'Не исправен');

INSERT INTO Status VALUES ('M00010', '2024-12-01 12:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00010', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 17:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 18:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00010', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00011', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00011', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00011', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00011', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00011', '2024-12-01 16:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00011', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00011', '2024-12-01 18:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00011', '2024-12-01 19:00:00', 'Недостаточно расходных материалов');

INSERT INTO Status VALUES ('M00012', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 17:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 18:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00012', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00013', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 17:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 18:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00013', '2024-12-01 19:00:00', 'Исправен');

INSERT INTO Status VALUES ('M00014', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 15:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 16:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00014', '2024-12-01 18:00:00', 'Не исправен');
INSERT INTO Status VALUES ('M00014', '2024-12-01 19:00:00', 'Не исправен');

INSERT INTO Status VALUES ('M00015', '2024-12-01 12:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00015', '2024-12-01 13:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00015', '2024-12-01 14:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00015', '2024-12-01 15:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00015', '2024-12-01 16:00:00', 'Нет сигнала');
INSERT INTO Status VALUES ('M00015', '2024-12-01 17:00:00', 'Недостаточно расходных материалов');
INSERT INTO Status VALUES ('M00015', '2024-12-01 18:00:00', 'Исправен');
INSERT INTO Status VALUES ('M00015', '2024-12-01 19:00:00', 'Нет сигнала');
