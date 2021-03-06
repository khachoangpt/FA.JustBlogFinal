USE [master]
GO
/****** Object:  Database [JustBlog]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE DATABASE [JustBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'JustBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\JustBlog.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'JustBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\JustBlog_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [JustBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [JustBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [JustBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [JustBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [JustBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [JustBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [JustBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [JustBlog] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [JustBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [JustBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [JustBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [JustBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [JustBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [JustBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [JustBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [JustBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [JustBlog] SET  ENABLE_BROKER 
GO
ALTER DATABASE [JustBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [JustBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [JustBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [JustBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [JustBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [JustBlog] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [JustBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [JustBlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [JustBlog] SET  MULTI_USER 
GO
ALTER DATABASE [JustBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [JustBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [JustBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [JustBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [JustBlog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [JustBlog]
GO
/****** Object:  Schema [common]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE SCHEMA [common]
GO
/****** Object:  Table [common].[Categories]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Categories](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[UrlSlug] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](1024) NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_common.Categories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [common].[Comments]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Comments](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](max) NOT NULL,
	[PostId] [uniqueidentifier] NOT NULL,
	[CommentHeader] [nvarchar](255) NULL,
	[CommentText] [nvarchar](1024) NULL,
	[CommentTime] [datetimeoffset](7) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [common].[Posts]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Posts](
	[Id] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ShortDescription] [nvarchar](1024) NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[PostContent] [nvarchar](max) NOT NULL,
	[UrlSlug] [nvarchar](max) NOT NULL,
	[Published] [bit] NOT NULL,
	[PostedOn] [datetimeoffset](7) NOT NULL,
	[Modified] [datetimeoffset](7) NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
	[ViewCount] [int] NOT NULL DEFAULT ((0)),
	[RateCount] [int] NOT NULL DEFAULT ((0)),
	[TotalRate] [int] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_dbo.Posts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [common].[PostTagMap]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[PostTagMap](
	[PostId] [uniqueidentifier] NOT NULL,
	[TagId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_dbo.PostTagMap] PRIMARY KEY CLUSTERED 
(
	[PostId] ASC,
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [common].[Tags]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [common].[Tags](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[UrlSlug] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](1024) NULL,
	[Count] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[InsertedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 8/11/2021 3:36:48 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
INSERT [common].[Categories] ([Id], [Name], [UrlSlug], [Description], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'42f248c5-4ada-490b-bd7b-2a5844761d79', N'Recipe', N'recipe', N'Recipe Blog', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Categories] ([Id], [Name], [UrlSlug], [Description], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'7821d4cb-0433-4fb2-a233-453453550b09', N'Tips', N'tips', N'Tips Blog', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Categories] ([Id], [Name], [UrlSlug], [Description], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'41ca1eb5-5776-4bac-adcc-773b52d4ba7b', N'Travel', N'travel', N'Travel Blog', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Categories] ([Id], [Name], [UrlSlug], [Description], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'396f9912-b019-4f30-b961-f291ec88aabe', N'Life Style', N'life-style', N'Life Style Blog', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'c06c8222-8978-4ebf-b719-05299f8cee4e', N'Liang', N'liang@gmail.com', N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'Lorem Ipsum is simply', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'c2838943-8ffe-41ee-a16c-7195a5795ce7', N'Jonty Andrews', N'jontyandrews@gmail.com', N'ca54f293-23a2-4c34-998a-e3b1739b787a', N'Contrary to popular belief', N'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'2beeceb0-1d0b-4e14-9028-aff2383f625e', N'Corey oates', N'coreyoates@gmail.com', N'f6a1ff75-68ef-4fb0-80c7-08bd395b430c', N'Lorem ipsum dolor sit amet', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'fe48eb7d-84a0-4573-8fa1-c0083b0ffd05', N'Sarah Tim', N'sarahtim@gmail.com', N'f45a23a8-6158-45e1-b8c3-0b14f10f8894', N'There are many variations of passages', N'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don''t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'e122e909-b858-4741-bb5e-c8eb0c068111', N'Samso Nagaro', N'samsonagaro@gmail.com', N'8c7e69da-0083-4e5a-9155-cccad1cc2085', N'It uses a dictionary of over 200 Latin words', N'It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Comments] ([Id], [Name], [Email], [PostId], [CommentHeader], [CommentText], [CommentTime], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'4bec527a-d1e5-4c59-9445-d1b1cb732ebd', N'Samoya Johns', N'samoyajohns@gmail.com', N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'Lorem ipsum dolor sit amet', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it', CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'f6a1ff75-68ef-4fb0-80c7-08bd395b430c', N'Space colonization: What are hindering us?', N'https://www.facebook.com/notes/nguy%E1%BB%85n-t%C3%A0i-long/space-colonization-what-are-hindering-us/1112384025483978 Ever since...', N'blog-6.jpg', N'Ever since Neil Armstrong imprinted his footsteps on the Lunar surface, bringing new laurels to international space exploration endeavors and effectively ending the Space Race, humanity has dreamed even more of one day settling down in space and conquering the stars. Enormous amounts of financial budget coupled with thousands of hours of research efforts throughout the years by global space programs and organizations (most prominently NASA) are gradually and laboriously bringing the human race closer to fulfillment of this centuries-long ambition. Yet, insurmountable physical challenges exist, and with them comes the uncertainty of long-term human settlement on other planets. What lies waiting for us ahead in the vastness of space? What are the requirements and how do we settle down on those planets? In fact, does the term space colonization really mean that humans are really able to conquer the entirety of the 93-billion-light-year observable universe?', N'space-colonization-what-are-hindering-us', 1, CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), N'41ca1eb5-5776-4bac-adcc-773b52d4ba7b', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 111, 11, 23)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'f45a23a8-6158-45e1-b8c3-0b14f10f8894', N'How Art Could Save The World', N'It’s extremely difficult to define “art” in modern times. As of recent, postmodernism has taken a hold of how we express our artistic...', N'blog-4.jpg', N'We are naturally drawn to statements that could resonate with us and our place in society. The existential and political angst the artist faces in modern times as they’re conveying ideas, through conventional means of art. The recent Joker movie is a prime example of how a fictional character could be representative and even reflective of certain group(s) of people, in this case, the mentally ill. The character Arthur Fleck (presumably based on respectively the two classic Martin’s characters Travis Bickle and Rupert Pupkin) should give us a clear, albeit twisted image of a modern tragedy: He’s a mentally ill loner who’s also got a medical condition where he can’t control his laugh. He’s misunderstood, isolated and mistreated by society, who harbors dangerous perspectives about life and about himself.', N'how-art-could-save-the-world', 1, CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), N'7821d4cb-0433-4fb2-a233-453453550b09', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 125, 13, 31)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'What to do when you have to wait', N'Wait for the next delayed flight in 3 hours. Wait on the train for 12 hours before arrival. Wait for someone who is never going to...', N'blog-1.jpg', N'Wait for the next delayed flight in 3 hours. Wait on the train for 12 hours before arrival. Wait for someone who is never going to text you back. Wait for something that is never going to fall in your mouth. Wait for a story where you could become the main character. Wait for the inevitable conclusion that awaits everyone.', N'what-to-do-when-you-have-to-wait', 1, CAST(N'2021-08-11T14:46:59.4688835+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4698796+07:00' AS DateTimeOffset), N'41ca1eb5-5776-4bac-adcc-773b52d4ba7b', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 112, 10, 46)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'566dc842-d4fb-4be0-bd48-5cea5b85c060', N'Amazing people I met in Bangkok: travel changes my life', N'For the last 20 years, I stayed at home and welcomed Tet - Lunar New Year with family and relatives. This year, 2018, I decided to...', N'blog-08.jpg', N'<p>In Bangkok, I met different strangers who helped me a lot though we didn''t really know each other. I met a girl at the bus station, asking her the way to DraftBoard. She opened the map and then told me that she could take me to the place I wanted to go to. We said goodbye to each other at the door of DraftBoard and then she returned to the bus station to get to her offfice. She was amazingly kind-hearted and friendly. I felt thankful to her so much for her sincere treat. When I was in China Town, a local guy asked me if we could hang out together. We knew each other on Couchsurfing. I texted "ok" and told him the coffee shop I was sitting in. After 40 minutes, he turned out and he took me to everywhere in Bangkok on his motorbike. He was so so nice and friendly. He didn''t mind walking with me. We walked a lot. He showed me to Golden Mount, to some festivals, to Khao San Road, to other tourist spots and we had dinner under the bridge. We talked a lot. He seemed to be cozy and a little bit shy. At 8 pm, he drove me to the hotel and we said goodbye to each other.</p>', N'amazing-people-i-met-in-bangkok-travel-changes-my-life', 1, CAST(N'2021-08-11T15:20:36.4275132+07:00' AS DateTimeOffset), CAST(N'2021-08-11T15:20:36.4285106+07:00' AS DateTimeOffset), N'41ca1eb5-5776-4bac-adcc-773b52d4ba7b', 0, CAST(N'2021-08-11 15:20:36.470' AS DateTime), CAST(N'2021-08-11 15:20:36.470' AS DateTime), 1, 1, 1)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'9e53c727-0e2e-4f9d-9d7d-6da471911bca', N'We men are simple, creatures of habit', N'The weather today is just perfect for that "mountain goat". That''s how I often address my friend at work, and outside of work, Lukas....', N'blog-09.jpg', N'<p>Those two have one thing in common: they don''t give a shit about almost anything but their girlfriends. I often asked them if they wanted to settle down, only to receive the answers of "Nah" and "No, are you crazy?", but I know they want it, in a way. At a certain age, people tend to think about certain things. Stability, settling down, having a family, having a kid or two. I would be furious if being asked that question when I was in my early 20s. I would go with "Life is about exploration, about adventure, about travelling afar, meeting interesting people, having the most romantic relationships on Earth, enjoying life to the fullest" so on and so forth. It was fun, to a certain extent. But fun has its own limitation. Fun drains you out. Fun leaves you with consequences. Fun doesn''t last that long. At some point in your life, you will begin to ask the question of "what''s left after all those ''fun'' years?"</p>', N'we-men-are-simple-creatures-of-habit', 1, CAST(N'2021-08-11T15:29:39.7110426+07:00' AS DateTimeOffset), CAST(N'2021-08-11T15:29:39.7110426+07:00' AS DateTimeOffset), N'396f9912-b019-4f30-b961-f291ec88aabe', 0, CAST(N'2021-08-11 15:29:39.713' AS DateTime), CAST(N'2021-08-11 15:29:39.713' AS DateTime), 1, 1, 1)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'5b9259d4-391d-48bb-96db-7a40c01a4a84', N'A Tay on Wheels', N'Motorbikes in Hanoi. Alright, so it’s been a while since my last (and first and only) post. I could come up with any number of excuses...', N'blog-3.jpg', N'Yes, the traffic is annoying and crazy. I often count my lucky stars for not knowing a lot of dirty language in Vietnamese, because I’d be spouting it a lot. At people that absolutely need to pass me on the left 2 meters before they take a right turn. At people who feel that while driving a motorbike is the perfect time for them to check their Facebook comments. At people who seem to think their horn creates a force field, so they keep it blaring while they speed through tiny openings in traffic with no regard for anyone else or even themselves.', N'a-tay-on-wheels', 1, CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), N'42f248c5-4ada-490b-bd7b-2a5844761d79', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 125, 13, 31)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'c63f0ee0-f795-43d6-b5ef-885129c74dbe', N'A letter to my future self', N'Hello there again, Sitting here writing another letter to you after one year feels... hmm... kind of like a tradition. You know I...', N'blog-10.jpg', N'<p>Sitting here writing another letter to you after one year feels... hmm... kind of like a tradition. You know I always like to reflect, look back at stuff that happened and create some kinds of connection as Steve Jobs once said "connecting the dots" :). Though sometimes I tend to dwell on my past mistakes while reflecting. I really hope you learn how to forgive yourself for past mistakes as you are much older now (well no pressure, I don''t mean you have to do this or that when you reach a certain age, it''s just something we should learn to love ourselves better you know?).</p>', N'a-letter-to-my-future-self', 1, CAST(N'2021-08-11T15:31:23.6408361+07:00' AS DateTimeOffset), CAST(N'2021-08-11T15:31:23.6408361+07:00' AS DateTimeOffset), N'396f9912-b019-4f30-b961-f291ec88aabe', 0, CAST(N'2021-08-11 15:31:23.643' AS DateTime), CAST(N'2021-08-11 15:31:23.643' AS DateTime), 1, 1, 1)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'8c7e69da-0083-4e5a-9155-cccad1cc2085', N'The Times Of Our Lives.', N'Life It''s been a while since my last journal. I was so caught up with exam and my Helpx trip in Finland, it had been the only thing...', N'blog-5.jpg', N'It''s been a while since my last journal. I was so caught up with exam and my Helpx trip in Finland, it had been the only thing in my mind for days. I had never been so far up North until that trip to Uusi-Värtsilä, if I had a Russian visa at the time, I could go to Russia in a couple of hours. Uusi-Värtsilä is an abandoned village, it has less than 200 inhabitants, no public transport and the nearest supermarket is 7 km away. Yes, I was literally in the middle of nowhere. I enjoyed so much being in the nature in Finland. Water is never far away. Dense forests always await somewhere nearby. The first time I was in an open bog, I thought I was teleported in another planet. The working tasks in Dennis'' place were interesting and pretty relaxing as well. We harvested the wild garlics, went picking wild berries and mushrooms in the forest, made the traditional Finnish bread, took care of the green house garden and the house. One minus point though the sleeping arrangements there were chaotic, we had to share our rooms and my roommate was a self-centered character. I rarely found my privacy in the house so it drained my energy sometimes. When my roommate left, we all felt like we just woke up from a nightmare.', N'the-times-of-our-lives', 1, CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), N'42f248c5-4ada-490b-bd7b-2a5844761d79', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 100, 5, 20)
INSERT [common].[Posts] ([Id], [Title], [ShortDescription], [ImageUrl], [PostContent], [UrlSlug], [Published], [PostedOn], [Modified], [CategoryId], [IsDeleted], [InsertedAt], [UpdatedAt], [ViewCount], [RateCount], [TotalRate]) VALUES (N'ca54f293-23a2-4c34-998a-e3b1739b787a', N'The Incredible Rise of North Korea’s Hacking Army', N'The country’s cyber forces have raked in billions of dollars for the regime by pulling off schemes ranging from A.T.M. heists to cryptocurrency...', N'blog-2.jpg', N'The superior read instructions from a thin manual: early the next morning, a Sunday, they should go to any 7-Eleven and use their white card at the store’s A.T.M. They could not use a regular bank A.T.M., or one in another convenience store. The gangsters should each withdraw a hundred thousand yen at a time (about nine hundred dollars) but make no more than nineteen transactions per machine. If anybody made twenty withdrawals from a single A.T.M., his card would be blocked. Withdrawals could start at 5 a.m. and continue until 8 a.m. The volunteers were told to choose the Japanese language when prompted—an indication, Shimomura realized, that the cards were foreign. After making nineteen withdrawals, they should wait an hour before visiting another 7-Eleven. They could keep ten per cent of the cash. The rest would go to the bosses. Finally, each volunteer was told to memorize a pin.', N'the-incredible-rise-of-north-koreas-hacking-army', 1, CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), CAST(N'2021-08-11T14:46:59.4708968+07:00' AS DateTimeOffset), N'396f9912-b019-4f30-b961-f291ec88aabe', 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime), 147, 11, 41)
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'f6a1ff75-68ef-4fb0-80c7-08bd395b430c', N'0914e85f-7c0e-44ca-86d2-1a68458ea69f')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'9e53c727-0e2e-4f9d-9d7d-6da471911bca', N'0914e85f-7c0e-44ca-86d2-1a68458ea69f')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'c63f0ee0-f795-43d6-b5ef-885129c74dbe', N'0914e85f-7c0e-44ca-86d2-1a68458ea69f')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'a134bb30-321b-4343-9452-3f235b73a0b3')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'5b9259d4-391d-48bb-96db-7a40c01a4a84', N'a134bb30-321b-4343-9452-3f235b73a0b3')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'8c7e69da-0083-4e5a-9155-cccad1cc2085', N'a134bb30-321b-4343-9452-3f235b73a0b3')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'ca54f293-23a2-4c34-998a-e3b1739b787a', N'45261386-d442-4997-956d-8e09ef57ddaa')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'f45a23a8-6158-45e1-b8c3-0b14f10f8894', N'543266e3-3475-45d3-a44d-a940ad707222')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'5b9259d4-391d-48bb-96db-7a40c01a4a84', N'543266e3-3475-45d3-a44d-a940ad707222')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'f6a1ff75-68ef-4fb0-80c7-08bd395b430c', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'f45a23a8-6158-45e1-b8c3-0b14f10f8894', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'5b9259d4-391d-48bb-96db-7a40c01a4a84', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'8c7e69da-0083-4e5a-9155-cccad1cc2085', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'ca54f293-23a2-4c34-998a-e3b1739b787a', N'93255028-8ffe-41f2-b48a-bc4dc8d62df7')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'f45a23a8-6158-45e1-b8c3-0b14f10f8894', N'8f55db0e-1623-4ec3-8617-f829e114707c')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'744ffa38-c07f-4f13-9847-28f9a789bb1d', N'8f55db0e-1623-4ec3-8617-f829e114707c')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'566dc842-d4fb-4be0-bd48-5cea5b85c060', N'8f55db0e-1623-4ec3-8617-f829e114707c')
INSERT [common].[PostTagMap] ([PostId], [TagId]) VALUES (N'ca54f293-23a2-4c34-998a-e3b1739b787a', N'8f55db0e-1623-4ec3-8617-f829e114707c')
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'0914e85f-7c0e-44ca-86d2-1a68458ea69f', N'life style', N'life-style', N'life style Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'a134bb30-321b-4343-9452-3f235b73a0b3', N'food', N'food', N'food Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'45261386-d442-4997-956d-8e09ef57ddaa', N'tips', N'tips', N'tips Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'543266e3-3475-45d3-a44d-a940ad707222', N'study', N'study', N'study Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'93255028-8ffe-41f2-b48a-bc4dc8d62df7', N'recipe', N'recipe', N'recipe Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [common].[Tags] ([Id], [Name], [UrlSlug], [Description], [Count], [IsDeleted], [InsertedAt], [UpdatedAt]) VALUES (N'8f55db0e-1623-4ec3-8617-f829e114707c', N'travel', N'travel', N'Travel Tag', 0, 0, CAST(N'2021-08-11 14:46:59.487' AS DateTime), CAST(N'2021-08-11 14:46:59.487' AS DateTime))
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108090643380_InitialCreate', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5BDD4EE43614BEAFD4778872D556EC04D8AED4A2995DB103AC68175831B0EADDCA2466B0EA38D9D841A0AA4FD68B3E525FA1C7F9F74F324966A0DD05ADB4023BFE7C6C9FF39DE3E3C33F7FFD3D7D731752E716279C446CE6EE4CB65D07333F0A085BCEDC545CBFF8C97DF3FADB6FA6874178E77C2CBF7B29BF83918CCFDC1B21E23DCFE3FE0D0E119F84C44F221E5D8B891F851E0A226F777BFB676F67C7C300E10296E34CCF53264888B35FE0D779C47C1C8B14D19328C09417EDD0B3C8509D5314621E231FCFDCA3FDC92F29176F69B49C1C20815C679F1204722C30BD761DC45824900029F72E395E882462CB450C0D885EDCC718BEBB4694E342FABDFAF3BE0BD9DE950BF1EA8125940F5245E140C09D97C5CE78FAF051FBEB563B077B77087B2CEEE5AAB3FD9BB97324F0324AEE5D479F6C6F4E13F9A1BABDF9614CE65118466C528EDE72CC6FB62AD5000D92FFB69C794A459AE019C3A94810DD723EA45794F8BFE2FB8BE877CC662CA5B4292E080C7D4A03347D48A21827E2FE1C5F178B380E5CC753C779FAC06A58634CBEBC7729819F4F616E744571A50C5EE770F97F09001A05A6E13A27E8EE3D664B713373775FBD729D23728783B2A540BD64042C09068924C58367BD4CE882A6CB8E89E1C78798F800733F2171AE84AD93EF6CEFFED86BF6EEC98EF901A658E0EA84DE4611C5880D96FA9871F80D07FBA2440276C017241CB1F3718046229DA25BB2CC4C4AC3FC1071C15DE71CD3AC97DF9038A7AC89ECF9549BE6511285E7112D86541D9F2E50B2C452A2C8D6BB88D2C4D7C4997A350374F282841AC70972E4D3E3830B22E82608A17B96C54D9488C7B5C5102D31D0CE832F4DAA0DF87C8199787C7AFBCF783553787EB33ED5C9EDC3C1195B9BE8C058C935A9051A0D54F2D09A86F5549C41CDF6E3FD41C9F8767F507A8BBE125DA0658777CA7B354964A35D8AACC726416F8F0408E31C120C7C7AFEE8393E7D389F388FD2DA491D33F172F799D5C685B8ED24620D6D157AE94322FB9C473EC9A66E085433A9BA8A4316389DB49AEB55293DA816F00589812160EA99FB83B12D6D80D5E26AC09ADC55D01D57A7973396AB8EB3EFE7298539E23E0ACC43813D09D41660249C4080451085508B03C711264CFA22CC2731A25DA26B837AB29E14AA82D77B0E708C5900D2759D419F799B8187397F358DB659ABF666EA3594A9878E65AADDA90EAAB35C53B754A3A9C132AFD989D5BAB0DCA4644C0E5B81936271A517CD62F53BDB1DF192E3C22BF3824F75C925EE020BF5BC08062AA8CDD8B00B63FD2A4AC1340640BE9B2B06E73C648CCD364F1BDAD82C75F2467CD6F8C61AC0E94AB98A782A71AB651A7ABD8A6A1A10CDFDD629435D5DDF95E7DBD7B26AD3105698C2F0D52ACADF189ECBD57B8DA517A954BECE397B79D2B94C4E7B2DD9E9E9098A63883A1AD9EAA2C559E4A9EAF98BC5F02C6E9863783EB724732B69AB994494C0A55DEB95614B808F48C2854C915F21E9C6E741687CA61B788BE594B319366C9E556955E510F9733E4C4FDC4FDA4CA4DEC823585B28BD845C2636D5DA32347B3340142596107B1ED13464ED0EAB7D741E6137C7E72DFD11AA68B9095235F6C75182DF2696D2D11FAF119C2ADB53370FC06AC4A70A58A37DC08ED521AAB26775B38935F534CD31420243438D384AD5F95E169153D75AC690B9AEE186601FF6304650A43D9B0045537F0C33A9D984337B07285F95BC545658B5F64752B2934D30A5E3F14DBF913F54A4AA9B87AD314F21EA0BCC5BFB23D539C42652DDDA1FA919CB37B1BA62FC0E7D7826B6F589AD259E1BC06B32AC1E4E6BD651CFAE7D182316A92BC594F2A6672B7A182B526F1B668C505C9E568401C55736576FB10B793FB290BB72CD3237A29721491C7B62A531E710715A134ABDC4018861D2E8D73FF3CC8C5BA0FE49A531D56D50BBF54D8B1BD8EAC225E34A967FE23A20FB2D09E4756C710FFE37CC3561F199CE29C9428DF28313C4C835062DC81E28DCDDED9D5DADFAE9FF5389E4711ED09EE5488FFECA9232F239C5446606659492ACF5E2C26E51E2DFA0C47C7359EF41A5C4FD2E4477DF6FE291C42A68FE4C52838FAAD9B92262038F1992B8C5461E337A220D2B90F9F2B454A953E9A3A6EB94A56C4EBBB42A944D096E293A59CFC4366AAF4671C8189BD20B43465B945E18321AC82C0C31B5DA7854386601BE9BB97F64187BCEF16F9F6A982DE72C0157B8E76C3B7FAEFF12FBB51397112F7E11BCF5B4BDAB527140D808057D6A5A6EBD19F5D3F4D62B8EF9A9F5FAB1DA2ECA19D660BF1C622DE62B845F43880C61800C9B2ED3A85F5C1FBB92427D801CF17C3FAA14A3E375EC41CA2FBEB0720B6B6A63E8513DA09A64E504DAF4ABEB33C62A4BEF03DC80A2D833BA03A8F571F5C496736A9C957E4E9633FA6AB4A4EFC93DA292B4E6F436AE23F60A27B34EA2E55DC4A8DCEEA85ECA137B33D7CF6A92E1807327D9518B632B706AAD6F2AE183ABA8C2B616CFD84A9FDA2A9F6CA0D6921A9BA876DCAAA74D60E83C41F123575DE927A8D693AC2A3F322A96365956555545755457B5A4F4878A696722CB6BC3269757566D752DCFFE44A013B6F654F8F08B1B502E663E08006B35FEDE19F89293650D21FFFA99615FE1ABEA9B63761D95ACA949547EA2A76EB04070C142FB0904F7C817D0ED63CEB3F2F88F88A6F0C9617885836376968A3815B0641C5E5145F525FD76CD9FD5C4A9324FCFB2DB30DFC412404C22EF8867EC6D4A6850C97D64B965B440485E7F87A13D3F4B701360E0F715D269C47A0215DB57B9A30B1CC614C0F8195BA05B3C46B64B8EDFE325F2EFCB779D7690D507A16EFBF480A06582425E60D4E3E157D0E120BC7BFD2FB690F68BF63F0000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108090650066_UpdatePost', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5BDB6EE436127D0FB0FF20E86937705AB66703648DEE049EF63870321E0FDCF660DF06B444B789A52845A4BC36827C591EF249F9851475E54D6A49DD7632F1C080D1CDCB6191AC3A2C16AB7FFFF5B7F9770F31F5EE71C649C216FEC16CDFF7300B9388B0F5C2CFC5ED57DFF8DF7DFB8F2FE66FA2F8C1FB50B77B25DB414FC617FE9D10E95110F0F00EC788CF621266094F6EC52C4CE200454970B8BFFF9FE0E020C000E10396E7CD2F7326488C8B2FF07599B010A72247F43C8930E55539D4AC0A54EF1D8A314F518817FEE9F1EC879C8BD73459CF4E9040BE774C0902395698DEFA1E622C1148809447D71CAF4496B0F52A850244AF1E530CED6E11E5B892FEA86D3E7422FB87722241DBB1860A41AA241E0978F0AA5A99C0EC3E697DFD66E560EDDEC01A8B4739EB62FD16FE1209BC4EB247DF33073B5AD24C36D497B7DC8CD93289E384CDEADE7B9EDD66AF510DD020F9B7E72D732AF20C2F18CE4586E89EF73EBFA124FC113F5E25FFC36CC1724A55714160A8D30AA0E87D96A438138F97F8B69AC459E47B81DE2F303B36DD943EE5F4BECF097C7E0763A31B8A1B65087ABBCBFF350068149886EF9DA387B798ADC5DDC23FFCFA6BDF3B250F38AA4B2AD46B46C092A093C8723C7AD4EB8CAE68BEEE19183E3EC5C027988719494B25EC1CFC60FFF0DF8346EF1FEC8C9F608A056E76E87592508CD868A9CF18876F383A163512B003BE22F184954F233411E91DBA27EBC2A40CCCF70917DCF72E312D6AF91D494BCA9AC99A8FAD699E66497C99D0AA4B53F1F10A656B2C254A5CB5AB24CF42439C79D032402F2F48A8699C207BBE3C3EB82282EE8210FA4759DD2599785E5B8CD11A03ED3CF9D4A4DAC0992F3013CF4F6F7F1AAF160ACFEFB6A73AB97C38BA605B131D182BB925AD4093813E10FCFF6592B7DB79C6C4ABC3D1309730FE0E60AE80C1A8C4DA0EA626D72DD9E2A59C70ED1136FD90AB8F31F721571F814325BA42EB9E23B7AC352491856E298A1A9704838F59409876CA42C79777C87E76BA9FEEA0DF01C7BE1456DBE0B7779388D35FD7E86508891C739E84A4185A11A865527D166F58E4F5D26AA957B5F4A05AC01724058680A117FE97D6B2740136936B015B72D7410F7C935E2E58A93ADE7158C64996888728B23705D624D24B809170065E234114FC470E1C4798B0E98BB090A488F6896E741AC87A52A806DEAC39C129661148D7B70743C6551D0F7BFC661863B136ADCD3C509469808E15AADDAB0EFA61B9A56EE946D38215A7662F56E7C44A9392170D580A9C5593AB4FD1E202F2E0BAF85E735C9DCABCE253537289BBC242DF2F82810A5A33B6ECC29ABF8E52318D0550AEE686CE250F597D8BC533BA2A8BA50FAEF8674A1BA703672AE526E269C46DA669E9F526AA5120D4F53629439FDDD09997CBD7316BDB103698C2F8D96ACAAF742FE51A3CC7FA146954BE0DA4076524BD8EB8071D21F7F9394A53F03A94107C55E2ADCAF8FBF2ABD5F8D0745C6204217744A81B699B914492A135366AA5DB12E153927121E3FE37481EE3CB28B69A9906DE6139F568960DDB7B555B55DD457E2EBB99AF11B32E136917F214E616CB53424E13DB6AEDE85A3C84208A32878BBD4C681EB3EE03ABBB77E961ABFDCB92E1088DB7AC823485C37134E757C5D22A86E329CEA9B63C6DF1082CC53FD5C094F2112BD6BAA8DA9AB5C536D63C3034C772092C0DB5FC285DE7075944495D5B194371748D370477B7A731822A96AB025445C331EC48AD0A67D78E50BE2622ABCDB0291D8EA4855C5530ADE2F94D5F098A6A52B5C5E3E658C645CD0996A5C391DAC0A88AD4960E475222A32A94523C1C4B098FAA584AF108BD6F63A49AEEB7C5C3B1D4FB8A0AD6778FE946FB4CDE3B20EF0E9F750477CBABC378EA76F6FAECBE8C637D878D8FB6EFCF5634C68AF41B95ED075517C40DAE4ED5CAE5CE38EC42DE011D07987695B417629021491C77F04819738C389D41B341E200C43869CC2BAEBD67D64DD76CD2684C73E3356EB6F3EA96B939E3CCBA76964D7C0F64BF2791BC72AE1EC1C7884B4D58FD44979414EE54DDE01C31728B410B8A4718FF70FFE0D0485BFBEBA490059C4774601ED9B3BF24E58CFC946322A39FD213CBB67A5562F7280BEF5066BF2B6DF76854E3FE33460FFFDAC5439053D0F229A8059F946C7543C40E1E6C24718B9D3CD80C441A97D9F4E969A9966034444DB7C927DA9D7619E943BB12DC912DB49D89EDD45EADAC9E29366566F44CB62833A367329095D143D8F86959F93C5340AC6C9E2920762E8F6DA4D63BD0198BF0C3C2FFB9C038F2CEFEFBB185D9F32E3238D98FBC7DEF97ED1FCFFFEE3C6CB9BF9F040DBF6C67616BC37D715AEEBCE80DD3F4CE1B9BDDD4799BDA6C17F5085BB05F09B115F355C26F2144813042865D67D6B48FE4CF9DFCA2BF194FC8B898943DD3F3A0F92419339F58868C33523376AB9E504D8A0C1063F8CD2935539565F006EE4051DC01EA11D4FABC7AE20AA1297B65EE93638FFE365A3274E79E51493A43943BD71177529A9DDAD2F1CC6325DBF7249C9571CA851F1669E4B0C1E521D9933EE5CA49EB4C49ABE1A39BA4C176E63BB9B2D5BA92D55CA0CE2C2897A86EDCA6A64B60A83C47E93327CA993BA8A7006DCA18B392CC769909D724B2F524C475BC508C15D3CD448EC7935D4EAF4EB4EB9B9EFBC5C3246CE3E5F3E9273722C3CF7EDF00D6527E770F7CC9C9BA8590BFC26738D4F8AA6973C66E939A350D89EA2666240A0B04172C749C81738F4201D521E6BCF845C307447368F226BEC1D119BBC8459A0B98328E6FA8A6FA927EFBC62FD2187599E717C56D98EF620A20269177C40BF63A27346AE43E75DC323A2024AF7F8FA1BCDC4B3826C0C01F1BA477091B08542D5F731C5DE138A500C62FD80ADDE329B25D73FC16AF51F8583F5375836CDE087DD9E72704AD3314F30AA3ED0F5F4187A3F8E1DB3F00A1DEBB7A7E420000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108090654304_AddCommentObject', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5CDB6EE436127D5F60FF41D0D3EEC269D99E0CB031BA1378DAE3C4493C1EB8DB83BC0D68896E132B518A4439DD08F26579D84FCA2FA474E74D6ADDBAA7676C0C30B049F1B048569DE2A5CA7FFDF9FFE9776BCF359E7018119FCECC93C9B169606AFB0EA1AB9919B387AFFE6B7EF7ED3FFF317DEB786BE343F1DDABE43B6849A399F9C85870665991FD883D144D3C62877EE43FB089ED7B16727CEBF4F8F81BEBE4C4C200610296614C6F63CA8887D35FE0D7B94F6D1CB018B9D7BE83DD282F879A458A6ABC431E8E0264E39979793EF9318ED81BD75F4D2E1043A671EE1204722CB0FB601A88529F2106529EDD4578C1429FAE1601142077B909307CF780DC08E7D29F559FB71DC8F1693210AB6A5840D92095EF75043C7995CF8C2537EF35BF66397330776F618ED92619753A7F33738E185EF9E1C634E4CECEE66E987C284E6FB61893B9EF793E9D14AD8F0CF59BA352354083927F47C63C76591CE219C5310B917B64BC8FEF5D62FF84374BFF7F98CE68ECBABCB82030D4090550F43EF4031CB2CD2D7EC80771E5988625B6B3E4866533AE4D36BCEF63023FBF83BED1BD8B4B65B01A9B27FF1700A051601AA6718DD63F63BA628F33F3F4F56BD3B8246BEC142539EA1D256049D0888531EEDCEB5DE82EDC78D5D031FCB88B8E2F70648724C894B0B6F393E3D3AF5BF5DEDCD95574815DCC70B9426F7CDFC5887696FA8A46F01B76CE598104EC8097C4EB31F381837A22BD434F64959A9484F9DE8F58641AB7D84D6BA34712649435496A3E56A67919FADEADEFE64DCA8A8F4B14AE702291AFAB5DF871684BE24CAD8A011A792181EAC70949CBE7C7074BC2DC3108A1B997C5A31FB2FDDAA28756186867E7434BD4067C3EC394ED9FDE3E19AFA60A1F3D0EA7BA64FAB0734307131D182B79209540BD813E10FCDBDC8FABE5BCA2ECD56967985BE87F04982530989B600D8329C875205B3C170F57B9B0FE4EAE70637A2757B8C0D6128193028AD1BBDDBCF263E6FC2A81F872C5E90A953A9FDB24CE12AD1A760059AD343149A17E52D21ADD84B4F6FAF9587A1E06B2C6CFCFF77F9AB3C05B0F9126B7BC2B8F059A3670BE7245F9012307873BDF58E4BD2DF1BA696331D276A9E88C541AD19B909F8B93C8D8B62F1DCB4CA8E5EA5E640874DA8F08A1E10B09BE5C888CC92A83F7BFCF894C7AEDA8B47729C25EAB0D899C47916F93B46B4EA06A972B8EE22D758CC62D6FA65785F4A05AC01724008680AE67E67F9469A9032C075701561B6F11F4C494E9E58666AA639CDBD91DF61C4536B86E9562A07BB104180987C0C604B970B68F80E308652A7D116A9300B94DA24B8D5AB25E2254092FD75CE0005307A46B5A8336FDF28742B5FFB21B69B2B6CDCDD4E294A959C7044759A7117AAFC92944B1F76FAF64FA7351B3D27E7AFDD249BD07F5D2CD7F9B6E8B0DF727D1AC8A341B89463C930E642D918E2BB0743FD688553BB08CAC93EB45980A1CE6832BF667E9B5E35A77EABD8B70BEDF8B724F2D4B9EE02E30139980607032958350185719BF8892FB3005209BCD2D8DAB0B0E5580C2C2B740644E52699ECEBFD4949B6F517EEE6287FB467BF323EBF536AF588A5BCE94621ADBFC2007C12F99CC37E2E85A8C5C3CB1A803AF27EAED54CDCB5CAE71C3C8B5E4BC6DEE7A8C99DB57D5ACB4CA1F5B18A4FB0A0B9CC135CFE46A3DC6625B57324515756065610745788255139F30BD464100C7002E5E212F311659B0C2FCAB45F7777C2FC3B0EC48F39C5F4A5BF6C4FC10ADB0549BA884832F4918B12448E21E25FBEAB9E3299FC9BC58C316456F0AF5A96B553049D124F9396B26876E4CEA68A19AC84B185BA2D9E930B16ACA9AA669D4087251A839F3CE7D37F668BD8BAF6F9D1D79F9F659497B84F2F8CA839485ED7184D3288F2554B4C7E34E8BC2F454C51DB0B803A300C6957798B1EACC28CC5955AC624D2D4973949D94A2A1CAC653D4F956169151D72063D0F9891686A06FB61B23C81FBE7980BCA83D86FAACCDC3A9B51D94AF7CBE16465896B64712DEA77930A162FFA6CFBD200B5255C5DDC6983D22CB03CC4ADB2355AFC83C5255DA1E897B46E6A1B8E2F658DC5B328FC51577D0FBEA4159D0FDAAB83D167F81C083355D2CD4A3BD90F708E45D6EB1876D66F213578FBD4C5DCB43DDCAE4CF913C445ED48D7FE471D45D7FD4A348CF8B824189559D31B347440D6256D11D8FC8D32E54BCD8FC5E6DBEE69CDAC1DE932B92EEB6AE6D75A8767EA847168D5FEFECD35FACA88B1589B728EAD927BF14DA72BCC9BFD21D61347691DCFB689C86707DA44E442B43AABF67E7FAEC224EEDD3422B7100A29B34F2B596BA66CAED96FC49A931E52D97749B35CD6F96B6A7E428574DD927A601B23F1127B9665A6CE05CE1659AB0F8D59DBB243D42151F5C234A1E3068411A09619E1E9F9C4A793D879363634591E36A6EE6748936E2A2ED219C23A6E4D71893E4A128397D8583423BE8130AED4714AAC11DC322370ADC7F7968FDEF31A231B48266F1181578AF6C947BC246889A48889B8D1235D112A95BEAC7E7A7A54206461B351D9270319E7649F9156309AE49A7186662A3DAAB92F6D0C7A6E49487DE1625A73CF40652521E08ED3E2C25E1A10F8892EED007444D76508D547932BFA20E5ECFCCDF538C33E3EA978F15CC91711382673F338E8D3F8647B07DE93CACBD02FA2CA878271B0621DE7D20FD0831ECBD943A8318A4D0DA30F8B1F85F13F53E9ACFD204B9F7B6A26767D5CAA1F6F95AF467730418EC8E9F9D966BAF6FDA697AED3D8CFAA9F68E64BB5D1C06FDE7C20F102245E820C3D841EB5588DFBEE3CAC5E8AF1E21A7FD0287EB439376128CFE05059FB75AA61DA94819F6DA27D8BD7706C31E43CA3FA33072ED1DFD81E849E1B3E4EEB7C79D1FBA9ED43CA61CB29EE81E4FB8B592D749B3465F8C96B45DB93D2A49EDE3D4E83AA2CFDC500399E5E5D2E6656C1AB332B217AA9969A759BCB0C0D946AA21414097B8519BB751C03BF77E89AD8FC1AF49E968CAE8D081D76509E8F23DEAD23D74B8DA987ADD54E871CB9ABA0981CA6B14EC39D544D61031A07C5BFE8192B27038B924ADC4D3EF9734E16823A68B94D91E0D5923354FFA83862769A6106D30E6F08A6C94A6E1E94304643F27850AED7E701DD260D48000207BEE2F79829B89C8AA8248FEAE27C5B640F3E53757F4C12F9C8D2451F189FC74831972C0079C87706E4636836A1B47519A87FF01B9717A6F7C8F9D2B7A13B320663064ECDDBB8245275EABA9FF34D74794797A935E3445630C01C424C9F5CB0D7D1313D729E5BED41CE06B201277F83D86F26C2DC1BB026F6D4AA4773E6D09944F5FE9C597D80B5C008B6EE8023DE13EB2DD45F867BC42F6A688EBA807D9BE10E2B44F2F085A85C88B728CAA3DFC0A3AEC78EB6FFF06E161BF24D0560000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108091455238_UpdateDateTime', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5C5B6FE3B8157E2FD0FF20E8A92DB25692E962BB81BD8B8C33D94DBB990C6267B06F0346A21DA212A515A9D446D15FB60FFD49FD0B2575E54DB26EF67826C1008384143F1E92E77C879773F2BFDFFF3BFD7113F8D6338C090AF1CC3E9B9CDA16C46EE821BC9ED9095D7DF337FBC71FFEF887E93B2FD8581F8BEFDEF0EF584B4C66F613A5D185E310F70906804C02E4C621095774E2868103BCD0393F3DFDDE393B732083B01996654DEF134C5100D35FD8AFF310BB30A209F06F430FFA242F67358B14D57A0F024822E0C2997D7D39F97B42E85B3F5C4FAE0005B675E923C0E458407F655B00E39002CAA4BC78207041E310AF17112B00FE721B41F6DD0AF804E6D25F549FB71DC8E9391F8853352CA05C26551874043C7B93CF8CA336EF35BF7639736CEEDEB139A65B3EEA74FE66F61C50B80EE3AD6DA99D5DCCFD987F284F6FB61893791804219E14AD4F2CFD9B9352359806F17F27D63CF16912C31986098D817F627D481E7DE4FE036E97E13F219EE1C4F7457199C0AC4E2A60451FE2308231DDDEC3553E881BCFB61CB99DA3362C9B096DB2E1FD9420F6F37BD63778F461A90C4E6373FE7F01C0348A99866DDD82CD2F10AFE9D3CC3EFFF65BDBBA461BE8152539EA0346CC9258231A27B073AF0FB1BFF0937543C7ECC77D747C05891BA32853C2DACECF4ECFFFDAAAF7E6CE6EC815F42185E50ABD0D431F02DC59EA1B4CD86FD0BBA405126307B844418F998F3CD013E93D7846EBD4A414CC0F21A1C4B6EEA19FD6922714659435E1359F2AD3BC8EC3E03EF4F32665C5A72588D7904B149A6A176112BB8A3853A76280465EE050FD3881B77C797CB044D41F83109A7B593C85313DAC2D06600D19EDEC7D685C6D98CFA710D3C3D3DB67E3D554E1C9D370AAE3D307BD3BACD2D3DD6A453845748463268B56A8126B20DC4704FF350F936A696F307D73DE19E69E493102CC92B199CFB186C114443B90395E8AB7ABDC597F8757B834B3C32BDC616B8998C362746376C179E5A7CC11560289E59A03962A4DFEB7499C255837EC06B25A656278A17952D21AD384B4DE01E463E97930C81ABFBC7DC0E73917BC0B006A72D17BF25EF92AFF0C8107E3BDEF10F2DE9670D3B4431869DF537486AAE51CE803B959BEBA8AD607A3FEA4ACF2A191B17B512223D57E74C81ABE52E1EB15C998F4347817FC92C8A4D7BECA78BB22EDB8DA90C82521A18BD2AE0581AABDAE3C8A77D8B31A37BE995E15D233D5627C8122C610ACEB99FD176D5AEA00CBC15580D5F65B063DB3557AB9C399EA58976E76AB3D07C4657B009D6258F77209632418333646C067A77DC2380E61AAD317C22E8A80DF24BAD2A825EB71A14A78B5E60A46107B4CBAA63568D3AF7834D4FB2FBB51266BD7DC4C1D41999A754C7294751A61F69A8242142780F64A663E1D352BEDE7D72F93D407502FD3FCB7E9B6D8497E16CDAA48B39168E493E940D692E9B8024BF7638D58B503CBC89A5F38B2A980713EB8627F965E446E4C67DF0702F3FD1EC93DB52A39C75D402A330182CCC9540E42635C6DFC324AEEC334806C367734AEAE3974010A0BDF01913949AD793AFF4A5361BE65F985EB1DE11BE3FD8FAAD7BBBC62296E39539A69ECF2830284B8642ADFC8A36B3172F9C4A20FBC9EA87753B52873B9C60D233792F3AEB9EB3166615F55B3D23A7FEC6090EE2B2C7186D03C93ABF5188B6D5DC914551C8293052214010B4E4DC4C2F41644113B0608110C7989B5C8C217E6DF2CBABFEC071986E312C3037F296DD9130D63B0864A2D57090F5EA398501E36F108F8BE7AEE05DA672A2FD6B045D19B467DFA5A154C5234E13F67CDD4608E491D2D541379CDC6C6353B1D26D44DD9D0348D23013E880D67DE79E82701AE77F1F5ADB323AFD83E2B698F501E5F4590B2B03D8E741A15B1A48AF678C269519A9EAAB80396706094C084F20E33569D19A539AB8A75ACA9A3688EB693D23454DB78CA3ADFCA2232EA1A640C263FD1C210CCCDF66304F953B8089017B5C7D01FBA4538BDB683F2950FDAD208CBD2F648D28BB50826551CDEF485376549AAAAB8DB18B36765758059697BA4EA455944AA4ADB23098FC9229450DC1E4B785116B184E20E7A5F3D2B4BBA5F15B7C7122F1044B0A68B857AB457F21E81BCCB2DF6B0CD4C7EE2EAB197A96B79AC5B99FC515284C88B3AD881FCC22899825CD519337B4734206615DDF1903A61524537CE55D7AEEECAA761F55F6D7EB8CDD79C533BD83BBF22E96EEBC656C76AE7C77A6431F8F5CE3EFDD58ABA58917C8BA29F7DF24BA11DC79BFC2BD311C66017FCDEC740A0D2F5913E11AD0CA9FE9E5DE8B38B38B54F0BADC46110DDA451AFB5F435D36EB7D44F4A8D296FB994DBAC697EB3B43B4947BB6ACA3EB12D26FB33F2F835D362CBCE1541A6098BDFFCB98FD22354F1C12DC068059916A49110F6F9E9D9B992E9733C59370E219E6FB89933A5DEC88B7680708E04A3DF1288F843113F7DC583423BF03388DD2710EBC11DC322370ADC3F0560F3E731A2318C8266F1181578AFFC9447D43D1C4C8F9AE0C44D47899A6889D42D19E4CBD3522927A38D9A0E49C1184FBB948C8BB1043724580C33B151ED554B84E863536A12446107611EB1F921862ECAB255BF1B9C12312AB896208170F7E16BE9117D40B4E4883E207A6A846ECCDAD3FA0DF6E06666FF3BC5B8B06E7EFD54C19C587731DB015C58A7D67F8647BA7DED7C6DBC2AFA22287B2F1B0B293A7E184D1923DEC762684380FB685EC510CF3E2A81C9D1EDBDAC3D8378B5F42E96AE1D885FAE957F31C787C12EFAC569B9F1EAA79DA6D7DEE1E89F1AEF5776DBC571305F2EFC002152840E328C1DF05E85071E3A265D8E1CEB11AEDA2FE8B83EAC692F81EC5F51E07AAB65DA938A9421B37D02E57B673F1C301CFD0B0A4137DEEF1F899E143E4BED7E77CCFAB1EB49CD43CC31EB89E9E145582B759D0C6BF4D56849DB953BA092D43E6C8DAE23E6AC0F3D085A5D2E634EC7B631A3237BDD9AD96E9A01CC1638DB4835241798923E6A733E0A78EF312CB1CDF1FB35E9204DD92026F0BA0C0353AE485DAA8809D7188F6F9A0A336E59533721ACF21644074E535135440E46DF95BBA0A53B1C4F1E4A2BF1CCFB254328DB88A92665A64843C6494D38C0A0E1299A29452A8C39BC2293A56978E6F002D5CF296146FB1F5C87141A3D988091BDF07741999B21685D41F0BF128AA12BD17CF9CD0D5E8585B351242A3E519F7820051EF30197313B370397B26A171292E6F07F047E92DE253F42EF06DF25344A281B320C1E7DC9A2B9D76AEA3FCD1392659EDEA5174D648C21303111BF7EB9C36F13E47BA5DCD786037C0D0477873F41569EAD25F3AE8CB7B625D2FB10B704CAA7AFF4E24B18443E03237778019E611FD91E08FC05AE81BB2D6242EA41762F843CEDD32B04D63108488E51B567BF321DF682CD0FFF07C1B3951D1E570000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108091601278_AddUser', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5D5B6FE4B6157E2FD0FF20CC535B381E5FB2696AD8299CD975E276776DEC7883BE2D68893316A2CB44978D8D22BFAC0FFD49FD0B25454AE25DA4A4D18CB34680604D8A1F0FC9730E0F6FDFFCEF3FFF3DFFFB631C799F6196876972313B3E3C9A7930F1D3204CD617B3B2587DF5EDECEFDFFDF10FE76F82F8D1FBA9FEEE147F874A26F9C5ECA1283667F379EE3FC018E48771E867699EAE8A433F8DE72048E72747477F9B1F1FCF218298212CCF3BFF50264518C3EA0FF4E7224D7CB8294A10BD4B0318E5341DE52C2B54EF3D8861BE013EBC985D5D1EFEA3CC8BEFA3747DF81A1460E65D462140722C61B49A792049D2021448CAB38F395C16599AAC971B9400A2BBA70D44DFAD4094432AFD59FBB96D438E4E7043E66DC11ACA4752A5B123E0F129ED99B958BC57FFCE9A9E437DF706F571F1845B5DF5DFC56C010AB84EB3A799275676B68832FC21DFBD64300E17691CA7C9615DFAC093BF396854036910FEEFC05B94515166F02281659181E8C0BB2DEFA3D0FF277CBA4B7F86C9455246112B2E1218E5710928E9364B37302B9E3EC0156DC47530F3E67CB9B958B029C69421CDFBA10CD1BFDFA3BAC17D041B65981B8BE3FFD70048A39069CCBC77E0F12D4CD6C5C3C5ECE4D5AB9977153EC2A04EA1A81F931059122A54642574AEF563162DA3726DA818FD731B15BF86B99F851BA284DACA8F8F4EBEB6AADD5CD975FE1A46B080CD087D9FA6110489B3D4D7498EFE82C165512321EF00EFC2B847CF6F02D013E93DF81CAE2B9312306FD3BCC867DE071855B9F943B8212EEB10E77C6A4DF32A4BE30F69448B34199FEE40B68658A25495BB4CCBCC17C4399FB71EC0E81730543F9F804B7E79FEE02E2CA2311C82B996E5439A15D3DA620CD610B99DAD370DAB0D9AF30B9814D3BBB79DF9D54AE1F387E1AE0E771F0C6E12D13DDDAC563976118E70C864C355D88A3510EEA710FEBA48CB7668AF93E2F4C419E603926204983BE4CD228C350CA676B4033DC79732DBB5D359FF09AF9ED2D4135E3D1D5A4B84262CE46ED45330CDFC4426C25620365D9A80B94CD5FC6B12E70EAC0DD100C9153A0627AA3BA5CA517588750440DBD27361400A7F7971C06ED6056F62109AA6E82DCD5E74947F842080D9D623045ADB1D7C34450823C53D7565613B9C03E7406C962F5385F5C2A8BF5316FDA1D263F77289C8A9F67387A8E08B2B7CD92219D33D0D8E82BF2467D22BAE52EEAE7011572F27721DC02A09839ABCC9BB6653F732DFBC87C5615DF090405E6508EED734FBF990453CF0ACCBB5DEE7C4D6FB9C1EDFAF4EBF7DF50D084EBFF91A9EBE9ADE13A94CEAE4DB6DD873A7FBFA66945AB57AFB1159955A6FD9F1FE443F6B1558CE956644C52783E6C51A0F438DAFD635EAFEAB369654566FE5A7B8417D2CA1AE626A6BA8E5DD6EBDD61A87BBC131145B42BFCCB0AEE0B2CF3A1A9B6ED4BBD695B64ED0A296459AACC22C1E612714E439F201C18F207F18210AECD890A74AB52C40BCD97A6DB70F6902DF97F1BD71B53D7A5DA30DCDDDAFE915F08B347B93E05283F1DEA6FECF6959BC49021C277E2C7C396CB40418459C4BDF87797E859419062304E8D84FED3A085944208CD5510816EF539DDF861F4CB21477B079AE9BB56FD375981824A9F3054948B25A129AE72A0946300842B30539AA54B518246BB400ACEADFF123B00A76FF43B06133ABCE50996E5C22F7057F8009CCF04AF5161405CC9276046C8C7A173379357CB8D2AD4F1C554D3F81A81CBBAA5ED650D9F8F8D650C1EEBF355462A2E4CF61B5416FB12EA93F46F056DFAB973CDD36274836B53970CD9CBAF2697C80CE5C2EF33CF5C3CA0A981DB2F6F095171DC5569EF12496B4A1DE4E43CD406A1D6E9022A3AA2F667F91FA4207D8ECB6B580ED79300F7A3C13F5F226217B99DEA54FAE592E40EE83401E09D427019F82541966D868015E82E4C814C3A490F53E4CFC70032293E84221CBE9090BD5C08B39AFE10626D8A598C6C0A65EF6AE825C7F538DD0595D7D733E6794C9AC63DCC98D4E23D4C7388C42D447D2F64AA63EAE372BEDEEF54B25F504EAA5EA7F9B6AEBA3CD9D6856BB8B6F7434FC5589815E8B3F1F68C1AA0342239643C314DBBC3AA14C7BBEAD74FCC9C31675DE2898A2DBE4FDE3AEF1E86555FA5E9AC0B6F43D6153B97ABB78220B6357FABA81562EFBDB1126FBB593A89C6A9341A36B74A9BC15655374C8045AA668BC4DADDA838BC9D48B6EDF180755DCCBD99D7A093B471AF5A26BCFEDA917DF2153A917DFF8E7A15E6453CE38A6C20EDDEE948BDF0F9C7E9A947B632ACDE25ABE678A4516D3F885022A01332A407D8458BD5C78545D964522D2BDA69C2EDBC5C1C7B84B58F02BB510EF21B70B7869452CC5A73C0ABDF422019068B7A3707B2F5A16A05E817540905B3552F12A3EEE284AF7CFA5B27CF4DA01229A8A09B035A70E507AD54202220EC241A2FAD4C428120D4E1C60EB2310232C9D94045846E97925622EE533DF286FED8B36D8B575D434A55157C98CBB368B1808D66E448FCBB7CEA2E5FC3D53B9E1FADD8CEEFD0C56E6C6D00C2D57EE6074F55D8F3633B7E134232D2FB23B96D9EE23CC2DAC99E244AEC16D54DD9C921BDBB5F0B65D7A33F2531F6468BE61A5CCE028FCDAE04EE10E72E5DED0AEFE3AD77F8CDCB4AF0DED572DDB340DAF651DA7E5B5D7D4B45CB530E95C9AB8B75C5851685A5ECB3A4ECBA902691AAE0899BB8266F766F3B1EE488A5E9F7C34C15A93773E27E41134E17CAE6199387F07369B305933AC1334C55B12CA89C5574B7736869860CC7DAE5FC5D0B2A9A94833B086422E9E10027815667981A92EEE013EF75904B1F499189A6AE288BA3629FA9447AE8E2AEA22F8DFA49848C071A80B0ADA8EBC426DC3F35AD54C284FE48AA21EE6FE0011C814E7F78B342AE344BF14D19726576CD8F224C51EA17972C0823489F638DC0B02168BCBB0C7636EF873DDD3263B603197FC393026DDA1C7DA7BFE5C9FB5C932D6F95CD01C69CD2769A8B4F0E675DECA2248E032C8185451A28521A88B6DC708287D010B4093EC31647202164ECE7550BE8684806B61936A8FC4B10CB0605CC6F4A6CFF0007052B5C96E6D245400620349AA3D52CB02C022B5A9F6480C01000BC524DB63312C002C1693ECA0F72D1500A7FB6DB23D167BC6CE8299CEDEF5682FCE7B04E7DD2CB087053374D3AB472CA32BB9AFA10CBDF0CF42D024073BE05F8573A6C067396392B7DF0A4492E18E178A1DC665B8F95C71EC74B7220CA3FF62F3C36D5EB34BE560EF7897DADDD695A5F6D5CEF775C9A298D79DE7F4172B1AC18A74BB3F0E66C41DD8B8DB93B9F8AE0D6B47C3226F8B8D3244CD1158FF61D24368AD811EDE72A6A039D0D5A3D437A3B8A580E6B6D4CE864D7788E03054D521A3FBF0A88B6DC77AC6081EC5B7A0121893E7109E716F42B9208DCB71D8ECE01F7E723B1D7C968394ECF34E4E4836A3179EA647D55F382C9FA5079DDC2A5ACAB547563CED64A115D93DB015328B79F6A88AD79F2CB022DB2170689E828ACE728FE727ED9961CF098A5C881836436930B6E30FC799E098977B5C58DC263B62D1B77912184DDF4B5DD29EC2F6D425720B66982E6930F45E877BF1C63B1DE3333D3D26F78C8D73ECA6677C7A3C378DDDB65EF007BCF2B10CBDADD271F242BF529DAE2896ECF8805AB1B7C3DD6B913BC2CA79E85FC93075BA88A3BD2869250E827093463C7197C74C3A78173F693486A6347F3707EFF4D0BBFB371FA45370F2C9CCAB551F05624F790163A209CB5FA2451456A73BF507EF4012AE20D282EAB9EDECE4E8F844F8E188FDF91187799E0791E2D200CBD7AA7EC039C1ABF932097F296158B9C655883DD800AAADE433C8FC0790C95C81C388006BDC3FC5E0F1CF6390FB290525F47E2D78AF9F3BB80FDDD94565123EBCA7548C42C26789E4F6DB02CF4F4BEF588A7F1B351DC2E83F9E760904FE6309AEE0EB1F6662A3DAABC4ABDFC7A6444EFDDA0E524A007C9B413F243F7EF4D7C10CFBA3824B7CFB61E2DE7C896DBF0F88C4B5DF074466DA978D597A78719D04F0F162F6EF0AE3CCBBFED7A716E6C0BBC9500470E61D79BF0D274EFDBDFB6BE529F6B370D95B092C3852BC616E4A49A03E968756F0A58F36AB28E8D14775603C597A2F6B27102F96EE62E9D282F8CBB5F267B37C183C457F715AAE3F599E42DDD5038F199F4651FB2ECF881B8DFF55251F78D7F9C7CAFCCEBC3BA46BD8478AF492E3F6B98122BA11F4B767C1BD6CDFE568322245F9C968E0F0F38CCC4ED290A203A471E3697EBE26A60CF54C26D29FEEB8D702554175AC9DA87AD3190F425450168F85374A17EA2889FB6069E9885513984D63D5F4C47D44D35213F709184462627BDF5397DCE1E4A338019EC22555FDDCC91D3B884872D7139244313BC8D0651A5907B851A96287C525CF8C8275B4A9F35666581D0D7B977AEF74CAD1733DAD3D29963F559EE2768FFD7EECAF50E10708512138C83036296ECB8EA264E99984348A909448243F5BE18632BCEBB699313D57B2DBDF11B9ADD5306D49451ADA261595D35614C57AF0C6A1AC7D4634B5CA5B447BA227F59C2556DFCD6BBBEF7AA2B9EEB5CF7AA2BADEC58C95384E8A31FADD6889EDC84DA824DAEB7313E8484F66E87D21836EF780351C751371404F49FB6C786165BB413D9172D9B23DEF8A2355C191A851A36DD33B4FAD3FBA07100E8721FBC4E7BC0F0A44F77C340AB46D02E7A91548F7EA611F15A89BB1791FF46757D3D82EB4C77AFADA392BB3CC90278E257D06225E9D37312E93F70517331FAD38AB6B1C6493C9C03B2B56431672521524B9860FEED3065B4DED2A495F2FE465E1EB1C15B88E7C56C5E5ACA37256E12AA95A454C3EFA94C0F96C552DE4F7D6D4CC90BACA5A9BD456D87EA2AF544F4929564C9C925419493657E0D62A1AE9189B45BF3157ABA15635D54D274963DDF41B73DD1A72539515A955B2C9D1982ACD7F07A457D95BE6BF16FD0BCF7329FB4971334878B626CF56BB22B8B6124FBD13C9F68486547E00877543496BA0B2D63CE71BD43C4139B997866336AF66CC35354FFD3C50DC41620455083961E3B6CCCDAD641756D1FE77C47A0A14ED0F08EC908B5B2263B66E263797681ED08FD4D031A8B7FB37949BB834AFBB476AE870A6EDFECD1C536D1D98B5E587BC28CC2F137C0D8AFCF51AE6E1BA8538479809F4B900BFF9E63A59A5F53A4390A8FE447C5E050B10A0E8FF322BC215F00B948D6F4055BFB45ADD2AC1F7F0EE61709DDC94C5A62C5093617C1F71B3315EAF98EAAFE8C37999CF6FAA4BDEF9184D406286F8E6D84DF27D19464123F795E2585B03811742F4BE111ECB02DF3B5A3F3548EFD3C41288765FB37EBB83F1264260F94DB2049F611FD990FABD856BE03FB557507420DD03C177FBF9EB10AC3310E714A32D8FFE443A1CC48FDFFD1F55C87B01E9A00000, N'6.4.4')
INSERT [dbo].[__MigrationHistory] ([MigrationId], [ContextKey], [Model], [ProductVersion]) VALUES (N'202108110353018_ChangeSchema', N'FA.JustBlog.Data.Migrations.Configuration', 0x1F8B0800000000000400ED5D5B6FE4B6157E2FD0FF20CC535B381E5FB2696AD8299CD975E276776DEC7883BE2D68893316A2CB44978D8D22BFAC0FFD49FD0B25454AE25DA4A4D18CB34680604D8A1F0FC9730E0F6FDFFCEF3FFF3DFFFB631C799F6196876972313B3E3C9A7930F1D3204CD617B3B2587DF5EDECEFDFFDF10FE76F82F8D1FBA9FEEE147F874A26F9C5ECA1283667F379EE3FC018E48771E867699EAE8A433F8DE72048E72747477F9B1F1FCF218298212CCF3BFF50264518C3EA0FF4E7224D7CB8294A10BD4B0318E5341DE52C2B54EF3D8861BE013EBC985D5D1EFEA3CC8BEFA3747DF81A1460E65D462140722C61B49A792049D2021448CAB38F395C16599AAC971B9400A2BBA70D44DFAD4094432AFD59FBB96D438E4E7043E66DC11ACA4752A5B123E0F129ED99B958BC57FFCE9A9E437DF706F571F1845B5DF5DFC56C010AB84EB3A799275676B68832FC21DFBD64300E17691CA7C9615DFAC093BF396854036910FEEFC05B94515166F02281659181E8C0BB2DEFA3D0FF277CBA4B7F86C9455246112B2E1218E5710928E9364B37302B9E3EC0156DC47530F3E67CB9B958B029C69421CDFBA10CD1BFDFA3BAC17D041B65981B8BE3FFD70048A39069CCBC77E0F12D4CD6C5C3C5ECE4D5AB9977153EC2A04EA1A81F931059122A54642574AEF563162DA3726DA818FD731B15BF86B99F851BA284DACA8F8F4EBEB6AADD5CD975FE1A46B080CD087D9FA6110489B3D4D7498EFE82C165512321EF00EFC2B847CF6F02D013E93DF81CAE2B9312306FD3BCC867DE071855B9F943B8212EEB10E77C6A4DF32A4BE30F69448B34199FEE40B68658A25495BB4CCBCC17C4399FB71EC0E81730543F9F804B7E79FEE02E2CA2311C82B996E5439A15D3DA620CD610B99DAD370DAB0D9AF30B9814D3BBB79DF9D54AE1F387E1AE0E771F0C6E12D13DDDAC563976118E70C864C355D88A3510EEA710FEBA48CB7668AF93E2F4C419E603926204983BE4CD228C350CA676B4033DC79732DBB5D359FF09AF9ED2D4135E3D1D5A4B84262CE46ED45330CDFC4426C25620365D9A80B94CD5FC6B12E70EAC0DD100C9153A0627AA3BA5CA517588750440DBD27361400A7F7971C06ED6056F62109AA6E82DCD5E74947F842080D9D623045ADB1D7C34450823C53D7565613B9C03E7406C962F5385F5C2A8BF5316FDA1D263F77289C8A9F67387A8E08B2B7CD92219D33D0D8E82BF2467D22BAE52EEAE7011572F27721DC02A09839ABCC9BB6653F732DFBC87C5615DF090405E6508EED734FBF990453CF0ACCBB5DEE7C4D6FB9C1EDFAF4EBF7DF50D084EBFF91A9EBE9ADE13A94CEAE4DB6DD873A7FBFA66945AB57AFB1159955A6FD9F1FE443F6B1558CE956644C52783E6C51A0F438DAFD635EAFEAB369654566FE5A7B8417D2CA1AE626A6BA8E5DD6EBDD61A87BBC131145B42BFCCB0AEE0B2CF3A1A9B6ED4BBD695B64ED0A296459AACC22C1E612714E439F201C18F207F18210AECD890A74AB52C40BCD97A6DB70F6902DF97F1BD71B53D7A5DA30DCDDDAFE915F08B347B93E05283F1DEA6FECF6959BC49021C277E2C7C396CB40418459C4BDF87797E859419062304E8D84FED3A085944208CD5510816EF539DDF861F4CB21477B079AE9BB56FD375981824A9F3054948B25A129AE72A0946300842B30539AA54B518246BB400ACEADFF123B00A76FF43B06133ABCE50996E5C22F7057F8009CCF04AF5161405CC9276046C8C7A173379357CB8D2AD4F1C554D3F81A81CBBAA5ED650D9F8F8D650C1EEBF355462A2E4CF61B5416FB12EA93F46F056DFAB973CDD36274836B53970CD9CBAF2697C80CE5C2EF33CF5C3CA0A981DB2F6F095171DC5569EF12496B4A1DE4E43CD406A1D6E9022A3AA2F667F91FA4207D8ECB6B580ED79300F7A3C13F5F226217B99DEA54FAE592E40EE83401E09D427019F82541966D868015E82E4C814C3A490F53E4CFC70032293E84221CBE9090BD5C08B39AFE10626D8A598C6C0A65EF6AE825C7F538DD0595D7D733E6794C9AC63DCC98D4E23D4C7388C42D447D2F64AA63EAE372BEDEEF54B25F504EAA5EA7F9B6AEBA3CD9D6856BB8B6F7434FC5589815E8B3F1F68C1AA0342239643C314DBBC3AA14C7BBEAD74FCC9C31675DE2898A2DBE4FDE3AEF1E86555FA5E9AC0B6F43D6153B97ABB78220B6357FABA81562EFBDB1126FBB593A89C6A9341A36B74A9BC15655374C8045AA668BC4DADDA838BC9D48B6EDF180755DCCBD99D7A093B471AF5A26BCFEDA917DF2153A917DFF8E7A15E6453CE38A6C20EDDEE948BDF0F9C7E9A947B632ACDE25ABE678A4516D3F885022A01332A407D8458BD5C78545D964522D2BDA69C2EDBC5C1C7B84B58F02BB510EF21B70B7869452CC5A73C0ABDF422019068B7A3707B2F5A16A05E817540905B3552F12A3EEE284AF7CFA5B27CF4DA01229A8A09B035A70E507AD54202220EC241A2FAD4C428120D4E1C60EB2310232C9D94045846E97925622EE533DF286FED8B36D8B575D434A55157C98CBB368B1808D66E448FCBB7CEA2E5FC3D53B9E1FADD8CEEFD0C56E6C6D00C2D57EE6074F55D8F3633B7E134232D2FB23B96D9EE23CC2DAC99E244AEC16D54DD9C921BDBB5F0B65D7A33F2531F6468BE61A5CCE028FCDAE04EE10E72E5DED0AEFE3AD77F8CDCB4AF0DED572DDB340DAF651DA7E5B5D7D4B45CB530E95C9AB8B75C5851685A5ECB3A4ECBA902691AAE0899BB8266F766F3B1EE488A5E9F7C34C15A93773E27E41134E17CAE6199387F07369B305933AC1334C55B12CA89C5574B7736869860CC7DAE5FC5D0B2A9A94833B086422E9E10027815667981A92EEE013EF75904B1F499189A6AE288BA3629FA9447AE8E2AEA22F8DFA49848C071A80B0ADA8EBC426DC3F35AD54C284FE48AA21EE6FE0011C814E7F78B342AE344BF14D19726576CD8F224C51EA17972C0823489F638DC0B02168BCBB0C7636EF873DDD3263B603197FC393026DDA1C7DA7BFE5C9FB5C932D6F95CD01C69CD2769A8B4F0E675DECA2248E032C8185451A28521A88B6DC708287D010B4093EC31647202164ECE7550BE8684806B61936A8FC4B10CB0605CC6F4A6CFF0007052B5C96E6D245400620349AA3D52CB02C022B5A9F6480C01000BC524DB63312C002C1693ECA0F72D1500A7FB6DB23D167BC6CE8299CEDEF5682FCE7B04E7DD2CB087053374D3AB472CA32BB9AFA10CBDF0CF42D024073BE05F8573A6C067396392B7DF0A4492E18E178A1DC665B8F95C71EC74B7220CA3FF62F3C36D5EB34BE560EF7897DADDD695A5F6D5CEF775C9A298D79DE7F4172B1AC18A74BB3F0E66C41DD8B8DB93B9F8AE0D6B47C3226F8B8D3244CD1158FF61D24368AD811EDE72A6A039D0D5A3D437A3B8A580E6B6D4CE864D7788E03054D521A3FBF0A88B6DC77AC6081EC5B7A0121893E7109E716F42B9208DCB71D8ECE01F7E723B1D7C968394ECF34E4E4836A3179EA647D55F382C9FA5079DDC2A5ACAB547563CED64A115D93DB015328B79F6A88AD79F2CB022DB2170689E828ACE728FE727ED9961CF098A5C881836436930B6E30FC799E098977B5C58DC263B62D1B77912184DDF4B5DD29EC2F6D425720B66982E6930F45E877BF1C63B1DE3333D3D26F78C8D73ECA6677C7A3C378DDDB65EF007BCF2B10CBDADD271F242BF529DAE2896ECF8805AB1B7C3DD6B913BC2CA79E85FC93075BA88A3BD2869250E827093463C7197C74C3A78173F693486A6347F3707EFF4D0BBFB371FA45370F2C9CCAB551F05624F790163A209CB5FA2451456A73BF507EF4012AE20D282EAB9EDECE4E8F844F8E188FDF91187799E0791E2D200CBD7AA7EC039C1ABF932097F296158B9C655883DD800AAADE433C8FC0790C95C81C388006BDC3FC5E0F1CF6390FB290525F47E2D78AF9F3BB80FDDD94565123EBCA7548C42C26789E4F6DB02CF4F4BEF588A7F1B351DC2E83F9E760904FE6309AEE0EB1F6662A3DAABC4ABDFC7A6444EFDDA0E524A007C9B413F243F7EF4D7C10CFBA3824B7CFB61E2DE7C896DBF0F88C4B5DF074466DA978D597A78719D04F0F162F6EF0AE3CCBBFED7A716E6C0BBC9500470E61D79BF0D274EFDBDFB6BE529F6B370D95B092C3852BC616E4A49A03E968756F0A58F36AB28E8D14775603C597A2F6B27102F96EE62E9D282F8CBB5F267B37C183C457F715AAE3F599E42DDD5038F199F4651FB2ECF881B8DFF55251F78D7F9C7CAFCCEBC3BA46BD8478AF492E3F6B98122BA11F4B767C1BD6CDFE568322245F9C968E0F0F38CCC4ED290A203A471E3697EBE26A60CF54C26D29FEEB8D702554175AC9DA87AD3190F425450168F85374A17EA2889FB6069E9885513984D63D5F4C47D44D35213F709184462627BDF5397DCE1E4A338019EC22555FDDCC91D3B884872D7139244313BC8D0651A5907B851A96287C525CF8C8275B4A9F35666581D0D7B977AEF74CAD1733DAD3D29963F559EE2768FFD7EECAF50E10708512138C83036296ECB8EA264E99984348A909448243F5BE18632BCEBB699313D57B2DBDF11B9ADD5306D49451ADA261595D35614C57AF0C6A1AC7D4634B5CA5B447BA227F59C2556DFCD6BBBEF7AA2B9EEB5CF7AA2BADEC58C95384E8A31FADD6889EDC84DA824DAEB7313E8484F66E87D21836EF780351C751371404F49FB6C786165BB413D9172D9B23DEF8A2355C191A851A36DD33B4FAD3FBA07100E8721FBC4E7BC0F0A44F77C340AB46D02E7A91548F7EA611F15A89BB1791FF46757D3D82EB4C77AFADA392BB3CC90278E257D06225E9D37312E93F70517331FAD38AB6B1C6493C9C03B2B564316725215245903AF6677951A50AFE565F9EB1C9DF81A0A5A15A3B38ED05903ADE46C1561F93054C2E7B3EB8A82FBB4A985FCF09A9A225257596B9CDA0ADB4FF495EAB929C58A8977922A23C9E60ADC5A45431E63B3E837E66A351CABA6BAE96C69AC9B7E63AE5BC372AA3227B556363906A342F9EF80F43C7BCB44D8A2A3E1092F658729EE0A09EFD7E4696B574CD756E2A9B724D99ED0B0CB0F20B36EB8690D9CD69A777D839A272827F7E470CCE6D5D4B9A6E6A9DF098A5B498CA00A21276CDC9649BA9534C32AFEFF8EA04F81A2FD25811D92724BACCCD6CDE4E612CD4BFA911A3A060777FF86721397E699F7480D1D4EB9DDBF9963AAAD03C5B6FCA217C5FB6582EF4391BF5EC33C5CB710E70833813E17E937DF5C27ABB45E700812D59F88EFAC600102B40CB8CC8A7005FC0265E3AB50D54FAE56D74BF085BC7B185C273765B1290BD46418DF47DC6C8C172EA6FA2B1E715EE6F39BEAB6773E4613909821BE4276937C5F8651D0C87DA538DFD640E01511BD7884C7B2C01790D64F0DD2FB34B104A2DDD72CE4EE60BC8910587E932CC167D84736A47E6FE11AF84FED5D141D48F740F0DD7EFE3A04EB0CC439C568CBA33F910E07F1E377FF0765F873E3F2A00000, N'6.4.4')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'd1ab8be1-b005-49f5-801f-1092d88bb7a6', N'Admin')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'b2bc84d3-a6ae-4f8a-b4ea-1fd17de11b2e', N'Contributor')
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'870190bd-646e-4d2d-ba3e-0d66d65a038f', N'User')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'42d83825-2b99-44a5-8a0d-6f61a2309b5c', N'870190bd-646e-4d2d-ba3e-0d66d65a038f')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'bfb34016-6b75-4875-9677-01fbf59cca1d', N'b2bc84d3-a6ae-4f8a-b4ea-1fd17de11b2e')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2df75979-3f54-4bbb-a192-83407ae0d2ae', N'd1ab8be1-b005-49f5-801f-1092d88bb7a6')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'2df75979-3f54-4bbb-a192-83407ae0d2ae', N'admin@example.com', 0, N'ADZ/AYNQMyKODIaqYVj7gSQyOfCcl4c+0uTmDtKfn5Z7rUbXnypyu5VanwJiTOwcdw==', N'e2090e76-96ba-41e1-a35d-7bb2ef787040', NULL, 0, 0, NULL, 0, 0, N'admin@example.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'42d83825-2b99-44a5-8a0d-6f61a2309b5c', N'user@gmail.com', 0, N'AD1a6ggbKLFfdYAEgg1AXFdj5YTZcT4+IYcShrFVk75BzJxKfEnuVxvvUOPyFyj+2g==', N'4617cd53-c9f3-4287-b407-7a4816241a19', NULL, 0, 0, NULL, 1, 0, N'user@gmail.com')
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'bfb34016-6b75-4875-9677-01fbf59cca1d', N'contributor@gmail.com', 0, N'AEfmOEHvbi+WQ5W3PAMc1VZgOHCSifTEyYiLFENBQtk/iZdzNDMkJRgrYCMbJjY0TQ==', N'a7ad0ba4-6aca-441a-876a-672101c31c8d', NULL, 0, 0, NULL, 1, 0, N'contributor@gmail.com')
/****** Object:  Index [IX_PostId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_PostId] ON [common].[Comments]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_CategoryId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_CategoryId] ON [common].[Posts]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PostId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_PostId] ON [common].[PostTagMap]
(
	[PostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TagId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_TagId] ON [common].[PostTagMap]
(
	[TagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UserNameIndex]    Script Date: 8/11/2021 3:36:48 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [common].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Comments_dbo.Posts_PostId] FOREIGN KEY([PostId])
REFERENCES [common].[Posts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [common].[Comments] CHECK CONSTRAINT [FK_dbo.Comments_dbo.Posts_PostId]
GO
ALTER TABLE [common].[Posts]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Posts_common.Categories_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [common].[Categories] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [common].[Posts] CHECK CONSTRAINT [FK_dbo.Posts_common.Categories_CategoryId]
GO
ALTER TABLE [common].[PostTagMap]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PostTagMap_dbo.Posts_PostId] FOREIGN KEY([PostId])
REFERENCES [common].[Posts] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [common].[PostTagMap] CHECK CONSTRAINT [FK_dbo.PostTagMap_dbo.Posts_PostId]
GO
ALTER TABLE [common].[PostTagMap]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PostTagMap_dbo.Tags_TagId] FOREIGN KEY([TagId])
REFERENCES [common].[Tags] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [common].[PostTagMap] CHECK CONSTRAINT [FK_dbo.PostTagMap_dbo.Tags_TagId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
USE [master]
GO
ALTER DATABASE [JustBlog] SET  READ_WRITE 
GO
