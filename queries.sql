-------------------------------------------------------------------------------------------------
-- Запрос 1
-- Извлечение из базы данных информации по неработающим торговым автоматам на 1 декабря 2024 года,
-- а также контактов ответственных лиц
-------------------------------------------------------------------------------------------------
WITH minfo AS
( SELECT cmid, opid, cs, ad
    FROM
    ( SELECT v.MachineId AS cmid, s.CurrentStatus AS cs
        FROM VendingMachine v JOIN
        Status s
        ON v.MachineId = s.MachineId
        WHERE s.DateTime = '2024-12-01 17:00:00'
    ) JOIN
    (SELECT v.MachineId AS amid, v.OperatorId as opid, a.Address AS ad
       FROM VendingMachine v JOIN
       Area a
       ON v.LocationId = a.LocationId
    )
    ON cmid = amid
    WHERE ( cs = 'Нет сигнала' ) OR ( cs = 'Не исправен' ) OR ( cs =  'Недостаточно расходных материалов'  )
),

opc AS
( SELECT o.OperatorId AS oid, o.FullName AS of, l.PhoneNumber AS phn
    FROM Operator o JOIN
    LabourContract l
    ON o.ContractNo = l.ContractNo
)

SELECT o.of AS operator, o.phn AS phonenumber, m.cmid AS machineid, m.cs AS status, m.ad  AS address
FROM minfo m JOIN
opc o
ON m.opid = o.oid;

-------------------------------------------------------------------------------
-- Запрос 2
-- Количество торговых автоматов, которые обслуживает каждый оператор
-------------------------------------------------------------------------------
WITH macnum AS
( SELECT v.OperatorId AS oid, COUNT ( v.MachineId ) AS ct
    FROM VendingMachine v
    GROUP BY v.OperatorId
    ORDER BY v.OperatorId ASC
)

SELECT o.FullName AS Name, m.ct AS ServicedMachines
FROM operator o JOIN
macnum m
ON o.OperatorId = m.oid;

-------------------------------------------------------------------------------
-- Запрос 3
-- Контрагенты, договор с которыми заканчивается в 2024 году
-------------------------------------------------------------------------------
SELECT l.OrganizationName, o.DateFinish
  FROM Landlord l JOIN 
  ( SELECT LandlordId, DateFinish
      FROM LeaseAgreement
      WHERE EXTRACT ( YEAR FROM DateFinish) = 2024
  ) o
ON l.LandlordId = o.LandlordId;
