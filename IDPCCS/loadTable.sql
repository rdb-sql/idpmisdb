Use [IDPCCS]
Go

Create Table [CCS_Config](
	[Id] [int] identity(1,1) NOT NULL,
	[Refl] [nvarchar] (50) NULL,
	[Val1] [nvarchar] (100) NULL,
	[Ref2] [nvarchar] (50) default('-') NULL,
	[Val2] [nvarchar] (100) default('-') NULL,
	[Ref3] [nvarchar] (50) default('-') NULL,
	[Val3] [nvarchar] (100) default('-') NULL,
	[Ref4] [nvarchar] (50) default('-') NULL,
	[Val4] [nvarchar] (100) default('-') NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_Parameter](
	[Id] [int] identity(1,1) NOT NULL,
	[Para1] [nvarchar] (50) NULL,
	[Val1] [bit] default (1) NULL,
	[Val2] [nvarchar] (20) default('-') NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CARDTYPE](
	[Id] [int] identity(1,1) NOT NULL,
	[CardType] [nvarchar] (20) NULL,
	[TypeDesc] [nvarchar] (3) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CARDLEVEL](
	[Id] [int] identity(1,1) NOT NULL,
	[CardLevel] [nvarchar] (20) NULL,
	[Level] [nvarchar] (1) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CARDCONFIG](
	[Id] [int] identity(1,1) NOT NULL,
	[Card] [nvarchar] (5) NULL,
	[CardDef] [nvarchar] (30) NULL,
	[CardCode] [nvarchar] (3) NULL,
	[CodeDef] [nvarchar] (20) NULL,
	[CardLevel] [nvarchar] (1) NULL,
	[LevelDef] [nvarchar] (10) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CARDLIMIT](
	[Id] [int] identity(1,1) NOT NULL,
	[CardType] [nvarchar] (5) NULL,
	[DailyCntAmt] [nvarchar] (10) NULL,
	[DailyTxnCnt] [int] NULL,
	[AllowBothDebitCredit] [bit] default (1) NULL,
	[AllowDebitPosting] [bit] default (1) NULL,
	[AllowCreditPosting] [bit] default (1) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_TRANSACTIONLIMIT](
	[Id] [int] identity(1,1) NOT NULL,
	[Amount] [decimal] (10,2) NULL,
	[DefaultCCY] [nvarchar] (3) default ('THB') NULL,
	[PrimaryCCY] [nvarchar] (3) default ('USD') NULL,
	[SecondaryCCY] [nvarchar] (3) default ('SGD') NULL,
	[AllowCreditPosting] [bit] default (1) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);


Create Table [dbo].[RTE_CITY](
	[Id] [int] identity(1,1) NOT NULL,
	[City] [nvarchar] (100)  NULL,
	[CityAlias] [nvarchar] (100) NULL,
	[Country] [nvarchar] (50) NULL,
	[ISO2] [nvarchar] (3)  NULL,
	[ISO3] [nvarchar] (3) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [dbo].[RTE_ROUTE](
	[Id] [int] identity(1,1) NOT NULL,
	[City] [nvarchar] (100)  NULL,
	[RouteDef] [nvarchar] (15) NULL,
	[Country] [nvarchar] (50) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [dbo].[SYS_SERVICETYPE](
	[Id] [int] identity(1,1) NOT NULL,
	[SvxCode] [nvarchar] (1)  NULL,
	[SvxDesc] [nvarchar] (15) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [dbo].[SYS_VENDORMACHINE](
	[Id] [int] identity(1,1) NOT NULL,
	[VCode] [nvarchar] (10)  NULL,
	[VName] [nvarchar] (30) NULL,
	[VCategory] [nvarchar] (1) NULL,
	[AllowQRScan] [bit] default (1),
	[AllowCash] [bit] default (1),
	[AllowOnlinePayment] [bit] default (1),
	[AllowCoin] [bit] default (1),
	[AllowBankNote] [bit] default (1),
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [PMT_CONFIG](
	[Id] [int] identity(1,1) NOT NULL,
	[PaymentMethod] [nvarchar] (30)  NULL,
	[PaymentCode] [nvarchar] (10) NULL,
	[PaymentApi] [nvarchar] (100) NULL,
	[PaymentConfiguration] [nvarchar] (100),
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CARDUSER](
	[Id] [int] identity(1,1) NOT NULL,
	[UserCode] [nvarchar] (50)  NULL,
	[CardNumber] [nvarchar] (30) NULL,
	[CardType] [nvarchar] (10) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_CONFIGCODELIST](
	[Id] [int] identity(1,1) NOT NULL,
	[ConfigCode] [nvarchar] (3)  NULL,
	[ConfigValue] [nvarchar] (10) NULL,
	[ConfigName] [nvarchar] (20) NULL,
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);

Create Table [CCS_Transaction](
	[Id] [int] identity(1,1) NOT NULL,
	[TransactionNumber] [nvarchar] (30) default (Concat(YEAR(GETDATE()),MONTH(GETDATE()),DAY(GETDATE()),ABS(CHECKSUM(NEWID())))),
	[ReferenceNumber] [nvarchar] (50) default (NEWID()),
	[FromRoute] [nvarchar] (20) NULL,
	[ToRoute] [nvarchar] (20) NULL,
	[ServiceProvider] [nvarchar] (20) NULL,
	[PaymentType] [nvarchar] (3) NULL,
	[Amount] [decimal] (10,2) NULL,
	[CardNumber] [nvarchar] (30) NULL,
	[UserCreated] [nvarchar] (10) default ('admin'),
	[ValueDate] [datetime]  default (GETDATE()),
	[ExpiredDate] [datetime] default(DATEADD(DAY,1,GETDATE())),
	[TickerNumber] [nvarchar] (50) default (ABS(CHECKSUM(NEWID()))),
	[TicketStatus] [bit] default (1),
	[TransactionStatus] [nvarchar] (1),
	[CreatedAt] [datetime] default(GETDATE()),
	[UpdatedAt] [datetime] default(GETDATE())
);







































