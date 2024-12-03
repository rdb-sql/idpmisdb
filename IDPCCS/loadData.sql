Use [IDPCCS]
Go

Insert Into dbo.CCS_Config (Refl,Val1)
Values
('name','IDPCCS'),
('alias','Card Transaction System'),
('url','localhost:CCS'),
('api','v1/coregw/CCS'),
('serverip','192.168.120.12'),
('databaseip','192.168.120.11'),
('webserver','192.168.120.110'),
('guiVersion','9.1.0'),
('version','1.0.1'),
('log','/log/prefatch'),
('optimal9Failover','v1/opt/9/failover/log'),
('defaultFailover','192.168.110.14'),
('configRoute','/v1/coregw/config/sqlserver/log'),
('conneCCSmtp','true'),
('database','Microsoft SQL Server Enterprise'),
('port1','1030'),
('port2','1433'),
('port3','9090s'),
('allowHttps','true'),
('allowGrpc','true'),
('allowOpenApi','true');

Insert Into dbo.CCS_Parameter (Para1,Val2)
Values
('DBpatch','15 mins'),
('UIPatch','package'),
('Servicepatch','1 day'),
('SecurityPatch','5 mins'),
('ApiBatch','1 millisec'),
('ClearLog',''),
('PurgeLog',''),
('UpdateCore',''),
('AuthConnectionString','');

Insert Into dbo.CCS_CARDTYPE (CardType,TypeDesc)
Values
('Master Card','MTC'),
('Rabiit Card','RBC'),
('Optimal9 Card','O9C'),
('Neptune Card','NPC'),
('Rubick Card','RBC');

Insert Into dbo.CCS_CARDLEVEL (CardLevel,Level)
Values
('Level1','1'),
('Level2','2'),
('Level3','3'),
('Level4','4');

;with one as(
select level,CardLevel from CCS_CARDLEVEL
), two as(
select CardType,TypeDesc from CCS_CARDTYPE
)
Insert Into dbo.CCS_CARDCONFIG (Card,CardDef,CardCode,CodeDef,CardLevel,LevelDef)
select Concat(b.TypeDesc,'-',a.Level),Concat(b.CardType,' ',a.CardLevel),b.TypeDesc,b.CardType,a.Level,a.CardLevel
from one A cross join two B
Order By B.TypeDesc

Insert Into dbo.CCS_CARDLIMIT (CardType,DailyCntAmt,DailyTxnCnt)
Select Card,'100',5 From CCS_CARDCONFIG
Where CardLevel = 1
Union All
Select Card,'1000',10 From CCS_CARDCONFIG
Where CardLevel = 2
Union All
Select Card,'10000',50 From CCS_CARDCONFIG
Where CardLevel = 3
Union All
Select Card,'unlimited',100 From CCS_CARDCONFIG
Where CardLevel = 4

Insert Into dbo.CCS_TRANSACTIONLIMIT (Amount)
Values
(1),
(2),
(5),
(9.99),
(10),
(20),
(50),
(99.99),
(100),
(200),
(500),
(999.99),
(1000);

Insert Into dbo.SYS_SERVICETYPE (SvxCode,SvxDesc)
Values
('S','Small'),
('M','Mini'),
('L','Large'),
('X','Extra'),
('A','AllInOne');

DECLARE @count int = 0
WHILE @count <= 1000
BEGIN
Begin Tran;
Insert Into dbo.SYS_VENDORMACHINE (VCode,VCategory)
Values
(
ABS(CHECKSUM(NEWID())),
(Select TOP 1 SvxCode from dbo.SYS_SERVICETYPE Order By NEWID())
)
SET @count = @count + 1
Commit Tran;
END

UPDATE dbo.SYS_VENDORMACHINE
SET VName = Concat('CCS','-',VCategory,'-',Id)

Insert Into dbo.PMT_CONFIG (PaymentMethod,PaymentCode,PaymentApi,PaymentConfiguration)
Values
('QRScan','QRS','v1/coregw/CCS/qr/{paymentapi}','v1/coregw/CCS/qr/{scan}'),
('Cash','CSH',NULL,NULL),
('OnlinePayment','OLP','v1/coregw/CCS/olp/{paymentapi}','v1/coregw/CCS/olp/{scan}'),
('Coin','CON',NULL,NULL),
('BankNote','BNT','v1/coregw/CCS/bnt/{number}','v1/coregw/CCS/bnt/{scan}');

Insert Into dbo.[CCS_CONFIGCODELIST] (ConfigCode,ConfigName,ConfigValue)
Values
('S','TXNSTS','Success'),
('E','TXNSTS','Error'),
('T','TXNSTS','Timeout'),
('J','TXNSTS','Reject');