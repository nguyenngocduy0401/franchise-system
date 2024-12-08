USE [master]
GO
/****** Object:  Database [FranchiseSystem]    Script Date: 12/8/2024 2:36:13 PM ******/
CREATE DATABASE [FranchiseSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FranchiseSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FranchiseSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FranchiseSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\FranchiseSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FranchiseSystem] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FranchiseSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FranchiseSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FranchiseSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FranchiseSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FranchiseSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FranchiseSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [FranchiseSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FranchiseSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FranchiseSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FranchiseSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FranchiseSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FranchiseSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FranchiseSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FranchiseSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FranchiseSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FranchiseSystem] SET  ENABLE_BROKER 
GO
ALTER DATABASE [FranchiseSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FranchiseSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FranchiseSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FranchiseSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FranchiseSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FranchiseSystem] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [FranchiseSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FranchiseSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [FranchiseSystem] SET  MULTI_USER 
GO
ALTER DATABASE [FranchiseSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FranchiseSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FranchiseSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FranchiseSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FranchiseSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FranchiseSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'FranchiseSystem', N'ON'
GO
ALTER DATABASE [FranchiseSystem] SET QUERY_STORE = OFF
GO
USE [FranchiseSystem]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Agencies]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agencies](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[NumberOfRoom] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[District] [nvarchar](max) NULL,
	[Ward] [nvarchar](max) NULL,
	[PositionImageURL] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[Status] [int] NOT NULL,
	[ActivityStatus] [int] NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Agencies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[Description] [nvarchar](max) NULL,
	[Report] [nvarchar](max) NULL,
	[ReportImageURL] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[Type] [int] NULL,
	[WorkId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppointmentTemplates]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppointmentTemplates](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[StartDaysOffset] [float] NULL,
	[DurationHours] [float] NULL,
	[Description] [nvarchar](max) NULL,
	[Type] [int] NULL,
	[WorkId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AppointmentTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[FullName] [nvarchar](max) NULL,
	[DateOfBirth] [datetime2](7) NULL,
	[Gender] [nvarchar](max) NULL,
	[URLImage] [nvarchar](max) NULL,
	[OTPEmail] [nvarchar](max) NULL,
	[ExpireOTPEmail] [datetime2](7) NULL,
	[Expire] [datetime2](7) NULL,
	[CreateAt] [datetime2](7) NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[Status] [int] NULL,
	[StudentStatus] [int] NULL,
	[StudentPaymentStatus] [int] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assessments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assessments](
	[Id] [uniqueidentifier] NOT NULL,
	[Number] [int] NOT NULL,
	[Type] [nvarchar](max) NULL,
	[Content] [nvarchar](max) NULL,
	[Quantity] [int] NOT NULL,
	[Weight] [float] NULL,
	[CompletionCriteria] [float] NULL,
	[Method] [int] NOT NULL,
	[Duration] [nvarchar](max) NULL,
	[QuestionType] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Assessments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assignments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignments](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[ClassId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Assignments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssignmentSubmits]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignmentSubmits](
	[UserId] [nvarchar](450) NOT NULL,
	[AssignmentId] [uniqueidentifier] NOT NULL,
	[FileSbumitName] [nvarchar](max) NULL,
	[FileSubmitURL] [nvarchar](max) NULL,
	[SubmitDate] [datetime2](7) NULL,
	[ScoreNumber] [float] NULL,
 CONSTRAINT [PK_AssignmentSubmits] PRIMARY KEY CLUSTERED 
(
	[AssignmentId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attendances]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attendances](
	[ClassScheduleId] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Attendances] PRIMARY KEY CLUSTERED 
(
	[ClassScheduleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChapterMaterials]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChapterMaterials](
	[Id] [uniqueidentifier] NOT NULL,
	[Number] [int] NOT NULL,
	[URL] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[ChapterId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ChapterMaterials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chapters]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chapters](
	[Id] [uniqueidentifier] NOT NULL,
	[Number] [int] NOT NULL,
	[Topic] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Chapters] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [uniqueidentifier] NOT NULL,
	[Capacity] [int] NOT NULL,
	[CurrentEnrollment] [int] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[DayOfWeek] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassRooms]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassRooms](
	[UserId] [nvarchar](450) NOT NULL,
	[ClassId] [uniqueidentifier] NOT NULL,
	[Status] [int] NULL,
	[FromDate] [date] NULL,
	[ToDate] [date] NULL,
 CONSTRAINT [PK_ClassRooms] PRIMARY KEY CLUSTERED 
(
	[ClassId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ClassSchedules]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClassSchedules](
	[Id] [uniqueidentifier] NOT NULL,
	[Date] [datetime2](7) NULL,
	[ClassId] [uniqueidentifier] NULL,
	[SlotId] [uniqueidentifier] NULL,
	[Room] [nvarchar](max) NULL,
	[Status] [bit] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ClassSchedules] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contracts]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contracts](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[ContractCode] [nvarchar](max) NULL,
	[StartTime] [datetime2](7) NULL,
	[EndTime] [datetime2](7) NULL,
	[DepositPercentage] [float] NULL,
	[Total] [float] NULL,
	[PaidAmount] [float] NULL,
	[ContractDocumentImageURL] [nvarchar](max) NULL,
	[RevenueSharePercentage] [float] NULL,
	[DesignFee] [float] NULL,
	[FrachiseFee] [float] NULL,
	[Status] [int] NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Contracts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseMaterials]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseMaterials](
	[Id] [uniqueidentifier] NOT NULL,
	[URL] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CourseMaterials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[URLImage] [nvarchar](max) NULL,
	[NumberOfLession] [int] NULL,
	[Price] [int] NULL,
	[Code] [nvarchar](max) NULL,
	[Version] [int] NULL,
	[Status] [int] NOT NULL,
	[SyllabusId] [uniqueidentifier] NULL,
	[CourseCategoryId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CoursesCategories]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoursesCategories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_CoursesCategories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documents](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[URLFile] [nvarchar](max) NULL,
	[ExpirationDate] [date] NULL,
	[Type] [int] NULL,
	[Status] [int] NOT NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Equipments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipments](
	[Id] [uniqueidentifier] NOT NULL,
	[EquipmentName] [nvarchar](max) NULL,
	[SerialNumber] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[Quantity] [int] NULL,
	[Note] [nvarchar](max) NULL,
	[Price] [float] NULL,
	[ContractId] [uniqueidentifier] NULL,
	[ReportId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Equipments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EquipmentSerialNumberHistories]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EquipmentSerialNumberHistories](
	[Id] [uniqueidentifier] NOT NULL,
	[EquipmentId] [uniqueidentifier] NOT NULL,
	[SerialNumber] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_EquipmentSerialNumberHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedbacks]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedbacks](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[UserId] [nvarchar](450) NULL,
	[ClassId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Feedbacks] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FranchiseFees]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FranchiseFees](
	[Id] [uniqueidentifier] NOT NULL,
	[FeeAmount] [float] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_FranchiseFees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HomePages]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HomePages](
	[Id] [uniqueidentifier] NOT NULL,
	[FranchiseTitle] [nvarchar](max) NULL,
	[FranchiseDescription] [nvarchar](max) NULL,
	[FranchiseBannerImageUrl] [nvarchar](max) NULL,
	[FranchiseMainContent] [nvarchar](max) NULL,
	[CourseTitle] [nvarchar](max) NULL,
	[CourseDescription] [nvarchar](max) NULL,
	[CourseBannerImageUrl] [nvarchar](max) NULL,
	[CourseMainContent] [nvarchar](max) NULL,
	[ContactEmail] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_HomePages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [uniqueidentifier] NOT NULL,
	[Message] [nvarchar](max) NULL,
	[SenderId] [nvarchar](450) NULL,
	[ReceiverId] [nvarchar](450) NULL,
	[IsRead] [bit] NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Amount] [float] NULL,
	[Type] [int] NULL,
	[Method] [int] NULL,
	[Status] [int] NULL,
	[ImageURL] [nvarchar](max) NULL,
	[ContractId] [uniqueidentifier] NULL,
	[UserId] [nvarchar](450) NULL,
	[RegisterCourseId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuestionOptions]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuestionOptions](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
	[QuestionId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_QuestionOptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Questions]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Questions](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ImageURL] [nvarchar](max) NULL,
	[ChapterId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuizDetails]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuizDetails](
	[QuizId] [uniqueidentifier] NOT NULL,
	[QuestionId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_QuizDetails] PRIMARY KEY CLUSTERED 
(
	[QuizId] ASC,
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Quizzes]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Quizzes](
	[Id] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Duration] [int] NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[StartTime] [datetime2](7) NULL,
	[ClassId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Quizzes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RefreshTokens](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[Token] [nvarchar](max) NOT NULL,
	[JwtId] [nvarchar](max) NOT NULL,
	[IsUsed] [bit] NOT NULL,
	[IsRevoked] [bit] NOT NULL,
	[IssuedAt] [datetime2](7) NOT NULL,
	[ExpiredAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_RefreshTokens] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisterCourses]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterCourses](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[DateTime] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PaymentDeadline] [datetime2](7) NULL,
	[StudentCourseStatus] [int] NULL,
	[StudentPaymentStatus] [int] NULL,
	[ConsultanId] [nvarchar](max) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_RegisterCourses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegisterForms]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegisterForms](
	[Id] [uniqueidentifier] NOT NULL,
	[CustomerName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[ConsultTime] [datetime2](7) NULL,
	[Status] [int] NOT NULL,
	[CustomerStatus] [int] NULL,
	[ConsultanId] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_RegisterForms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reports]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reports](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [int] NULL,
	[Type] [int] NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[CourseId] [uniqueidentifier] NULL,
	[Response] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Scores]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scores](
	[QuizId] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ScoreNumber] [float] NOT NULL,
 CONSTRAINT [PK_Scores] PRIMARY KEY CLUSTERED 
