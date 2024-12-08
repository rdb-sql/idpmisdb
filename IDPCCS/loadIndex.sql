Use [IDPCCS]
Go

Select Concat('CREATE INDEX IX_',TABLE_NAME,' ON ',TABLE_NAME,' ()') From INFORMATION_SCHEMA.TABLES
Order By TABLE_NAME

CREATE INDEX IX_CCS_Calendar ON CCS_Calendar (SqnDate)
CREATE INDEX IX_CCS_CARDCONFIG ON CCS_CARDCONFIG (Card)
CREATE INDEX IX_CCS_CARDLEVEL ON CCS_CARDLEVEL (CardLevel,Level)
CREATE INDEX IX_CCS_CARDLIMIT ON CCS_CARDLIMIT (CardType)
CREATE INDEX IX_CCS_CARDTYPE ON CCS_CARDTYPE (CardType,TypeDesc)
CREATE INDEX IX_CCS_CARDUSER ON CCS_CARDUSER (UserCode,CardNumber)
CREATE INDEX IX_CCS_CONFIGCODELIST ON CCS_CONFIGCODELIST (ConfigCode)
CREATE INDEX IX_CCS_Transaction ON CCS_Transaction (TransactionNumber,CardNumber,TickerNumber,FromRoute,ToRoute)
CREATE INDEX IX_CCS_TRANSACTIONLIMIT ON CCS_TRANSACTIONLIMIT (Amount)
CREATE INDEX IX_PMT_CONFIG ON PMT_CONFIG (PaymentCode)
CREATE INDEX IX_RTE_CITY ON RTE_CITY (City)
CREATE INDEX IX_RTE_ROUTE ON RTE_ROUTE (RouteDef)
CREATE INDEX IX_SYS_SERVICETYPE ON SYS_SERVICETYPE (SvxCode,SvxDesc)
CREATE INDEX IX_SYS_VENDORMACHINE ON SYS_VENDORMACHINE (VCode,VName)