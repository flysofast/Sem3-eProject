USE [master]
GO
/****** Object:  Database [AirlineReservationSystem]    Script Date: 12/10/2016 8:34:47 AM ******/
CREATE DATABASE [AirlineReservationSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AirlineReservationSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AirlineReservationSystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AirlineReservationSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AirlineReservationSystem_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AirlineReservationSystem] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AirlineReservationSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AirlineReservationSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [AirlineReservationSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AirlineReservationSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AirlineReservationSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AirlineReservationSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AirlineReservationSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AirlineReservationSystem] SET  MULTI_USER 
GO
ALTER DATABASE [AirlineReservationSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AirlineReservationSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AirlineReservationSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AirlineReservationSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [AirlineReservationSystem]
GO
/****** Object:  Table [dbo].[City]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[City](
	[CityID] [varchar](3) NOT NULL,
	[CityName] [nvarchar](50) NULL,
	[InService] [bit] NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Class]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Flight]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Flight](
	[FlightNo] [varchar](10) NOT NULL,
	[CurrentPrice] [decimal](18, 2) NOT NULL,
	[DepartureTime] [datetime] NOT NULL,
	[RouteID] [int] NOT NULL,
	[Duration] [float] NOT NULL,
 CONSTRAINT [PK_Flight] PRIMARY KEY CLUSTERED 
(
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Route]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Route](
	[RouteID] [int] IDENTITY(1,1) NOT NULL,
	[OriginalCityID] [varchar](3) NOT NULL,
	[DestinationCityID] [varchar](3) NOT NULL,
	[Distance] [int] NOT NULL,
	[InService] [bit] NOT NULL,
 CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Seat](
	[ClassID] [int] NULL,
	[SeatID] [varchar](4) NOT NULL,
 CONSTRAINT [PK_Seat] PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TakenSeat]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TakenSeat](
	[SeatID] [varchar](4) NOT NULL,
	[FlightNo] [varchar](10) NOT NULL,
	[TicketNo] [int] NOT NULL,
 CONSTRAINT [PK_TakenSeat] PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC,
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketNo] [int] NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[ConfirmationNo] [varchar](10) NULL,
	[BlockNo] [varchar](10) NULL,
	[CancellationNo] [varchar](10) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[NumberOfAdults] [int] NULL,
	[NumberOfChildren] [int] NULL,
	[NumberOfSeniorCitizens] [int] NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Ticket] PRIMARY KEY CLUSTERED 
(
	[TicketNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ticket_Flight]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ticket_Flight](
	[TicketNo] [int] NOT NULL,
	[FlightNo] [varchar](10) NOT NULL,
	[SequenceNo] [int] NOT NULL,
	[IsReturn] [bit] NOT NULL,
 CONSTRAINT [PK_Ticket_Flight] PRIMARY KEY CLUSTERED 
(
	[TicketNo] ASC,
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 12/10/2016 8:34:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[PhoneNumber] [varchar](10) NOT NULL,
	[Sex] [bit] NOT NULL,
	[CreditcardNumber] [varchar](20) NULL,
	[DateOfBirth] [date] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'BST', N'Boston', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'CTD', N'Cần Thơ', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'DND', N'Đà Nẵng', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HNN', N'Hà Nội', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HUI', N'Huế', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'NYK', N'New York', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGN', N'Hồ Chí Minh', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGP', N'Singapore', 1)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0001', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69900057E40 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0002', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A699000F1B30 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0003', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69901090B90 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0004', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69900C46170 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0005', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6990107AC00 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0006', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6990130DEE0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0007', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A699017C66D0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0008', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69900FB4FF0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0009', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69900000000 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0010', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69900149970 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0011', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69901365D20 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0012', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69900510630 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0013', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A699006F3C90 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0014', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6990044AA20 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0015', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69900F9F060 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0016', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69900C88020 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0017', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69901140810 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0018', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69900E297D0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0019', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A699002673C0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0020', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6990083D600 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0021', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69A001A17B0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0022', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69A014418C0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0023', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69A018344A0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0024', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69A00384E10 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0025', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69A004E4710 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0026', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69A0020F580 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0027', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69A0069BE50 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0028', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69A0057E400 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0029', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69A00970FE0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0030', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69A0062E080 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0031', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69A00C46170 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0032', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69A01090B90 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0033', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69A01876350 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0034', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69A01624F20 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0035', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69A00CDFE60 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0036', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69A00AA49C0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0037', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69A01391C40 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0038', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69A00000000 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0039', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69A003F2BE0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0040', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69A0069BE50 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0041', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69B018603C0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0042', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69B00BEE330 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0043', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69B018344A0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0044', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69B00A62B10 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0045', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69B00DBBA00 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0046', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69B001B7740 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0047', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69B006180F0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0048', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69B00175890 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0049', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69B0069BE50 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0050', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69B005AA320 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0051', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69B006DDD00 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0052', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69B000F1B30 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0053', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69B0062E080 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0054', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69B012F7F50 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0055', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69B00895440 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0056', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69B00384E10 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0057', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69B00F73140 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0058', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69B00B54640 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0059', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69B0104ECE0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0060', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69B00970FE0 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0061', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69C01140810 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0062', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69C0095B050 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0063', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69C0130DEE0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0064', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69C000C5C10 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0065', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69C015074D0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0066', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69C018603C0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0067', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69C0032CFD0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0068', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69C004A2860 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0069', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69C003DCC50 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0070', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69C015F9000 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0071', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69C0104ECE0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0072', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69C0128A180 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0073', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69C01692CF0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0074', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69C00BAC480 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0075', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69C004B87F0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0076', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69C00AE6870 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0077', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69C00099CF0 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0078', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69C004609B0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0079', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69C002932E0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0080', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69C00B80560 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0081', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D01365D20 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0082', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D00BAC480 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0083', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69D014AF690 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0084', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69D013A7BD0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0085', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69D0142B930 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0086', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69D00510630 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0087', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D006DDD00 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0088', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69D000DBBA0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0089', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69D013FFA10 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0090', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D0112A880 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0091', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69D00AA49C0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0092', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69D01549380 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0093', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69D0112A880 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0094', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69D007B98A0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0095', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D0044AA20 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0096', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69D00AA49C0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0097', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D009191A0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0098', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D00761A60 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0099', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69D005D6240 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0100', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69D00AE6870 AS DateTime), 18, 0.88888888888888884)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0101', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69E00869520 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0102', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69E015F9000 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0103', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E000F1B30 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0104', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69E006B1DE0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0105', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E0116C730 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0106', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69E011567A0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0107', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69E0036EE80 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0108', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69E00057E40 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0109', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E00015F90 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0110', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E005C02B0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0111', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69E00A78AA0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0112', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69E00827670 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0113', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E00149970 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0114', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69E015074D0 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0115', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69E00F890D0 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0116', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69E005C02B0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0117', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69E009C8E20 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0118', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69E0087F4B0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0119', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E015F9000 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0120', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69E0104ECE0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0121', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69F00D21D10 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0122', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69F01876350 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0123', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69F0057E400 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0124', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F0121C3B0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0125', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F014DB5B0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0126', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69F010D2A40 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0127', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F00A0ACD0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0128', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69F01666DD0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0129', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F00225510 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0130', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69F013FFA10 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0131', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69F00DBBA00 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0132', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69F00EC34C0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0133', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69F001A17B0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0134', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69F0020F580 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0135', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F006C7D70 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0136', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F008C1360 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0137', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F00761A60 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0138', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69F00E975A0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0139', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F011148F0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0140', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69F00709C20 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0141', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A0008AB3D0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0142', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A00095B050 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0143', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A00023B4A0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0144', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A0006C7D70 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0145', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A0017F25F0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0146', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A0006C7D70 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0147', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A0003C6CC0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0148', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A001716A50 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0149', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A001064C70 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0150', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A0008116E0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0151', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A0012482D0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0152', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A000D0BD80 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0153', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000709C20 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0154', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A0011AE5E0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0155', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A000000000 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0156', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A0006C7D70 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0157', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000895440 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0158', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A0012A0110 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0159', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000476940 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0160', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A00134FD90 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0161', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A1000C5C10 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0162', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1005AA320 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0163', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A101716A50 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0164', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A10041EB00 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0165', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A100FE0F10 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0166', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A100827670 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0167', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A100FCAF80 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0168', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A1006180F0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0169', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A101483770 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0170', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A100EC34C0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0171', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A100FF6EA0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0172', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A1008ED280 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0173', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A10176E890 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0174', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1012CC030 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0175', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A100853590 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0176', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A10032CFD0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0177', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A1011567A0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0178', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A100C72090 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0179', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A10134FD90 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0180', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A1015074D0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0181', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A2002673C0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0182', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A2005AA320 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0183', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A2010BCAB0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0184', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A200057E40 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0185', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A201784820 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0186', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A200709C20 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0187', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A2002A9270 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0188', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A2000F1B30 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0189', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A2015B7150 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0190', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A20121C3B0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0191', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A200F73140 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0192', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A2015333F0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0193', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A2017C66D0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0194', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A20160EF90 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0195', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A201742970 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0196', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A2007B98A0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0197', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A20069BE50 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0198', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A201876350 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0199', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A2013A7BD0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0200', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A2010D2A40 AS DateTime), 6, 0.66666666666666663)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0201', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A3003010B0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0202', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A3014F1540 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0203', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A3012A0110 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0204', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A300358EF0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0205', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A30044AA20 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0206', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A300000000 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0207', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A301742970 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0208', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A300384E10 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0209', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A3018603C0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0210', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A300D63BC0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0211', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A300B964F0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0212', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A3006F3C90 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0213', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A30011DA50 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0214', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A3004A2860 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0215', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A300015F90 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0216', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A3002D5190 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0217', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A300F31290 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0218', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A3004E4710 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0219', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A301483770 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0220', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A30104ECE0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0221', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A40002BF20 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0222', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A4011148F0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0223', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A4001E3660 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0224', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A40116C730 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0225', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A4018603C0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0226', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A400225510 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0227', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A40167CD60 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0228', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A40116C730 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0229', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A400C9DFB0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0230', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A40006DDD0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0231', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A400175890 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0232', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A400E81610 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0233', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A400A8EA30 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0234', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A4005265C0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0235', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A4004FA6A0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0236', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A40002BF20 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0237', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A40112A880 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0238', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A4002D5190 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0239', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A4013E9A80 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0240', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A4012B60A0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0241', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A500B54640 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0242', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A500DFD8B0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0243', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A5011DA500 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0244', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A501323E70 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0245', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A501758900 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0246', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A50181E510 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0247', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5009B2E90 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0248', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A500C9DFB0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0249', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5000F1B30 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0250', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5006F3C90 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0251', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A5001B7740 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0252', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A5002BF200 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0253', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A500AE6870 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0254', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A50087F4B0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0255', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A500C301E0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0256', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5017C66D0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0257', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A5003DCC50 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0258', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A50036EE80 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0259', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A5006180F0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0260', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5010FE960 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0261', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A6015074D0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0262', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A601339E00 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0263', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A601140810 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0264', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A6014159A0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0265', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A601391C40 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0266', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A60083D600 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0267', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A6011826C0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0268', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A600D79B50 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0269', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A60179A7B0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0270', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A600C301E0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0271', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A6006DDD00 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0272', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A600EEF3E0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0273', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A6005D6240 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0274', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A600041EB0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0275', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A6004609B0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0276', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A600041EB0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0277', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A600C301E0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0278', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A600827670 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0279', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A6014DB5B0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0280', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A600E297D0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0281', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7010A6B20 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0282', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A70039ADA0 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0283', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7012B60A0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0284', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A70095B050 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0285', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7005D6240 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0286', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A700BAC480 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0287', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A701365D20 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0288', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A7017B0740 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0289', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A701692CF0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0290', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A700F31290 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0291', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A700BEE330 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0292', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A700AA49C0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0293', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A7009450C0 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0294', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A700986F70 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0295', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A70128A180 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0296', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A700D79B50 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0297', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7013E9A80 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0298', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A700D21D10 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0299', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7004CE780 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0300', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7016D4BA0 AS DateTime), 8, 0.88888888888888884)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0301', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A80002BF20 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0302', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A800827670 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0303', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A800C1A250 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0304', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A800E6B680 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0305', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A800057E40 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0306', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A800B80560 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0307', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A800685EC0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0308', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A800D21D10 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0309', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A800A36BF0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0310', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A8016EAB30 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0311', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A801716A50 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0312', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A80057E400 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0313', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A8010E89D0 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0314', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A80062E080 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0315', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A8016D4BA0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0316', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A800BC2410 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0317', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A8007E57C0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0318', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A8006C7D70 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0319', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A8010FE960 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0320', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A8001E3660 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0321', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A900EEF3E0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0322', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A90121C3B0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0323', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A900E297D0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0324', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A900D21D10 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0325', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A90128A180 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0326', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A900DFD8B0 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0327', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A9001F95F0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0328', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A900BEE330 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0329', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A9004CE780 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0330', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A901624F20 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0331', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A90121C3B0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0332', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A9004B87F0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0333', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A9013BDB60 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0334', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A9011567A0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0335', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A900A0ACD0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0336', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A9010E89D0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0337', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A900E81610 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0338', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A90137BCB0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0339', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A900C72090 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0340', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A9018344A0 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0341', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AA014418C0 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0342', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA003DCC50 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0343', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA005C02B0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0344', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0134FD90 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0345', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00057E40 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0346', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0128A180 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0347', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00FE0F10 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0348', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00358EF0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0349', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0179A7B0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0350', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00F05370 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0351', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00F31290 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0352', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00F47220 AS DateTime), 4, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0353', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00A8EA30 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0354', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AA013FFA10 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0355', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA008116E0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0356', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00D21D10 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0357', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA01758900 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0358', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00057E40 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0359', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AA01339E00 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0360', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AA013BDB60 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0361', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00BEE330 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0362', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB013BDB60 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0363', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB011F0490 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0364', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB013E9A80 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0365', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0176E890 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0366', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AB007FB750 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0367', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB002673C0 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0368', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB001B7740 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0369', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00AE6870 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0370', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00F31290 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0371', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0142B930 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0372', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00149970 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0373', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB01716A50 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0374', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00A0ACD0 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0375', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0011DA50 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0376', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0062E080 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0377', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0006DDD0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0378', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB01758900 AS DateTime), 16, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0379', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB011F0490 AS DateTime), 18, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0380', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00057E40 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0381', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00A62B10 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0382', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0092F130 AS DateTime), 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0383', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01365D20 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0384', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00476940 AS DateTime), 5, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0385', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01339E00 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0386', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0158B230 AS DateTime), 10, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0387', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00D8FAE0 AS DateTime), 8, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0388', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0184A430 AS DateTime), 6, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0389', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AC008116E0 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0390', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0057E400 AS DateTime), 17, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0391', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01692CF0 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0392', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC003010B0 AS DateTime), 14, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0393', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0112A880 AS DateTime), 2, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0394', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00FE0F10 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0395', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0188C2E0 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0396', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00C72090 AS DateTime), 1, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0397', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AC004FA6A0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0398', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC008AB3D0 AS DateTime), 3, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0399', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0006DDD0 AS DateTime), 7, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [Duration]) VALUES (N'AR0400', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC005265C0 AS DateTime), 2, 2.2222222222222223)
GO
SET IDENTITY_INSERT [dbo].[Route] ON 

INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (1, N'SGN', N'HUI', 1000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (2, N'SGN', N'HNN', 2000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (3, N'SGN', N'DND', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (4, N'SGN', N'CTD', 300, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (5, N'SGN', N'NYK', 17000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (6, N'HNN', N'HUI', 600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (7, N'HNN', N'CTD', 1600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (8, N'HNN', N'DND', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (9, N'HUI', N'DND', 200, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (10, N'HUI', N'HNN', 600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (11, N'HNN', N'SGP', 2500, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (13, N'HNN', N'NYK', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (14, N'SGN', N'BST', 18000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (15, N'SGN', N'SGP', 2500, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (16, N'HNN', N'SGN', 2000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (17, N'HUI', N'SGN', 1200, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (18, N'HUI', N'CTD', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (19, N'HNN', N'BST', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (20, N'HUI', N'BST', 17500, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (21, N'HUI', N'NYK', 17000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (23, N'HUI', N'SGP', 2600, 0)
SET IDENTITY_INSERT [dbo].[Route] OFF
ALTER TABLE [dbo].[Ticket] ADD  CONSTRAINT [DF_Ticket_NumberOfPassengers]  DEFAULT ((1)) FOR [NumberOfAdults]
GO
ALTER TABLE [dbo].[Ticket_Flight] ADD  CONSTRAINT [DF_Ticket_Flight_SequenceNo]  DEFAULT ((1)) FOR [SequenceNo]
GO
ALTER TABLE [dbo].[Ticket_Flight] ADD  CONSTRAINT [DF_Ticket_Flight_IsReturn]  DEFAULT ((0)) FOR [IsReturn]
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD  CONSTRAINT [FK_Flight_Route] FOREIGN KEY([RouteID])
REFERENCES [dbo].[Route] ([RouteID])
GO
ALTER TABLE [dbo].[Flight] CHECK CONSTRAINT [FK_Flight_Route]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_City] FOREIGN KEY([OriginalCityID])
REFERENCES [dbo].[City] ([CityID])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_City]
GO
ALTER TABLE [dbo].[Route]  WITH CHECK ADD  CONSTRAINT [FK_Route_City1] FOREIGN KEY([DestinationCityID])
REFERENCES [dbo].[City] ([CityID])
GO
ALTER TABLE [dbo].[Route] CHECK CONSTRAINT [FK_Route_City1]
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD  CONSTRAINT [FK_Seat_Class] FOREIGN KEY([ClassID])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Seat] CHECK CONSTRAINT [FK_Seat_Class]
GO
ALTER TABLE [dbo].[TakenSeat]  WITH CHECK ADD  CONSTRAINT [FK_TakenSeat_Flight] FOREIGN KEY([FlightNo])
REFERENCES [dbo].[Flight] ([FlightNo])
GO
ALTER TABLE [dbo].[TakenSeat] CHECK CONSTRAINT [FK_TakenSeat_Flight]
GO
ALTER TABLE [dbo].[TakenSeat]  WITH CHECK ADD  CONSTRAINT [FK_TakenSeat_Seat] FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seat] ([SeatID])
GO
ALTER TABLE [dbo].[TakenSeat] CHECK CONSTRAINT [FK_TakenSeat_Seat]
GO
ALTER TABLE [dbo].[TakenSeat]  WITH CHECK ADD  CONSTRAINT [FK_TakenSeat_Ticket] FOREIGN KEY([TicketNo])
REFERENCES [dbo].[Ticket] ([TicketNo])
GO
ALTER TABLE [dbo].[TakenSeat] CHECK CONSTRAINT [FK_TakenSeat_Ticket]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_User]
GO
ALTER TABLE [dbo].[Ticket_Flight]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Flight_Flight] FOREIGN KEY([FlightNo])
REFERENCES [dbo].[Flight] ([FlightNo])
GO
ALTER TABLE [dbo].[Ticket_Flight] CHECK CONSTRAINT [FK_Ticket_Flight_Flight]
GO
ALTER TABLE [dbo].[Ticket_Flight]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Flight_Ticket] FOREIGN KEY([TicketNo])
REFERENCES [dbo].[Ticket] ([TicketNo])
GO
ALTER TABLE [dbo].[Ticket_Flight] CHECK CONSTRAINT [FK_Ticket_Flight_Ticket]
GO
USE [master]
GO
ALTER DATABASE [AirlineReservationSystem] SET  READ_WRITE 
GO
