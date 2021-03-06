USE [master]
GO
CREATE DATABASE [midCoQuan]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'midCoQuan', FILENAME = N'C:\Users\USER\midCoQuan.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'midCoQuan_log', FILENAME = N'C:\Users\USER\midCoQuan_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [midCoQuan] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [midCoQuan].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [midCoQuan] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [midCoQuan] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [midCoQuan] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [midCoQuan] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [midCoQuan] SET ARITHABORT OFF 
GO
ALTER DATABASE [midCoQuan] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [midCoQuan] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [midCoQuan] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [midCoQuan] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [midCoQuan] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [midCoQuan] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [midCoQuan] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [midCoQuan] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [midCoQuan] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [midCoQuan] SET  DISABLE_BROKER 
GO
ALTER DATABASE [midCoQuan] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [midCoQuan] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [midCoQuan] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [midCoQuan] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [midCoQuan] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [midCoQuan] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [midCoQuan] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [midCoQuan] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [midCoQuan] SET  MULTI_USER 
GO
ALTER DATABASE [midCoQuan] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [midCoQuan] SET DB_CHAINING OFF 
GO
ALTER DATABASE [midCoQuan] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [midCoQuan] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [midCoQuan]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [BoPhan](
	[MABP] [varchar](10) NOT NULL,
	[TENBP] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__BoPhan__603FFF9DC8567C5C] PRIMARY KEY CLUSTERED 
(
	[MABP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [DONVI](
	[MADV] [varchar](10) NOT NULL,
	[TENDV] [nvarchar](50) NOT NULL,
	[NGAYTL] [datetime] NULL,
	[MABP] [varchar](10) NOT NULL,
 CONSTRAINT [PK__DONVI__603F00556BC857A7] PRIMARY KEY CLUSTERED 
(
	[MADV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'HC', N'Hành chính')
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'KD', N'Kiểm duyệt')
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'KT', N'Kế toán')
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'KTh', N'Kỹ thuật')
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'NS', N'Nhân sự')
INSERT [BoPhan] ([MABP], [TENBP]) VALUES (N'QL', N'Quản lý')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'01', N'Đơn vị 01', CAST(N'2000-10-01T00:00:00.000' AS DateTime), N'HC')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'02', N'Đơn vị 01', CAST(N'2000-10-02T00:00:00.000' AS DateTime), N'QL')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'03', N'Đơn vị 02', CAST(N'2000-10-03T00:00:00.000' AS DateTime), N'KT')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'04', N'Đơn vị 02', CAST(N'2000-10-04T00:00:00.000' AS DateTime), N'NS')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'05', N'Đơn vị 03', CAST(N'2000-10-05T00:00:00.000' AS DateTime), N'Kth')
INSERT [DONVI] ([MADV], [TENDV], [NGAYTL], [MABP]) VALUES (N'06', N'Đơn vị 03', CAST(N'2000-10-06T00:00:00.000' AS DateTime), N'KD')
ALTER TABLE [DONVI]  WITH CHECK ADD  CONSTRAINT [FK_DONVI_BoPhan] FOREIGN KEY([MABP])
REFERENCES [BoPhan] ([MABP])
GO
ALTER TABLE [DONVI] CHECK CONSTRAINT [FK_DONVI_BoPhan]
GO
USE [master]
GO
ALTER DATABASE [midCoQuan] SET  READ_WRITE 
GO
