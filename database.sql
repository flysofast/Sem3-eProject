USE [master]
GO
/****** Object:  Database [AirlineReservationSystem]    Script Date: 16/10/2016 1:21:28 PM ******/
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
/****** Object:  Table [dbo].[City]    Script Date: 16/10/2016 1:21:29 PM ******/
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
/****** Object:  Table [dbo].[Class]    Script Date: 16/10/2016 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [nvarchar](25) NOT NULL,
	[ClassName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Flight]    Script Date: 16/10/2016 1:21:29 PM ******/
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
	[CancellationFee] [float] NOT NULL,
	[Duration] [float] NOT NULL,
 CONSTRAINT [PK_Flight] PRIMARY KEY CLUSTERED 
(
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Route]    Script Date: 16/10/2016 1:21:29 PM ******/
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
/****** Object:  Table [dbo].[Seat]    Script Date: 16/10/2016 1:21:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Seat](
	[SeatID] [varchar](4) NOT NULL,
	[Class] [nvarchar](25) NULL,
 CONSTRAINT [PK_Seat] PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TakenSeat]    Script Date: 16/10/2016 1:21:29 PM ******/
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
/****** Object:  Table [dbo].[Ticket]    Script Date: 16/10/2016 1:21:29 PM ******/
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
/****** Object:  Table [dbo].[Ticket_Flight]    Script Date: 16/10/2016 1:21:29 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 16/10/2016 1:21:29 PM ******/
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
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'CTD', N'Cần Thơ', 0)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'DND', N'Đà Nẵng', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HNN', N'Hà Nội', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HUI', N'Huế', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'NYK', N'New York', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGN', N'Hồ Chí Minh', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGP', N'Singapore', 1)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0001', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69E00F9F060 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0002', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69E00895440 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0003', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69E00FE0F10 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0004', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E005C02B0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0005', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A69E005265C0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0006', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A69E00D63BC0 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0007', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69E0015F900 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0008', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E003C6CC0 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0009', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69E00358EF0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0010', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A69E00015F90 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0011', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69E01666DD0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0012', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E00659FA0 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0013', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69E011148F0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0014', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E003F2BE0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0015', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E00AE6870 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0016', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69E005265C0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0017', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69E0015F900 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0018', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69E012741F0 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0019', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69E0151D460 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0020', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69E014C5620 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0021', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A69F0121C3B0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0022', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69F015F9000 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0023', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69F0071FBB0 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0024', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69F009191A0 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0025', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A69F002EB120 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0026', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69F00F1B300 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0027', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A69F004FA6A0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0028', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A69F0092F130 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0029', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69F011AE5E0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0030', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69F00895440 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0031', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A69F003DCC50 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0032', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F010D2A40 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0033', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A69F00FF6EA0 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0034', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F006180F0 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0035', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A69F005D6240 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0036', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F01323E70 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0037', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69F017DC660 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0038', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A69F008D72F0 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0039', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A69F015F9000 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0040', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A69F01090B90 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0041', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A0003010B0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0042', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000342F60 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0043', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A00006DDD0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0044', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A000408B70 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0045', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A001692CF0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0046', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A000225510 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0047', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000510630 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0048', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A000FCAF80 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0049', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A001666DD0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0050', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A0002D5190 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0051', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A001064C70 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0052', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A00011DA50 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0053', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A000C5C100 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0054', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A0009F4D40 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0055', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000F31290 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0056', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A000FE0F10 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0057', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A000903210 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0058', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A0008AB3D0 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0059', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A000ED9450 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0060', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A000A8EA30 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0061', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A10179A7B0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0062', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A100BD83A0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0063', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1012482D0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0064', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1018344A0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0065', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A101457850 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0066', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A100A4CB80 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0067', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A1014C5620 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0068', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A100C042C0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0069', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1012CC030 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0070', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A100594390 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0071', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A10095B050 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0072', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A10006DDD0 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0073', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A100B6A5D0 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0074', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A10071FBB0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0075', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A1013E9A80 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0076', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A1004A2860 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0077', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A1016D4BA0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0078', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A100083D60 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0079', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A100384E10 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0080', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A101232340 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0081', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A200CC9ED0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0082', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A2005AA320 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0083', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A2006F3C90 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0084', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A200B3E6B0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0085', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A2006B1DE0 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0086', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A201022DC0 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0087', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A201206420 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0088', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A2012CC030 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0089', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A200685EC0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0090', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A201365D20 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0091', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A200F31290 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0092', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A2000AFC80 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0093', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A2006C7D70 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0094', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A2012741F0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0095', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A2009C8E20 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0096', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A200C042C0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0097', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A2011F0490 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0098', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A20158B230 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0099', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A200E297D0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0100', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A2003010B0 AS DateTime), 5, 15, 18.888888888888889)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0101', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6A301716A50 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0102', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A3007FB750 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0103', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A300B964F0 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0104', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A3015F9000 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0105', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A300C5C100 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0106', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A3015F9000 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0107', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A3001CD6D0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0108', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A300D63BC0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0109', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A3005EC1D0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0110', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A30069BE50 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0111', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A30044AA20 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0112', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A301038D50 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0113', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A3015A11C0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0114', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A3000F1B30 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0115', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A3003DCC50 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0116', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A3011DA500 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0117', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A300BEE330 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0118', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A300B54640 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0119', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A300CB3F40 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0120', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A300C72090 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0121', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A400970FE0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0122', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A401549380 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0123', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A400B28720 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0124', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A4005265C0 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0125', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A400000000 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0126', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A40048C8D0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0127', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A40069BE50 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0128', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A401457850 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0129', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A400D0BD80 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0130', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A400B6A5D0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0131', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A401808580 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0132', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A40121C3B0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0133', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A4010BCAB0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0134', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A4014DB5B0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0135', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A4012CC030 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0136', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A400384E10 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0137', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A40087F4B0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0138', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A400568470 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0139', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A400EEF3E0 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0140', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A401808580 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0141', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A5003010B0 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0142', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A5011AE5E0 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0143', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A50066FF30 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0144', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A50018B820 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0145', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A5002673C0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0146', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A5016A8C80 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0147', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A500476940 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0148', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A500225510 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0149', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A500D21D10 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0150', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A50095B050 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0151', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5008ED280 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0152', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A5004E4710 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0153', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A501391C40 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0154', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A501784820 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0155', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A500FB4FF0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0156', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A5012A0110 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0157', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A5009DEDB0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0158', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A50176E890 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0159', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A500F73140 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0160', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A5014C5620 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0161', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A600F47220 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0162', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A6006DDD00 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0163', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A600602160 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0164', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A6015B7150 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0165', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A600A8EA30 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0166', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A600384E10 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0167', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A6001CD6D0 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0168', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A60071FBB0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0169', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A600EC34C0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0170', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A6018344A0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0171', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A600B3E6B0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0172', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A600DBBA00 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0173', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A601808580 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0174', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A60172C9E0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0175', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A60048C8D0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0176', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A600CC9ED0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0177', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A600AD08E0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0178', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A6001CD6D0 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0179', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6A6014DB5B0 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0180', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A60112A880 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0181', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7015CD0E0 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0182', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A70160EF90 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0183', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7002EB120 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0184', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A700D79B50 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0185', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A70053C550 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0186', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7009450C0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0187', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7016A8C80 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0188', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A7009C8E20 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0189', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A700476940 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0190', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A700AFC800 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0191', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A700149970 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0192', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A70062E080 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0193', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6A7014DB5B0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0194', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A700895440 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0195', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6A700F47220 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0196', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A700D21D10 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0197', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A70069BE50 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0198', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A7009F4D40 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0199', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A7008AB3D0 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0200', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A7009F4D40 AS DateTime), 2, 15, 2.2222222222222223)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0201', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A8018603C0 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0202', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A801624F20 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0203', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A80092F130 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0204', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A80151D460 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0205', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A800CF5DF0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0206', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A800903210 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0207', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A800DFD8B0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0208', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A800B80560 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0209', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A801323E70 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0210', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A8001F95F0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0211', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A800FE0F10 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0212', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A801808580 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0213', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6A800AFC800 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0214', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6A800E81610 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0215', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A800FCAF80 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0216', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A800C301E0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0217', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A8018A2270 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0218', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A8001E3660 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0219', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6A800BD83A0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0220', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A8016BEC10 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0221', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6A900568470 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0222', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A900B80560 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0223', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6A9005AA320 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0224', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A90179A7B0 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0225', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A9006180F0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0226', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A901140810 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0227', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A90066FF30 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0228', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A900A62B10 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0229', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A901624F20 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0230', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A900BD83A0 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0231', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6A900594390 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0232', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A900DBBA00 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0233', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6A9015B7150 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0234', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A9014C5620 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0235', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A901499700 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0236', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6A900E297D0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0237', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6A900F31290 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0238', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A90112A880 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0239', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6A9001CD6D0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0240', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6A9001A17B0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0241', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00D0BD80 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0242', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00AFC800 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0243', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00C042C0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0244', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00F31290 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0245', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00EC34C0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0246', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00AD08E0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0247', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AA014DB5B0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0248', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0125E260 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0249', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0039ADA0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0250', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA014159A0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0251', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0104ECE0 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0252', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00DBBA00 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0253', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AA007A3910 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0254', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00E6B680 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0255', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AA006180F0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0256', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA00015F90 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0257', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0121C3B0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0258', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AA0044AA20 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0259', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AA01666DD0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0260', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AA007779F0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0261', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0112A880 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0262', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB003010B0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0263', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00317040 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0264', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00D79B50 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0265', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AB010BCAB0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0266', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00DE7920 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0267', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AB01198650 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0268', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00A4CB80 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0269', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AB007A3910 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0270', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB005C02B0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0271', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0107AC00 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0272', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00602160 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0273', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AB017C66D0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0274', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB001E3660 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0275', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00761A60 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0276', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0027D350 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0277', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AB00251430 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0278', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AB0172C9E0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0279', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AB011C4570 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0280', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AB006F3C90 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0281', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00709C20 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0282', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00B28720 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0283', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01716A50 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0284', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0142B930 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0285', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0163AEB0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0286', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00853590 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0287', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00970FE0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0288', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01198650 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0289', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC007E57C0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0290', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0006DDD0 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0291', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01339E00 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0292', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00C1A250 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0293', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0104ECE0 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0294', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00A62B10 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0295', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00C9DFB0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0296', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01499700 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0297', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC01700AC0 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0298', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AC0125E260 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0299', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00CDFE60 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0300', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AC00225510 AS DateTime), 4, 15, 0.33333333333333331)
GO
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0301', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00F5D1B0 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0302', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD0128A180 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0303', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00175890 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0304', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AD006DDD00 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0305', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00E556F0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0306', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD0002BF20 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0307', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00DD1990 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0308', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00C72090 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0309', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00C5C100 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0310', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AD0137BCB0 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0311', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AD004A2860 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0312', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AD003F2BE0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0313', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AD01876350 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0314', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AD01666DD0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0315', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AD002A9270 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0316', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AD013A7BD0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0317', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00CDFE60 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0318', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AD0172C9E0 AS DateTime), 26, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0319', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AD00A62B10 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0320', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AD013BDB60 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0321', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AE017F25F0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0322', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00E6B680 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0323', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00CB3F40 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0324', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AE01499700 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0325', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00F1B300 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0326', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6AE0036EE80 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0327', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00D0BD80 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0328', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AE016D4BA0 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0329', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AE015CD0E0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0330', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AE003C6CC0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0331', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AE0095B050 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0332', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00709C20 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0333', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AE002932E0 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0334', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00B964F0 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0335', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AE015333F0 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0336', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AE01700AC0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0337', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AE016EAB30 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0338', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00986F70 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0339', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AE00000000 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0340', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AE000AFC80 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0341', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AF0036EE80 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0342', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF008AB3D0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0343', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6AF014DB5B0 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0344', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF005265C0 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0345', CAST(27000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF01499700 AS DateTime), 14, 15, 20)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0346', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6AF0041EB00 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0347', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF018A2270 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0348', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF0044AA20 AS DateTime), 16, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0349', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF001F95F0 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0350', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6AF0002BF20 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0351', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF00853590 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0352', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6AF012CC030 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0353', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AF00175890 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0354', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6AF00F73140 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0355', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6AF001B7740 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0356', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6AF014159A0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0357', CAST(22500000.00 AS Decimal(18, 2)), CAST(0x0000A6AF004E4710 AS DateTime), 52, 15, 16.666666666666668)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0358', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AF00C5C100 AS DateTime), 32, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0359', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6AF0179A7B0 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0360', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6AF00568470 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0361', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B00188C2E0 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0362', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B00188C2E0 AS DateTime), 46, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0363', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6B00011DA50 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0364', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B000A62B10 AS DateTime), 25, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0365', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6B00087F4B0 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0366', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B0015B7150 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0367', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6B00044AA20 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0368', CAST(3750000.00 AS Decimal(18, 2)), CAST(0x0000A6B00104ECE0 AS DateTime), 15, 15, 2.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0369', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6B00146D7E0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0370', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6B0003F2BE0 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0371', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6B001457850 AS DateTime), 5, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0372', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6B00121C3B0 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0373', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6B0016A8C80 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0374', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6B000903210 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0375', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6B000C042C0 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0376', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6B00095B050 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0377', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6B00128A180 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0378', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B000F73140 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0379', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6B00015F900 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0380', CAST(1500000.00 AS Decimal(18, 2)), CAST(0x0000A6B000F890D0 AS DateTime), 1, 15, 1.1111111111111112)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0381', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6B10167CD60 AS DateTime), 7, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0382', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6B1009DEDB0 AS DateTime), 10, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0383', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6B100AE6870 AS DateTime), 28, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0384', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B10116C730 AS DateTime), 2, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0385', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6B10125E260 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0386', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B1016BEC10 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0387', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6B1011DA500 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0388', CAST(25500000.00 AS Decimal(18, 2)), CAST(0x0000A6B10078D980 AS DateTime), 39, 15, 18.888888888888889)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0389', CAST(1050000.00 AS Decimal(18, 2)), CAST(0x0000A6B100C88020 AS DateTime), 38, 15, 0.77777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0390', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B1002A9270 AS DateTime), 8, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0391', CAST(24000000.00 AS Decimal(18, 2)), CAST(0x0000A6B100568470 AS DateTime), 45, 15, 17.777777777777779)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0392', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B1013FFA10 AS DateTime), 44, 15, 2.2222222222222223)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0393', CAST(450000.00 AS Decimal(18, 2)), CAST(0x0000A6B10053C550 AS DateTime), 4, 15, 0.33333333333333331)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0394', CAST(1800000.00 AS Decimal(18, 2)), CAST(0x0000A6B10092F130 AS DateTime), 17, 15, 1.3333333333333333)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0395', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B10011DA50 AS DateTime), 3, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0396', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6B101365D20 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0397', CAST(900000.00 AS Decimal(18, 2)), CAST(0x0000A6B100D79B50 AS DateTime), 6, 15, 0.66666666666666663)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0398', CAST(2400000.00 AS Decimal(18, 2)), CAST(0x0000A6B10167CD60 AS DateTime), 33, 15, 1.7777777777777777)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0399', CAST(1200000.00 AS Decimal(18, 2)), CAST(0x0000A6B1006C7D70 AS DateTime), 18, 15, 0.88888888888888884)
INSERT [dbo].[Flight] ([FlightNo], [CurrentPrice], [DepartureTime], [RouteID], [CancellationFee], [Duration]) VALUES (N'AR0400', CAST(3000000.00 AS Decimal(18, 2)), CAST(0x0000A6B100B28720 AS DateTime), 16, 15, 2.2222222222222223)
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
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (24, N'DND', N'HUI', 200, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (25, N'DND', N'HNN', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (26, N'DND', N'SGN', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (27, N'DND', N'NYK', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (28, N'DND', N'CTD', 700, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (29, N'DND', N'BST', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (30, N'DND', N'SGP', 2500, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (32, N'CTD', N'SGN', 300, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (33, N'CTD', N'HNN', 1600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (34, N'CTD', N'SGP', 2500, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (35, N'CTD', N'NYK', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (36, N'CTD', N'BST', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (37, N'CTD', N'HUI', 800, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (38, N'CTD', N'DND', 700, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (39, N'NYK', N'SGN', 17000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (40, N'NYK', N'HNN', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (41, N'NYK', N'HUI', 17000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (42, N'NYK', N'DND', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (43, N'NYK', N'CTD', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (44, N'NYK', N'BST', 2000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (45, N'NYK', N'SGP', 16000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (46, N'BST', N'NYK', 2000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (47, N'BST', N'HNN', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (48, N'BST', N'HUI', 17500, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (49, N'BST', N'DND', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (51, N'BST', N'CTD', 18000, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (52, N'BST', N'SGP', 15000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (53, N'BST', N'SGN', 18000, 0)
SET IDENTITY_INSERT [dbo].[Route] OFF
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10A', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10B', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10C', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10D', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10E', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'10F', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1A', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1B', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1C', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1D', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1E', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'1F', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2A', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2B', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2C', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2D', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2E', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'2F', N'First class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3A', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3B', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3C', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3D', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3E', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'3F', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4A', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4B', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4C', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4D', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4E', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'4F', N'Business class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5A', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5B', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5C', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5D', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5E', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'5F', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6A', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6B', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6C', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6D', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6E', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'6F', N'Club class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7A', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7B', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7C', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7D', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7E', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'7F', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8A', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8B', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8C', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8D', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8E', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'8F', N'Non-smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9A', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9B', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9C', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9D', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9E', N'Smoking class')
INSERT [dbo].[Seat] ([SeatID], [Class]) VALUES (N'9F', N'Smoking class')
INSERT [dbo].[TakenSeat] ([SeatID], [FlightNo], [TicketNo]) VALUES (N'1A', N'AR0145', 1)
INSERT [dbo].[Ticket] ([TicketNo], [UserID], [ConfirmationNo], [BlockNo], [CancellationNo], [Price], [CreatedDate], [NumberOfAdults], [NumberOfChildren], [NumberOfSeniorCitizens], [Status]) VALUES (1, N'nam', NULL, NULL, NULL, CAST(1000000.00 AS Decimal(18, 2)), CAST(0xFC3B0B00 AS Date), 1, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [Password], [FirstName], [LastName], [Email], [PhoneNumber], [Sex], [CreditcardNumber], [DateOfBirth]) VALUES (N'nam', N' ', N'Nam', N'Le', N'lehainam@abc.zyz', N'83843938', 1, NULL, CAST(0x75250B00 AS Date))
ALTER TABLE [dbo].[Flight] ADD  CONSTRAINT [DF_Flight_CancellationFee]  DEFAULT ((15)) FOR [CancellationFee]
GO
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
