USE [master]
GO
/****** Object:  Database [AromaDom]    Script Date: 11.11.2026 0:07:52 ******/
CREATE DATABASE [AromaDom]
GO
USE [AromaDom]
GO
/****** Object:  Table [dbo].[MaterialProducts]    Script Date: 11.11.2026 0:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialProducts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaterialId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [decimal](10, 4) NOT NULL,
 CONSTRAINT [PK_MaterialProducts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaterialTypes]    Script Date: 11.11.2026 0:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[LossPercent] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_MaterialTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_MaterialTypes_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Materials]    Script Date: 11.11.2026 0:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Materials](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MaterialTypeId] [int] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[UnitPrice] [decimal](10, 2) NOT NULL,
	[Unit] [nvarchar](20) NOT NULL,
	[PackageQuantity] [decimal](10, 3) NOT NULL,
	[StockQuantity] [decimal](10, 3) NOT NULL,
	[MinQuantity] [decimal](10, 3) NOT NULL,
 CONSTRAINT [PK_Materials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Materials_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductTypes]    Script Date: 11.11.2026 0:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Coefficient] [decimal](6, 2) NOT NULL,
 CONSTRAINT [PK_ProductTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_ProductTypes_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 11.11.2026 0:07:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Article] [nvarchar](20) NOT NULL,
	[ProductTypeId] [int] NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[MinPartnerPrice] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_Products_Article] UNIQUE NONCLUSTERED 
(
	[Article] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[MaterialTypes] ON 
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (1, N'Соевый воск', CAST(0.12 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (2, N'Пчелиный воск', CAST(0.18 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (3, N'Ароматическое масло', CAST(0.25 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (4, N'Краситель', CAST(0.08 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (5, N'Фитиль', CAST(0.03 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (6, N'Стеклянная тара', CAST(0.04 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (7, N'Керамическая тара', CAST(0.06 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (8, N'Декор', CAST(0.10 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (9, N'Упаковка', CAST(0.05 AS Decimal(6, 2)))
GO
INSERT [dbo].[MaterialTypes] ([Id], [Name], [LossPercent]) VALUES (10, N'Этикетка', CAST(0.02 AS Decimal(6, 2)))
GO
SET IDENTITY_INSERT [dbo].[MaterialTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] ON 
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (1, N'Классическая свеча', CAST(1.00 AS Decimal(6, 2)))
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (2, N'Премиальная свеча', CAST(1.15 AS Decimal(6, 2)))
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (3, N'Подарочный набор', CAST(1.30 AS Decimal(6, 2)))
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (4, N'Интерьерная свеча', CAST(1.20 AS Decimal(6, 2)))
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (5, N'Мини-свеча', CAST(0.80 AS Decimal(6, 2)))
GO
INSERT [dbo].[ProductTypes] ([Id], [Name], [Coefficient]) VALUES (6, N'Сезонная коллекция', CAST(1.25 AS Decimal(6, 2)))
GO
SET IDENTITY_INSERT [dbo].[ProductTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Materials] ON 
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (1, 1, N'Соевый воск премиум', CAST(890.00 AS Decimal(10, 2)), N'кг', CAST(20.000 AS Decimal(10, 3)), CAST(120.000 AS Decimal(10, 3)), CAST(40.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (2, 1, N'Соевый воск EcoBlend', CAST(760.00 AS Decimal(10, 2)), N'кг', CAST(25.000 AS Decimal(10, 3)), CAST(95.000 AS Decimal(10, 3)), CAST(30.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (3, 2, N'Пчелиный воск натуральный', CAST(1450.00 AS Decimal(10, 2)), N'кг', CAST(10.000 AS Decimal(10, 3)), CAST(48.000 AS Decimal(10, 3)), CAST(15.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (4, 3, N'Масло лаванды', CAST(3200.00 AS Decimal(10, 2)), N'л', CAST(1.000 AS Decimal(10, 3)), CAST(18.500 AS Decimal(10, 3)), CAST(6.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (5, 3, N'Масло ванили', CAST(2950.00 AS Decimal(10, 2)), N'л', CAST(1.000 AS Decimal(10, 3)), CAST(22.000 AS Decimal(10, 3)), CAST(8.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (6, 3, N'Масло цитрусовое', CAST(2870.00 AS Decimal(10, 2)), N'л', CAST(1.000 AS Decimal(10, 3)), CAST(16.700 AS Decimal(10, 3)), CAST(5.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (7, 4, N'Краситель янтарный', CAST(640.00 AS Decimal(10, 2)), N'кг', CAST(0.500 AS Decimal(10, 3)), CAST(6.200 AS Decimal(10, 3)), CAST(2.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (8, 4, N'Краситель розовый', CAST(615.00 AS Decimal(10, 2)), N'кг', CAST(0.500 AS Decimal(10, 3)), CAST(5.100 AS Decimal(10, 3)), CAST(1.500 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (9, 5, N'Фитиль хлопковый 8 см', CAST(4.50 AS Decimal(10, 2)), N'шт', CAST(500.000 AS Decimal(10, 3)), CAST(2500.000 AS Decimal(10, 3)), CAST(800.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (10, 5, N'Фитиль хлопковый 12 см', CAST(5.80 AS Decimal(10, 2)), N'шт', CAST(400.000 AS Decimal(10, 3)), CAST(1800.000 AS Decimal(10, 3)), CAST(600.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (11, 6, N'Стакан прозрачный 200 мл', CAST(28.00 AS Decimal(10, 2)), N'шт', CAST(100.000 AS Decimal(10, 3)), CAST(950.000 AS Decimal(10, 3)), CAST(300.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (12, 6, N'Стакан матовый 250 мл', CAST(34.00 AS Decimal(10, 2)), N'шт', CAST(60.000 AS Decimal(10, 3)), CAST(620.000 AS Decimal(10, 3)), CAST(200.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (13, 7, N'Чаша керамическая белая', CAST(72.00 AS Decimal(10, 2)), N'шт', CAST(40.000 AS Decimal(10, 3)), CAST(280.000 AS Decimal(10, 3)), CAST(80.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (14, 8, N'Сухоцветы лаванды', CAST(520.00 AS Decimal(10, 2)), N'кг', CAST(0.300 AS Decimal(10, 3)), CAST(4.800 AS Decimal(10, 3)), CAST(1.500 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (15, 9, N'Лента сатиновая бежевая', CAST(12.00 AS Decimal(10, 2)), N'м', CAST(50.000 AS Decimal(10, 3)), CAST(340.000 AS Decimal(10, 3)), CAST(120.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (16, 9, N'Коробка подарочная малая', CAST(18.00 AS Decimal(10, 2)), N'шт', CAST(50.000 AS Decimal(10, 3)), CAST(420.000 AS Decimal(10, 3)), CAST(150.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (17, 10, N'Этикетка фирменная круглая', CAST(3.20 AS Decimal(10, 2)), N'шт', CAST(250.000 AS Decimal(10, 3)), CAST(1800.000 AS Decimal(10, 3)), CAST(500.000 AS Decimal(10, 3)))
GO
INSERT [dbo].[Materials] ([Id], [MaterialTypeId], [Name], [UnitPrice], [Unit], [PackageQuantity], [StockQuantity], [MinQuantity]) VALUES (18, 10, N'Наклейка предупреждающая', CAST(2.10 AS Decimal(10, 2)), N'шт', CAST(200.000 AS Decimal(10, 3)), CAST(1600.000 AS Decimal(10, 3)), CAST(400.000 AS Decimal(10, 3)))
GO
SET IDENTITY_INSERT [dbo].[Materials] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (1, N'AR-001', 1, N'Свеча «Лавандовый вечер»', CAST(980.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (2, N'AR-002', 1, N'Свеча «Ванильный крем»', CAST(950.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (3, N'AR-003', 1, N'Свеча «Цитрусовый сад»', CAST(970.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (4, N'AR-004', 2, N'Свеча «Белый мускус»', CAST(1290.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (5, N'AR-005', 2, N'Свеча «Дикая орхидея»', CAST(1360.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (6, N'AR-006', 4, N'Свеча «Теплый янтарь»', CAST(1490.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (7, N'AR-007', 4, N'Свеча «Сандаловое дерево»', CAST(1520.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (8, N'AR-008', 5, N'Мини-свеча «Лаванда»', CAST(420.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (9, N'AR-009', 5, N'Мини-свеча «Ваниль»', CAST(410.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (10, N'AR-010', 5, N'Мини-свеча «Цитрус»', CAST(430.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (11, N'AR-011', 3, N'Набор «Уютный дом»', CAST(2190.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (12, N'AR-012', 3, N'Набор «Теплый вечер»', CAST(2340.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (13, N'AR-013', 6, N'Свеча «Зимние специи»', CAST(1380.00 AS Decimal(10, 2)))
GO
INSERT [dbo].[Products] ([Id], [Article], [ProductTypeId], [Name], [MinPartnerPrice]) VALUES (14, N'AR-014', 6, N'Свеча «Хвойный лес»', CAST(1410.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[MaterialProducts] ON 
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (1, 1, 1, CAST(0.1800 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (2, 4, 1, CAST(0.0090 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (3, 9, 1, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (4, 11, 1, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (5, 17, 1, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (6, 1, 2, CAST(0.1800 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (7, 5, 2, CAST(0.0100 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (8, 9, 2, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (9, 11, 2, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (10, 17, 2, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (11, 2, 3, CAST(0.1750 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (12, 6, 3, CAST(0.0110 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (13, 9, 3, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (14, 11, 3, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (15, 17, 3, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (16, 1, 4, CAST(0.2200 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (17, 5, 4, CAST(0.0060 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (18, 10, 4, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (19, 12, 4, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (20, 17, 4, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (21, 1, 5, CAST(0.2250 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (22, 4, 5, CAST(0.0040 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (23, 10, 5, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (24, 12, 5, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (25, 17, 5, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (26, 3, 6, CAST(0.2800 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (27, 7, 6, CAST(0.0040 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (28, 10, 6, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (29, 13, 6, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (30, 17, 6, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (31, 3, 7, CAST(0.2850 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (32, 5, 7, CAST(0.0030 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (33, 10, 7, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (34, 13, 7, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (35, 17, 7, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (36, 2, 8, CAST(0.0700 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (37, 4, 8, CAST(0.0030 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (38, 9, 8, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (39, 11, 8, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (40, 2, 9, CAST(0.0700 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (41, 5, 9, CAST(0.0030 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (42, 9, 9, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (43, 11, 9, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (44, 2, 10, CAST(0.0700 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (45, 6, 10, CAST(0.0030 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (46, 9, 10, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (47, 11, 10, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (48, 1, 11, CAST(0.1800 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (49, 4, 11, CAST(0.0090 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (50, 9, 11, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (51, 11, 11, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (52, 15, 11, CAST(1.2000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (53, 16, 11, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (54, 17, 11, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (55, 1, 12, CAST(0.2250 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (56, 5, 12, CAST(0.0100 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (57, 10, 12, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (58, 12, 12, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (59, 15, 12, CAST(1.5000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (60, 16, 12, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (61, 17, 12, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (62, 1, 13, CAST(0.2100 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (63, 5, 13, CAST(0.0080 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (64, 7, 13, CAST(0.0030 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (65, 10, 13, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (66, 12, 13, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (67, 18, 13, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (68, 1, 14, CAST(0.2150 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (69, 6, 14, CAST(0.0040 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (70, 7, 14, CAST(0.0020 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (71, 10, 14, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (72, 12, 14, CAST(1.0000 AS Decimal(10, 4)))
GO
INSERT [dbo].[MaterialProducts] ([Id], [MaterialId], [ProductId], [Quantity]) VALUES (73, 18, 14, CAST(1.0000 AS Decimal(10, 4)))
GO
SET IDENTITY_INSERT [dbo].[MaterialProducts] OFF
GO
ALTER TABLE [dbo].[MaterialProducts]  WITH CHECK ADD  CONSTRAINT [FK_MaterialProducts_Materials] FOREIGN KEY([MaterialId])
REFERENCES [dbo].[Materials] ([Id])
GO
ALTER TABLE [dbo].[MaterialProducts] CHECK CONSTRAINT [FK_MaterialProducts_Materials]
GO
ALTER TABLE [dbo].[MaterialProducts]  WITH CHECK ADD  CONSTRAINT [FK_MaterialProducts_Products] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[MaterialProducts] CHECK CONSTRAINT [FK_MaterialProducts_Products]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [FK_Materials_MaterialTypes] FOREIGN KEY([MaterialTypeId])
REFERENCES [dbo].[MaterialTypes] ([Id])
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [FK_Materials_MaterialTypes]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_ProductTypes] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[ProductTypes] ([Id])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_ProductTypes]
GO
ALTER TABLE [dbo].[MaterialProducts]  WITH CHECK ADD  CONSTRAINT [CK_MaterialProducts_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[MaterialProducts] CHECK CONSTRAINT [CK_MaterialProducts_Quantity]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [CK_Materials_MinQuantity] CHECK  (([MinQuantity]>=(0)))
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [CK_Materials_MinQuantity]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [CK_Materials_PackageQuantity] CHECK  (([PackageQuantity]>(0)))
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [CK_Materials_PackageQuantity]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [CK_Materials_StockQuantity] CHECK  (([StockQuantity]>=(0)))
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [CK_Materials_StockQuantity]
GO
ALTER TABLE [dbo].[Materials]  WITH CHECK ADD  CONSTRAINT [CK_Materials_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Materials] CHECK CONSTRAINT [CK_Materials_UnitPrice]
GO
ALTER TABLE [dbo].[ProductTypes]  WITH CHECK ADD  CONSTRAINT [CK_ProductTypes_Coefficient] CHECK  (([Coefficient]>(0)))
GO
ALTER TABLE [dbo].[ProductTypes] CHECK CONSTRAINT [CK_ProductTypes_Coefficient]
GO
USE [master]
GO
ALTER DATABASE [AromaDom] SET  READ_WRITE 
GO
