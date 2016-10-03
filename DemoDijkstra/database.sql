USE [master]
GO
/****** Object:  Database [AirlineReservationSystem]    Script Date: 10/3/2016 4:45:47 PM ******/
CREATE DATABASE [AirlineReservationSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AirlineReservationSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\AirlineReservationSystem.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AirlineReservationSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\AirlineReservationSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  Table [dbo].[City]    Script Date: 10/3/2016 4:45:47 PM ******/
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
/****** Object:  Table [dbo].[Class]    Script Date: 10/3/2016 4:45:47 PM ******/
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
/****** Object:  Table [dbo].[Flight]    Script Date: 10/3/2016 4:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Flight](
	[FlightNo] [varchar](10) NOT NULL,
	[CurrentPrice] [decimal](18, 2) NOT NULL,
	[DepartureTime] [datetime] NULL,
	[ArrivalTime] [datetime] NULL,
	[RouteID] [int] NULL,
	[Duration] [float] NULL,
 CONSTRAINT [PK_Flight] PRIMARY KEY CLUSTERED 
(
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Route]    Script Date: 10/3/2016 4:45:47 PM ******/
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
	[Distance] [float] NOT NULL,
	[InService] [bit] NOT NULL,
 CONSTRAINT [PK_Route] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 10/3/2016 4:45:47 PM ******/
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
/****** Object:  Table [dbo].[TakenSeat]    Script Date: 10/3/2016 4:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TakenSeat](
	[SeatID] [varchar](4) NOT NULL,
	[FlightNo] [varchar](10) NOT NULL,
	[TicketNo] [varchar](10) NULL,
 CONSTRAINT [PK_TakenSeat] PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC,
	[FlightNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 10/3/2016 4:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketNo] [varchar](10) NOT NULL,
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
/****** Object:  Table [dbo].[Ticket_Flight]    Script Date: 10/3/2016 4:45:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ticket_Flight](
	[TicketNo] [varchar](10) NOT NULL,
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
/****** Object:  Table [dbo].[User]    Script Date: 10/3/2016 4:45:47 PM ******/
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
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'CTD', N'Can Tho', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'DND', N'Da Nang', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HNN', N'Ha Noi', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'HUI', N'Hue', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'NYK', N'New York', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGN', N'Ho Chi Minh', 1)
INSERT [dbo].[City] ([CityID], [CityName], [InService]) VALUES (N'SGP', N'Singapore', 1)
SET IDENTITY_INSERT [dbo].[Route] ON 

INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (1, N'SGN', N'HUI', 1000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (2, N'SGN', N'HNN', 2000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (3, N'SGN', N'DND', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (4, N'SGN', N'CTD', 300, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (5, N'SGN', N'NYK', 35000, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (6, N'HNN', N'HUI', 600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (7, N'HNN', N'CTD', 1600, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (8, N'HNN', N'DND', 800, 1)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (9, N'HUI', N'DND', 200, 0)
INSERT [dbo].[Route] ([RouteID], [OriginalCityID], [DestinationCityID], [Distance], [InService]) VALUES (10, N'HUI', N'HNN', 600, 1)
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