(
	[QuizId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sessions]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sessions](
	[Id] [uniqueidentifier] NOT NULL,
	[Number] [int] NOT NULL,
	[Topic] [nvarchar](max) NULL,
	[Chapter] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[CourseId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Sessions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slots]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slots](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Slots] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentAnswers]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentAnswers](
	[QuestionOptionId] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_StudentAnswers] PRIMARY KEY CLUSTERED 
(
	[QuestionOptionId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Syllabuses]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Syllabuses](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[StudentTask] [nvarchar](max) NULL,
	[TimeAllocation] [nvarchar](max) NULL,
	[ToolsRequire] [nvarchar](max) NULL,
	[Scale] [float] NOT NULL,
	[MinAvgMarkToPass] [float] NOT NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Syllabuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAppointments]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAppointments](
	[AppointmentId] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserAppointments] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Works]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Works](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[StartDate] [datetime2](7) NULL,
	[EndDate] [datetime2](7) NULL,
	[Status] [int] NULL,
	[Level] [int] NULL,
	[Report] [nvarchar](max) NULL,
	[ReportImageURL] [nvarchar](max) NULL,
	[Submit] [int] NULL,
	[Type] [int] NULL,
	[ApproveBy] [uniqueidentifier] NULL,
	[AgencyId] [uniqueidentifier] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Works] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WorkTemplates]    Script Date: 12/8/2024 2:36:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WorkTemplates](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[StartDaysOffset] [float] NULL,
	[DurationDays] [float] NULL,
	[Level] [int] NULL,
	[Type] [int] NULL,
	[CreationDate] [datetime2](7) NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[ModificationDate] [datetime2](7) NULL,
	[ModificationBy] [uniqueidentifier] NULL,
	[DeletionDate] [datetime2](7) NULL,
	[DeleteBy] [uniqueidentifier] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_WorkTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [IX_Appointments_WorkId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Appointments_WorkId] ON [dbo].[Appointments]
(
	[WorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AppointmentTemplates_WorkId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AppointmentTemplates_WorkId] ON [dbo].[AppointmentTemplates]
(
	[WorkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetRoleClaims_RoleId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetRoleClaims_RoleId] ON [dbo].[AspNetRoleClaims]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[NormalizedName] ASC
)
WHERE ([NormalizedName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserClaims_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserClaims_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserLogins_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserLogins_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AspNetUserRoles_RoleId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUserRoles_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [EmailIndex]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [EmailIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedEmail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_AspNetUsers_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AspNetUsers_AgencyId] ON [dbo].[AspNetUsers]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[NormalizedUserName] ASC
)
WHERE ([NormalizedUserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Assessments_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Assessments_CourseId] ON [dbo].[Assessments]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Assignments_ClassId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Assignments_ClassId] ON [dbo].[Assignments]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_AssignmentSubmits_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_AssignmentSubmits_UserId] ON [dbo].[AssignmentSubmits]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Attendances_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Attendances_UserId] ON [dbo].[Attendances]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ChapterMaterials_ChapterId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_ChapterMaterials_ChapterId] ON [dbo].[ChapterMaterials]
(
	[ChapterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Chapters_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Chapters_CourseId] ON [dbo].[Chapters]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Classes_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Classes_AgencyId] ON [dbo].[Classes]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Classes_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Classes_CourseId] ON [dbo].[Classes]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_ClassRooms_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClassRooms_UserId] ON [dbo].[ClassRooms]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClassSchedules_ClassId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClassSchedules_ClassId] ON [dbo].[ClassSchedules]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ClassSchedules_SlotId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_ClassSchedules_SlotId] ON [dbo].[ClassSchedules]
