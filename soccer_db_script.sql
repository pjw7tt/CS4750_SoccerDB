USE [master]
GO
/****** Object:  Database [SoccerDB]    Script Date: 11/28/2024 9:06:40 PM ******/
CREATE DATABASE [SoccerDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SoccerDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SoccerDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SoccerDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\SoccerDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SoccerDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SoccerDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SoccerDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SoccerDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SoccerDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SoccerDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SoccerDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SoccerDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SoccerDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SoccerDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SoccerDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SoccerDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SoccerDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SoccerDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SoccerDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SoccerDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SoccerDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SoccerDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SoccerDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SoccerDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SoccerDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SoccerDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SoccerDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SoccerDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SoccerDB] SET RECOVERY FULL 
GO
ALTER DATABASE [SoccerDB] SET  MULTI_USER 
GO
ALTER DATABASE [SoccerDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SoccerDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SoccerDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SoccerDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SoccerDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SoccerDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SoccerDB', N'ON'
GO
ALTER DATABASE [SoccerDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [SoccerDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SoccerDB]
GO
/****** Object:  User [pjw7tt]    Script Date: 11/28/2024 9:06:41 PM ******/
CREATE USER [pjw7tt] FOR LOGIN [pjw7tt] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_datareader] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [pjw7tt]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [pjw7tt]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[country_id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameMatch]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameMatch](
	[match_id] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[home_team_id] [int] NOT NULL,
	[away_team_id] [int] NOT NULL,
	[home_score] [int] NULL,
	[away_score] [int] NULL,
	[attendance] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[match_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[League]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[League](
	[league_id] [int] IDENTITY(1,1) NOT NULL,
	[league_name] [varchar](100) NOT NULL,
	[country_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[league_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manager]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manager](
	[manager_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[experience] [int] NULL,
	[nationality] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[manager_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Player]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Player](
	[player_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[age] [int] NOT NULL,
	[nationality] [varchar](50) NULL,
	[position] [varchar](50) NULL,
	[overall_rating] [decimal](3, 1) NULL,
PRIMARY KEY CLUSTERED 
(
	[player_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerContract]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerContract](
	[contract_id] [int] IDENTITY(1,1) NOT NULL,
	[player_id] [int] NOT NULL,
	[team_id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[salary] [decimal](16, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[contract_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlayerStatistics]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlayerStatistics](
	[player_stats_id] [int] IDENTITY(1,1) NOT NULL,
	[player_id] [int] NOT NULL,
	[match_id] [int] NOT NULL,
	[minutes_played] [int] NULL,
	[goals_scored] [int] NULL,
	[assists] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[player_stats_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Season]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Season](
	[season_id] [int] IDENTITY(1,1) NOT NULL,
	[year] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[season_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stadium]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stadium](
	[stadium_id] [int] IDENTITY(1,1) NOT NULL,
	[stadium_name] [varchar](100) NOT NULL,
	[capacity] [int] NOT NULL,
	[country_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[stadium_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[team_id] [int] IDENTITY(1,1) NOT NULL,
	[team_name] [varchar](100) NOT NULL,
	[league_id] [int] NULL,
	[manager_id] [int] NULL,
	[stadium_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[team_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamStatistics]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamStatistics](
	[team_stats_id] [int] IDENTITY(1,1) NOT NULL,
	[team_id] [int] NOT NULL,
	[match_id] [int] NOT NULL,
	[possession_percentage] [decimal](5, 2) NULL,
	[shots_on_target] [int] NULL,
	[corners] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[team_stats_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferPortal]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferPortal](
	[transaction_id] [int] IDENTITY(1,1) NOT NULL,
	[player_id] [int] NOT NULL,
	[from_team_id] [int] NULL,
	[to_team_id] [int] NULL,
	[transfer_fee] [decimal](16, 2) NULL,
	[date_entered] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GameMatch] ADD  DEFAULT ((0)) FOR [home_score]
GO
ALTER TABLE [dbo].[GameMatch] ADD  DEFAULT ((0)) FOR [away_score]
GO
ALTER TABLE [dbo].[PlayerStatistics] ADD  DEFAULT ((0)) FOR [goals_scored]
GO
ALTER TABLE [dbo].[PlayerStatistics] ADD  DEFAULT ((0)) FOR [assists]
GO
ALTER TABLE [dbo].[TeamStatistics] ADD  DEFAULT ((0)) FOR [shots_on_target]
GO
ALTER TABLE [dbo].[TeamStatistics] ADD  DEFAULT ((0)) FOR [corners]
GO
ALTER TABLE [dbo].[GameMatch]  WITH CHECK ADD FOREIGN KEY([away_team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[GameMatch]  WITH CHECK ADD FOREIGN KEY([home_team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[League]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[PlayerContract]  WITH CHECK ADD FOREIGN KEY([player_id])
REFERENCES [dbo].[Player] ([player_id])
GO
ALTER TABLE [dbo].[PlayerContract]  WITH CHECK ADD FOREIGN KEY([team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[PlayerStatistics]  WITH CHECK ADD FOREIGN KEY([match_id])
REFERENCES [dbo].[GameMatch] ([match_id])
GO
ALTER TABLE [dbo].[PlayerStatistics]  WITH CHECK ADD FOREIGN KEY([player_id])
REFERENCES [dbo].[Player] ([player_id])
GO
ALTER TABLE [dbo].[Stadium]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[Country] ([country_id])
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD FOREIGN KEY([league_id])
REFERENCES [dbo].[League] ([league_id])
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD FOREIGN KEY([manager_id])
REFERENCES [dbo].[Manager] ([manager_id])
GO
ALTER TABLE [dbo].[Team]  WITH CHECK ADD FOREIGN KEY([stadium_id])
REFERENCES [dbo].[Stadium] ([stadium_id])
GO
ALTER TABLE [dbo].[TeamStatistics]  WITH CHECK ADD FOREIGN KEY([match_id])
REFERENCES [dbo].[GameMatch] ([match_id])
GO
ALTER TABLE [dbo].[TeamStatistics]  WITH CHECK ADD FOREIGN KEY([team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[TransferPortal]  WITH CHECK ADD FOREIGN KEY([from_team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[TransferPortal]  WITH CHECK ADD FOREIGN KEY([player_id])
REFERENCES [dbo].[Player] ([player_id])
GO
ALTER TABLE [dbo].[TransferPortal]  WITH CHECK ADD FOREIGN KEY([to_team_id])
REFERENCES [dbo].[Team] ([team_id])
GO
ALTER TABLE [dbo].[GameMatch]  WITH CHECK ADD  CONSTRAINT [chk_match_attendance] CHECK  (([attendance]>=(0)))
GO
ALTER TABLE [dbo].[GameMatch] CHECK CONSTRAINT [chk_match_attendance]
GO
ALTER TABLE [dbo].[Manager]  WITH CHECK ADD CHECK  (([experience]>=(0)))
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD  CONSTRAINT [chk_player_age] CHECK  (([age]>=(16) AND [age]<=(50)))
GO
ALTER TABLE [dbo].[Player] CHECK CONSTRAINT [chk_player_age]
GO
ALTER TABLE [dbo].[Player]  WITH CHECK ADD CHECK  (([overall_rating]>=(0) AND [overall_rating]<=(100)))
GO
ALTER TABLE [dbo].[PlayerContract]  WITH CHECK ADD  CONSTRAINT [chk_contract_dates] CHECK  (([end_date]>[start_date]))
GO
ALTER TABLE [dbo].[PlayerContract] CHECK CONSTRAINT [chk_contract_dates]
GO
ALTER TABLE [dbo].[PlayerContract]  WITH CHECK ADD CHECK  (([salary]>=(0)))
GO
ALTER TABLE [dbo].[PlayerStatistics]  WITH CHECK ADD CHECK  (([minutes_played]>=(0)))
GO
ALTER TABLE [dbo].[Stadium]  WITH CHECK ADD CHECK  (([capacity]>(0)))
GO
ALTER TABLE [dbo].[TeamStatistics]  WITH CHECK ADD CHECK  (([possession_percentage]>=(0) AND [possession_percentage]<=(100)))
GO
/****** Object:  StoredProcedure [dbo].[GetPlayerStatisticsByID]    Script Date: 11/28/2024 9:06:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Get player statistics quickly using PlayerID
CREATE PROCEDURE [dbo].[GetPlayerStatisticsByID]
    @player_id INT
AS
BEGIN
    SELECT * FROM PlayerStatistics
    WHERE player_id = @player_id;
END;

-- Execute
EXEC GetPlayerStatisticsByID
	@player_id = 1;
GO
USE [master]
GO
ALTER DATABASE [SoccerDB] SET  READ_WRITE 
GO
