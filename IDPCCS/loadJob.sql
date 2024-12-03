-- J_CCS_ADD_USR_CAD_EXEC
Use [IDPCCS]
Go

DECLARE @count int = 0
WHILE @count <= ROUND(RAND()*1000,0)
BEGIN
Begin Tran;
Insert Into dbo.CCS_CARDUSER (UserCode,CardNumber,CardType)
Values
(
NEWID(),
ABS(CHECKSUM(NEWID())),
(Select TOP 1 Card From CCS_CARDCONFIG Order By NEWID())
)
SET @count = @count + 1
Commit Tran;
END

-- J_CCS_CFG_TXN_EXEC
Use [IDPCCS]
Go

DECLARE @count int = 0
WHILE @count <= ROUND(RAND()*1000,0)
BEGIN
Begin Tran;
Insert Into dbo.CCS_Transaction (FromRoute,ToRoute,ServiceProvider,PaymentType,Amount,CardNumber,TransactionStatus)
Values
(
(Select Top 1 RouteDef From dbo.RTE_ROUTE Order By NEWID()),
(Select Top 1 RouteDef From dbo.RTE_ROUTE Order By NEWID()),
(Select Top 1 VName From dbo.SYS_VENDORMACHINE Order By NEWID()),
(Select Top 1 PaymentCode From dbo.PMT_CONFIG Order By NEWID()),
(Select Top 1 Amount From dbo.CCS_TRANSACTIONLIMIT Order By NEWID()),
(Select Top 1 CardNumber From dbo.CCS_CARDUSER Order By NEWID()),
(Select Top 1 ConfigCode From dbo.CCS_CONFIGCODELIST WHERE ConfigName = 'TXNSTS' Order By NEWID())
)
SET @count = @count + 1
Commit Tran;

-- check ticket status
Begin Tran;
Update dbo.CCS_Transaction
Set TicketStatus = 0
Where ExpiredDate <= GETDATE()
And TransactionStatus = 'S'
Commit Tran;

-- check ticket status

Begin Tran;
Update dbo.CCS_Transaction
Set TicketStatus = 0
Where TransactionStatus In  ('E','T','J')
And TicketStatus =  1
Commit Tran;
END