(
	[SlotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Contracts_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Contracts_AgencyId] ON [dbo].[Contracts]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_CourseMaterials_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_CourseMaterials_CourseId] ON [dbo].[CourseMaterials]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_CourseCategoryId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_CourseCategoryId] ON [dbo].[Courses]
(
	[CourseCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Courses_SyllabusId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Courses_SyllabusId] ON [dbo].[Courses]
(
	[SyllabusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Documents_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Documents_AgencyId] ON [dbo].[Documents]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Equipments_ContractId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Equipments_ContractId] ON [dbo].[Equipments]
(
	[ContractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Equipments_ReportId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Equipments_ReportId] ON [dbo].[Equipments]
(
	[ReportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_EquipmentSerialNumberHistories_EquipmentId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_EquipmentSerialNumberHistories_EquipmentId] ON [dbo].[EquipmentSerialNumberHistories]
(
	[EquipmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Feedbacks_ClassId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_ClassId] ON [dbo].[Feedbacks]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Feedbacks_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_CourseId] ON [dbo].[Feedbacks]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Feedbacks_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Feedbacks_UserId] ON [dbo].[Feedbacks]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Notifications_ReceiverId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_ReceiverId] ON [dbo].[Notifications]
(
	[ReceiverId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Notifications_SenderId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Notifications_SenderId] ON [dbo].[Notifications]
(
	[SenderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Payments_ContractId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Payments_ContractId] ON [dbo].[Payments]
(
	[ContractId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Payments_RegisterCourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Payments_RegisterCourseId] ON [dbo].[Payments]
(
	[RegisterCourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Payments_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Payments_UserId] ON [dbo].[Payments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuestionOptions_QuestionId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_QuestionOptions_QuestionId] ON [dbo].[QuestionOptions]
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Questions_ChapterId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Questions_ChapterId] ON [dbo].[Questions]
(
	[ChapterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_QuizDetails_QuestionId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_QuizDetails_QuestionId] ON [dbo].[QuizDetails]
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Quizzes_ClassId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Quizzes_ClassId] ON [dbo].[Quizzes]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RefreshTokens_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_RefreshTokens_UserId] ON [dbo].[RefreshTokens]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RegisterCourses_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_RegisterCourses_CourseId] ON [dbo].[RegisterCourses]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RegisterCourses_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_RegisterCourses_UserId] ON [dbo].[RegisterCourses]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RegisterForms_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_RegisterForms_UserId] ON [dbo].[RegisterForms]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reports_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reports_AgencyId] ON [dbo].[Reports]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Reports_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reports_CourseId] ON [dbo].[Reports]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Reports_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Reports_UserId] ON [dbo].[Reports]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Scores_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Scores_UserId] ON [dbo].[Scores]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Sessions_CourseId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Sessions_CourseId] ON [dbo].[Sessions]
(
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Slots_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Slots_AgencyId] ON [dbo].[Slots]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StudentAnswers_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_StudentAnswers_UserId] ON [dbo].[StudentAnswers]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserAppointments_UserId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserAppointments_UserId] ON [dbo].[UserAppointments]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Works_AgencyId]    Script Date: 12/8/2024 2:36:14 PM ******/
CREATE NONCLUSTERED INDEX [IX_Works_AgencyId] ON [dbo].[Works]
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Works_WorkId] FOREIGN KEY([WorkId])
REFERENCES [dbo].[Works] ([Id])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Works_WorkId]
GO
ALTER TABLE [dbo].[AppointmentTemplates]  WITH CHECK ADD  CONSTRAINT [FK_AppointmentTemplates_WorkTemplates_WorkId] FOREIGN KEY([WorkId])
REFERENCES [dbo].[WorkTemplates] ([Id])
GO
ALTER TABLE [dbo].[AppointmentTemplates] CHECK CONSTRAINT [FK_AppointmentTemplates_WorkTemplates_WorkId]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUsers]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUsers_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[AspNetUsers] CHECK CONSTRAINT [FK_AspNetUsers_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Assessments]  WITH CHECK ADD  CONSTRAINT [FK_Assessments_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Assessments] CHECK CONSTRAINT [FK_Assessments_Courses_CourseId]
GO
ALTER TABLE [dbo].[Assignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Assignments] CHECK CONSTRAINT [FK_Assignments_Classes_ClassId]
GO
ALTER TABLE [dbo].[AssignmentSubmits]  WITH CHECK ADD  CONSTRAINT [FK_AssignmentSubmits_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AssignmentSubmits] CHECK CONSTRAINT [FK_AssignmentSubmits_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AssignmentSubmits]  WITH CHECK ADD  CONSTRAINT [FK_AssignmentSubmits_Assignments_AssignmentId] FOREIGN KEY([AssignmentId])
REFERENCES [dbo].[Assignments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AssignmentSubmits] CHECK CONSTRAINT [FK_AssignmentSubmits_Assignments_AssignmentId]
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD  CONSTRAINT [FK_Attendances_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Attendances] CHECK CONSTRAINT [FK_Attendances_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Attendances]  WITH CHECK ADD  CONSTRAINT [FK_Attendances_ClassSchedules_ClassScheduleId] FOREIGN KEY([ClassScheduleId])
REFERENCES [dbo].[ClassSchedules] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Attendances] CHECK CONSTRAINT [FK_Attendances_ClassSchedules_ClassScheduleId]
GO
ALTER TABLE [dbo].[ChapterMaterials]  WITH CHECK ADD  CONSTRAINT [FK_ChapterMaterials_Chapters_ChapterId] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Id])
GO
ALTER TABLE [dbo].[ChapterMaterials] CHECK CONSTRAINT [FK_ChapterMaterials_Chapters_ChapterId]
GO
ALTER TABLE [dbo].[Chapters]  WITH CHECK ADD  CONSTRAINT [FK_Chapters_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Chapters] CHECK CONSTRAINT [FK_Chapters_Courses_CourseId]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Courses_CourseId]
GO
ALTER TABLE [dbo].[ClassRooms]  WITH CHECK ADD  CONSTRAINT [FK_ClassRooms_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClassRooms] CHECK CONSTRAINT [FK_ClassRooms_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[ClassRooms]  WITH CHECK ADD  CONSTRAINT [FK_ClassRooms_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ClassRooms] CHECK CONSTRAINT [FK_ClassRooms_Classes_ClassId]
GO
ALTER TABLE [dbo].[ClassSchedules]  WITH CHECK ADD  CONSTRAINT [FK_ClassSchedules_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[ClassSchedules] CHECK CONSTRAINT [FK_ClassSchedules_Classes_ClassId]
GO
ALTER TABLE [dbo].[ClassSchedules]  WITH CHECK ADD  CONSTRAINT [FK_ClassSchedules_Slots_SlotId] FOREIGN KEY([SlotId])
REFERENCES [dbo].[Slots] ([Id])
GO
ALTER TABLE [dbo].[ClassSchedules] CHECK CONSTRAINT [FK_ClassSchedules_Slots_SlotId]
GO
ALTER TABLE [dbo].[Contracts]  WITH CHECK ADD  CONSTRAINT [FK_Contracts_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Contracts] CHECK CONSTRAINT [FK_Contracts_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[CourseMaterials]  WITH CHECK ADD  CONSTRAINT [FK_CourseMaterials_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[CourseMaterials] CHECK CONSTRAINT [FK_CourseMaterials_Courses_CourseId]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_CoursesCategories_CourseCategoryId] FOREIGN KEY([CourseCategoryId])
REFERENCES [dbo].[CoursesCategories] ([Id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_CoursesCategories_CourseCategoryId]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Syllabuses_SyllabusId] FOREIGN KEY([SyllabusId])
REFERENCES [dbo].[Syllabuses] ([Id])
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Syllabuses_SyllabusId]
GO
ALTER TABLE [dbo].[Documents]  WITH CHECK ADD  CONSTRAINT [FK_Documents_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Documents] CHECK CONSTRAINT [FK_Documents_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[Equipments]  WITH CHECK ADD  CONSTRAINT [FK_Equipments_Contracts_ContractId] FOREIGN KEY([ContractId])
REFERENCES [dbo].[Contracts] ([Id])
GO
ALTER TABLE [dbo].[Equipments] CHECK CONSTRAINT [FK_Equipments_Contracts_ContractId]
GO
ALTER TABLE [dbo].[Equipments]  WITH CHECK ADD  CONSTRAINT [FK_Equipments_Reports_ReportId] FOREIGN KEY([ReportId])
REFERENCES [dbo].[Reports] ([Id])
GO
ALTER TABLE [dbo].[Equipments] CHECK CONSTRAINT [FK_Equipments_Reports_ReportId]
GO
ALTER TABLE [dbo].[EquipmentSerialNumberHistories]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentSerialNumberHistories_Equipments_EquipmentId] FOREIGN KEY([EquipmentId])
REFERENCES [dbo].[Equipments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EquipmentSerialNumberHistories] CHECK CONSTRAINT [FK_EquipmentSerialNumberHistories_Equipments_EquipmentId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Classes_ClassId]
GO
ALTER TABLE [dbo].[Feedbacks]  WITH CHECK ADD  CONSTRAINT [FK_Feedbacks_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Courses_CourseId]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_AspNetUsers_ReceiverId] FOREIGN KEY([ReceiverId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_AspNetUsers_ReceiverId]
GO
ALTER TABLE [dbo].[Notifications]  WITH CHECK ADD  CONSTRAINT [FK_Notifications_AspNetUsers_SenderId] FOREIGN KEY([SenderId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Notifications] CHECK CONSTRAINT [FK_Notifications_AspNetUsers_SenderId]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Contracts_ContractId] FOREIGN KEY([ContractId])
REFERENCES [dbo].[Contracts] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Contracts_ContractId]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_RegisterCourses_RegisterCourseId] FOREIGN KEY([RegisterCourseId])
REFERENCES [dbo].[RegisterCourses] ([Id])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_RegisterCourses_RegisterCourseId]
GO
ALTER TABLE [dbo].[QuestionOptions]  WITH CHECK ADD  CONSTRAINT [FK_QuestionOptions_Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuestionOptions] CHECK CONSTRAINT [FK_QuestionOptions_Questions_QuestionId]
GO
ALTER TABLE [dbo].[Questions]  WITH CHECK ADD  CONSTRAINT [FK_Questions_Chapters_ChapterId] FOREIGN KEY([ChapterId])
REFERENCES [dbo].[Chapters] ([Id])
GO
ALTER TABLE [dbo].[Questions] CHECK CONSTRAINT [FK_Questions_Chapters_ChapterId]
GO
ALTER TABLE [dbo].[QuizDetails]  WITH CHECK ADD  CONSTRAINT [FK_QuizDetails_Questions_QuestionId] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Questions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuizDetails] CHECK CONSTRAINT [FK_QuizDetails_Questions_QuestionId]
GO
ALTER TABLE [dbo].[QuizDetails]  WITH CHECK ADD  CONSTRAINT [FK_QuizDetails_Quizzes_QuizId] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quizzes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[QuizDetails] CHECK CONSTRAINT [FK_QuizDetails_Quizzes_QuizId]
GO
ALTER TABLE [dbo].[Quizzes]  WITH CHECK ADD  CONSTRAINT [FK_Quizzes_Classes_ClassId] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Quizzes] CHECK CONSTRAINT [FK_Quizzes_Classes_ClassId]
GO
ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD  CONSTRAINT [FK_RefreshTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RefreshTokens] CHECK CONSTRAINT [FK_RefreshTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[RegisterCourses]  WITH CHECK ADD  CONSTRAINT [FK_RegisterCourses_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[RegisterCourses] CHECK CONSTRAINT [FK_RegisterCourses_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[RegisterCourses]  WITH CHECK ADD  CONSTRAINT [FK_RegisterCourses_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[RegisterCourses] CHECK CONSTRAINT [FK_RegisterCourses_Courses_CourseId]
GO
ALTER TABLE [dbo].[RegisterForms]  WITH CHECK ADD  CONSTRAINT [FK_RegisterForms_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[RegisterForms] CHECK CONSTRAINT [FK_RegisterForms_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Reports]  WITH CHECK ADD  CONSTRAINT [FK_Reports_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Reports] CHECK CONSTRAINT [FK_Reports_Courses_CourseId]
GO
ALTER TABLE [dbo].[Scores]  WITH CHECK ADD  CONSTRAINT [FK_Scores_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Scores] CHECK CONSTRAINT [FK_Scores_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Scores]  WITH CHECK ADD  CONSTRAINT [FK_Scores_Quizzes_QuizId] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quizzes] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Scores] CHECK CONSTRAINT [FK_Scores_Quizzes_QuizId]
GO
ALTER TABLE [dbo].[Sessions]  WITH CHECK ADD  CONSTRAINT [FK_Sessions_Courses_CourseId] FOREIGN KEY([CourseId])
REFERENCES [dbo].[Courses] ([Id])
GO
ALTER TABLE [dbo].[Sessions] CHECK CONSTRAINT [FK_Sessions_Courses_CourseId]
GO
ALTER TABLE [dbo].[Slots]  WITH CHECK ADD  CONSTRAINT [FK_Slots_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Slots] CHECK CONSTRAINT [FK_Slots_Agencies_AgencyId]
GO
ALTER TABLE [dbo].[StudentAnswers]  WITH CHECK ADD  CONSTRAINT [FK_StudentAnswers_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentAnswers] CHECK CONSTRAINT [FK_StudentAnswers_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[StudentAnswers]  WITH CHECK ADD  CONSTRAINT [FK_StudentAnswers_QuestionOptions_QuestionOptionId] FOREIGN KEY([QuestionOptionId])
REFERENCES [dbo].[QuestionOptions] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[StudentAnswers] CHECK CONSTRAINT [FK_StudentAnswers_QuestionOptions_QuestionOptionId]
GO
ALTER TABLE [dbo].[UserAppointments]  WITH CHECK ADD  CONSTRAINT [FK_UserAppointments_Appointments_AppointmentId] FOREIGN KEY([AppointmentId])
REFERENCES [dbo].[Appointments] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAppointments] CHECK CONSTRAINT [FK_UserAppointments_Appointments_AppointmentId]
GO
ALTER TABLE [dbo].[UserAppointments]  WITH CHECK ADD  CONSTRAINT [FK_UserAppointments_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAppointments] CHECK CONSTRAINT [FK_UserAppointments_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Works]  WITH CHECK ADD  CONSTRAINT [FK_Works_Agencies_AgencyId] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([Id])
GO
ALTER TABLE [dbo].[Works] CHECK CONSTRAINT [FK_Works_Agencies_AgencyId]
GO
USE [master]
GO
ALTER DATABASE [FranchiseSystem] SET  READ_WRITE 
GO
