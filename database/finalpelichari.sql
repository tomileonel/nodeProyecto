USE [master]
GO
/****** Object:  Database [PocketChefDB]    Script Date: 8/7/2024 11:49:19 ******/
CREATE DATABASE [PocketChefDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PocketChefDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PocketChefDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PocketChefDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\PocketChefDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [PocketChefDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PocketChefDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PocketChefDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PocketChefDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PocketChefDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PocketChefDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PocketChefDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PocketChefDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PocketChefDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PocketChefDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PocketChefDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PocketChefDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PocketChefDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PocketChefDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PocketChefDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PocketChefDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PocketChefDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PocketChefDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PocketChefDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PocketChefDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PocketChefDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PocketChefDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PocketChefDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PocketChefDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PocketChefDB] SET RECOVERY FULL 
GO
ALTER DATABASE [PocketChefDB] SET  MULTI_USER 
GO
ALTER DATABASE [PocketChefDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PocketChefDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PocketChefDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PocketChefDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PocketChefDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'PocketChefDB', N'ON'
GO
ALTER DATABASE [PocketChefDB] SET QUERY_STORE = OFF
GO
USE [PocketChefDB]
GO
/****** Object:  User [alumno]    Script Date: 8/7/2024 11:49:19 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carrito](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idRecetaCarrito] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_Carrito] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleIngrediente]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleIngrediente](
	[id] [int] NOT NULL,
	[idIngrediente] [int] NOT NULL,
	[cantGramos] [float] NOT NULL,
	[precio] [int] NOT NULL,
	[calorias] [float] NOT NULL,
 CONSTRAINT [PK_DetalleIngrediente] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoPedido]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoPedido](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EstadoPedido] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Eventos]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Eventos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](50) NOT NULL,
	[descripcion] [text] NOT NULL,
	[fecha] [date] NOT NULL,
	[duracionHrs] [float] NOT NULL,
 CONSTRAINT [PK_Eventos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favoritos]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favoritos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
 CONSTRAINT [PK_Favoritos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormaPago]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormaPago](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[efectivo] [bit] NOT NULL,
	[idTarjeta] [int] NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_FormaPago] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialBusqueda]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialBusqueda](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
 CONSTRAINT [PK_HistorialBusqueda] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialPedidos]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialPedidos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idRecetaCarrito] [int] NOT NULL,
	[entregado] [bit] NOT NULL,
 CONSTRAINT [PK_HistorialPedidos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IngredientePorReceta]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientePorReceta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idreceta] [int] NOT NULL,
	[idingrediente] [int] NOT NULL,
	[cant] [float] NOT NULL,
 CONSTRAINT [PK_IngredienteXReceta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredientes]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[valorcalorico] [float] NOT NULL,
	[precio] [float] NOT NULL,
	[imagen] [nvarchar](250) NULL,
 CONSTRAINT [PK_Ingredientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notificaciones](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[fecha] [date] NOT NULL,
	[titulo] [varchar](50) NOT NULL,
	[descripcion] [text] NOT NULL,
	[visto] [bit] NOT NULL,
 CONSTRAINT [PK_Notificaciones] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PasosReceta]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PasosReceta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[nro] [int] NOT NULL,
	[titulo] [varchar](50) NOT NULL,
	[descripcion] [text] NOT NULL,
	[duracionMin] [float] NULL,
 CONSTRAINT [PK_PasosReceta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nroTransaccion] [varchar](12) NOT NULL,
	[idFormapago] [int] NOT NULL,
	[fechapedido] [date] NOT NULL,
	[fechaentrega] [date] NOT NULL,
	[precio] [float] NOT NULL,
	[idEstadoPedido] [int] NOT NULL,
 CONSTRAINT [PK_Pedidos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecetaCarrito]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecetaCarrito](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[idDetalleIngrediente] [int] NOT NULL,
 CONSTRAINT [PK_RecetaCarrito] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recetas]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recetas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[rating] [float] NOT NULL,
	[imagen] [text] NOT NULL,
	[idcreador] [int] NOT NULL,
	[tiempoMins] [float] NOT NULL,
	[calorias] [float] NOT NULL,
	[carboidratos] [float] NOT NULL,
	[proteina] [float] NOT NULL,
	[grasas] [float] NOT NULL,
	[precio] [float] NOT NULL,
	[fechaPublicacion] [date] NOT NULL,
 CONSTRAINT [PK_Recetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecetasEnPedido]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RecetasEnPedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idPedido] [int] NOT NULL,
	[idRecetaCarrito] [int] NOT NULL,
 CONSTRAINT [PK_RecetasEnPedido] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewReceta]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewReceta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[puntaje] [int] NOT NULL,
	[titulonota] [varchar](50) NOT NULL,
	[nota] [varchar](250) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
 CONSTRAINT [PK_ReviewReceta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReviewsRecetas]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReviewsRecetas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[puntaje] [nchar](10) NOT NULL,
	[reviews] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
 CONSTRAINT [PK_ReviewsRecetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagRecetas]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagRecetas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idTag] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
 CONSTRAINT [PK_TagRecetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagUsuario]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TagUsuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idTag] [int] NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_TagUsuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tarjeta]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tarjeta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero] [int] NOT NULL,
	[titular] [varchar](50) NOT NULL,
	[fechavencimiento] [date] NOT NULL,
	[cvv] [int] NOT NULL,
	[idTitular] [int] NULL,
 CONSTRAINT [PK_Tarjeta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCocina]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCocina](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoCocina] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoCocinaEnReceta]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoCocinaEnReceta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idReceta] [int] NOT NULL,
	[idTipoCocina] [int] NOT NULL,
 CONSTRAINT [PK_TipoCocinaEnReceta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 8/7/2024 11:49:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombreusuario] [nvarchar](50) NOT NULL,
	[contrasena] [nvarchar](50) NOT NULL,
	[mail] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[apellido] [nvarchar](50) NOT NULL,
	[telefono] [int] NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[imagen] [nvarchar](100) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[IngredientePorReceta] ON 

INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant]) VALUES (1, 1, 20, 500)
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant]) VALUES (2, 2, 31, 1200)
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant]) VALUES (3, 3, 84, 400)
SET IDENTITY_INSERT [dbo].[IngredientePorReceta] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingredientes] ON 

INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (1, N'Pechuga de pollo', 144, 899, N'https://www.lavanguardia.com/files/og_thumbnail/uploads/2018/03/13/5e997e247257a.jpeg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (2, N'Muslo de pollo', 97, 950, N'https://hiperlibertad.vtexassets.com/arquivos/ids/176456/PATA-MUSLO-DE-POLLO-FRESCA-X-1-KG-1-17614.jpg?v=637540567216100000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (3, N'Ala de pollo', 57, 720, N'https://canarymeat.es/wp-content/uploads/2017/10/alas-pollo-enteras.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (4, N'Pollo', 144, 2990, N'https://hiperlibertad.vtexassets.com/arquivos/ids/176454/POLLO-FRESCO-X-UN-APROX-2-5KG-1-17616.jpg?v=637540567210870000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (5, N'Asado', 268, 2330, N'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRIcFeGjzY0XDkLBWrLSpN2leLikortNFIEvzRPV0-lQZ8wByTWrmTGVayp10cQwSV10txXC678c7Dz3E4f2WA138bzAvqTtxTfjQc8q58HzUQ2M9ezArGXJg&usqp=CAE')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (6, N'Lomo', 180, 3475, N'https://arcordiezb2c.vteximg.com.br/arquivos/ids/176364/Lomo-Especial-X-Kg-1-5533.jpg?v=638043177868770000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (7, N'Vacio', 198, 3300, N'https://arjosimarprod.vteximg.com.br/arquivos/ids/155595-1000-1000/Vacio-de-Novillito-Kg-1-5801.jpg?v=637377692913400000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (8, N'Matambre de vaca', 215, 2640, N'https://arjosimarprod.vteximg.com.br/arquivos/ids/155586-1000-1000/Matambre-de-Novillito-Kg-1-6008.jpg?v=637377690876230000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (9, N'Cuadril', 187, 3220, N'https://arcordiezb2c.vteximg.com.br/arquivos/ids/176361/Cuadril-Especial-X-Kg-1-5530.jpg?v=638043177861470000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (10, N'Entraña', 234, 3250, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBiUBtQVmH6Uzj00VFdQpcMELdKYf19Cz_Qw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (11, N'Colita de cuadril', 209, 3430, N'https://supermercadoclick.com.ar/web/image/product.template/2246/image_1024?unique=94c46dc')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (12, N'Peceto', 152, 3120, N'https://acdn.mitiendanube.com/stores/861/458/products/peceto-entero1-4446c22c4679a1939615702035043150-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (13, N'Roast beef', 170, 2990, N'https://acdn.mitiendanube.com/stores/861/458/products/roast-beef-entero31-a3e5b764e532246dce15702078202510-1024-1024.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (14, N'Paleta', 218, 3160, N'https://dcdn.mitiendanube.com/stores/001/641/552/products/archivo-v1-251-43fe853da9c8ba075216182390690628-640-0.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (15, N'Osobuco', 137, 2570, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl7u3cvBAyTXdrj_xjQ9w6pugqv-os3B1mxw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (16, N'Ojo de bife', 289, 3630, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSA1hpLIYEVL6rOlDFA-jbcF6KX4ZcbMPoOQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (17, N'Bife de chorizo', 289, 3630, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQen4MX5n7iXYmZCO8Jb4E91vpUwzQ7Z3LwKg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (18, N'Carne picada', 172, 2970, N'https://frioteka.com/assets/productos/wtmk/1134.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (19, N'Nalga', 194, 3300, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhE5Yo-zOtVZoj7ppy7CXoei4uSSvRa_Gfrg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (20, N'Pechito de cerdo', 236, 3900, N'https://acdn.mitiendanube.com/stores/861/458/products/181-3126e9cd2bf326723c15705626046671-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (21, N'Bondiola de cerdo', 265, 3845, N'https://arcordiezb2c.vteximg.com.br/arquivos/ids/176381/Bondiola-De-Cerdo-Fresco-Cabanas-Del-Sur-X-Kg-1-10198.jpg?v=638043934042530000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (22, N'Costillita de cerdo', 213, 3250, N'https://arcordiezb2c.vteximg.com.br/arquivos/ids/176372/Costilla-De-Cerdo-X-Kg-1-5527.jpg?v=638043933857030000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (23, N'Solomillo de cerdo', 109, 2950, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmu4Y6L7Yp6MKWurKJJOa6smgf_BwVueoh0g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (24, N'Matambre de cerdo', 184, 2635, N'https://www.carnave.com.ar/wp-content/uploads/2020/05/10-8394.JPG.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (25, N'Carré de cerdo', 130, 2250, N'https://blowmax.com.ar/wp-content/uploads/2022/08/2306216000000_02_2.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (26, N'Salchicha', 161, 1250, N'https://i.blogs.es/cb833c/salchichas-parrilla-ensalada-2-/1366_2000.jpeg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (27, N'Chorizo', 296, 2275, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6nIenX9AbgYv9Hr2cpllIJz9j3cgJlVZisw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (28, N'Morcilla', 303, 2130, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkhvGwpoGTaWCpJxhrdTFNGfRe_PKQj0RZ2w&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (29, N'Riñon', 99, 2600, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7SB4XSjBwPcFhcLw2DfPUX5AuuTiy5XzX2Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (30, N'Chinchulin', 84, 2500, N'https://static.cotodigital3.com.ar/sitios/fotos/full/00000000/00000028.jpg?3.0.171b')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (31, N'Molleja', 85, 3000, N'https://acdn.mitiendanube.com/stores/861/458/products/molleja1-7af9e7d1706089febe15702857977635-480-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (33, N'Jamon cocido', 44, 1370, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_b4xoF6M1MMudIi7s9ya0_E1oaBBTMZuS3g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (34, N'Panceta', 398, 1700, N'https://acdn.mitiendanube.com/stores/001/219/229/products/diseno-sin-titulo-2022-04-28t165715-1001-b28581652c5587151216511759516368-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (35, N'Salame', 113, 1560, N'https://acdn.mitiendanube.com/stores/001/157/846/products/diseno-sin-titulo-131-6cedabe89577bffa6416572227473740-1024-1024.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (36, N'Chorizo colorado', 212, 1900, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7JMkjLjkIdb8TyrUnvjnald6uthMY_ewGlA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (37, N'Longaniza', 178, 2360, N'https://http2.mlstatic.com/D_NQ_NP_808747-MLA72840151897_112023-O.webp')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (39, N'Merluza', 89, 3230, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShKNrArMOThBde77oxJa1-e0mvjj6v34_Okg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (40, N'Salmon', 175, 4220, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc-IzD80VXcpfEyVV-w7JyhYFlgTg_5x8iUw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (42, N'Atun', 188, 2430, N'https://http2.mlstatic.com/D_NQ_NP_969716-MLU72637186625_112023-O.webp')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (43, N'Sardina', 208, 2160, N'https://acdn.mitiendanube.com/stores/001/021/255/products/sardinas1-92ca9818e8fa202b8f15822037016645-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (44, N'Anchoa', 131, 2580, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSxIJ2adm-jqOGufMJ_4SXSXGy-KESh-50ew&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (45, N'Anillo de calamar', 220, 3160, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTp1sC0t2NVkZtNkedPS_5tElqs9VTZNBL9A&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (46, N'Tubo calamar', 189, 3430, N'https://pescaonline.alamenia.com.ar/wp-content/uploads/2023/12/Tubo-de-Calamar.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (47, N'Tentaculo calamar', 163, 2940, N'https://cdn1.kilbelonline.com/webapp/images/productos/b/0000026000/26002.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (48, N'Calamar', 423, 5230, N'https://www.sealomar.com/wp-content/uploads/2020/05/calamar-fresco-2020-05-20-calamar-fresco-scaled.jpeg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (49, N'Langostino', 189, 4260, N'https://www.cucinare.tv/wp-content/uploads/2019/09/Langostino.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (50, N'Camaron', 293, 3980, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxtVt2imqe1cMNCSrTmBsWEMFJcz1qBKASnw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (52, N'Langosta', 264, 17320, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSIyp1paLFVDv0hpGzI0n5GONdFWiRfdvfXZQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (53, N'Kanikama', 88, 2350, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDM47F0YSP5lSB6GI6NYiWmjsJwRYhV_TyRw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (54, N'Mejillon', 171, 3860, N'https://www.berardisa.com.ar/wp-content/uploads/2020/01/Mejillon-Media-Valva-300x300.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (55, N'Ostra', 102, 2990, N'https://www.berardisa.com.ar/wp-content/uploads/2022/04/Ostras-300x300.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (56, N'Pulpo', 148, 12460, N'https://static.nationalgeographicla.com/files/styles/image_3200/public/octopus_01.jpg?w=1190&h=794')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (57, N'Mortadela', 311, 3430, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSD2UYv0HfxfZhAM7m_v1N8YfQ2MRjJhC2npg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (58, N'Pepperoni', 504, 2340, N'https://masajuarez.com/wp-content/uploads/2021/01/Pepperoni_v1.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (60, N'Lomo horneado', 215, 3480, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8V2QR8ykCanlbBBj1ZrIZ_G8XUP386kbzVA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (61, N'Pastron', 93, 4270, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXtrmCtiNAb9e0xsuQG3jE0G09E24gdxXgFQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (62, N'Queso', 89, 3230, N'https://img.europapress.es/fotoweb/fotonoticia_20220808081246_1200.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (63, N'Queso mozzarella', 75, 4270, N'https://lh4.googleusercontent.com/proxy/od98ukJFlSh8Eta5wejxV1o-wX_uvGzbswN2EhxCIUHFnWHfuPg7I5z4FqPaPAZqCsOwM6h3fZe3nxdSIAcs1vsTFY9H6U8oL4D1vKaJ_tT4C8_MT2oyCNomJKR_h3OMfmGpTqw')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (64, N'Burrata', 88, 5250, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw-t5Urh4fgZJUyMYSsySpRiX2HRN480bRQw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (65, N'Queso light', 39, 3680, N'https://img.freepik.com/foto-gratis/queso-blanco-fresco-rodajas-leche-vaca-aislado-sobre-fondo-blanco_123827-27811.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (66, N'Queso cremon', 71, 2350, N'https://www.laserenisima.com.ar/images/productos/grandescremondoblecrema.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (67, N'Queso cremon light', 71, 2630, N'https://granjaus.com/wp-content/uploads/2020/07/47600-1.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (68, N'Queso untable', 350, 2140, N'https://acdn.mitiendanube.com/stores/093/780/products/15711-fb0c5d334c96a7979a16034619346733-1024-1024.jpeg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (70, N'Queso untable light', 153, 2580, N'https://acdn.mitiendanube.com/stores/001/219/229/products/219111-c7878942be3f3b7c6515988937797593-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (71, N'Queso philadelphia', 277, 3630, N'https://acdn.mitiendanube.com/stores/001/157/846/products/el-granero-31-93e26cf08034eea42316624667468337-1024-1024.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (72, N'Queso de cabra', 108, 4250, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoIMdjqFsRneiJhTRoypccjnAijVM0_XNNDQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (73, N'Queso cheddar', 102, 3740, N'https://w7.pngwing.com/pngs/205/499/png-transparent-cheddar-cheese-emmental-cheese-edam-gouda-cheese-cheddar-food-cheese-beyaz-peynir-thumbnail.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (74, N'Queso tybo', 103, 3540, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_QG9UDIIJHC7QSu38l9fQBvAK6vmitNTZLg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (75, N'Queso parmesano', 420, 5320, N'https://w7.pngwing.com/pngs/675/135/png-transparent-parmigiano-reggiano-gruyere-cheese-montasio-pecorino-romano-cheese-food-cheese-beyaz-peynir.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (76, N'Queso provolone', 300, 4630, N'https://e7.pngegg.com/pngimages/246/698/png-clipart-two-slices-of-cheese-provolone-food-cheese-thumbnail.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (78, N'Queso roquefort', 369, 5480, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlL19nZ5VUA8L8nzTvIMmrbCsUuOVcVBlP4Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (79, N'Queso brie', 334, 5860, N'https://as2.ftcdn.net/v2/jpg/05/80/59/23/1000_F_580592349_h5F3Z6nP8CnDkVPOF53o2j73o6zng05d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (80, N'Ricota', 158, 4270, N'https://e7.pngegg.com/pngimages/532/711/png-clipart-cottage-cheese-milk-food-quark-milk-cream-food-thumbnail.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (81, N'Harina de trigo', 364, 800, N'https://e7.pngegg.com/pngimages/30/12/png-clipart-flour-flour.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (82, N'Harina de maiz', 370, 1430, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqFd8KBLPBhmX3DMSNyrcngyOL-gcePPu80A&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (83, N'Harina leudante', 332, 1040, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7G6fWGDx0Az-yTL5NkCRvLMXLsh3SW4Ns0g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (84, N'Harina integral', 340, 1620, N'https://bio-salud.com.ar/media/catalog/product/cache/0ad1d88be377f19079fdfb8fd212df21/2/5/25k.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (85, N'Levadura', 325, 1350, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23ksz5PJm_oJmiT5lT4XUAUgUNXlGIsXNWQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (86, N'Harina de arroz', 366, 1660, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSchJ5MlTKyN6Rtu6r2FdgIxvwatFnPVt2Anw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [valorcalorico], [precio], [imagen]) VALUES (87, N'Arroz', 126, 1800, N'https://www.pikpng.com/pngl/b/460-4602975_arroz-basmati-basmati-arroz-clipart.png')
SET IDENTITY_INSERT [dbo].[Ingredientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Recetas] ON 

INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carboidratos], [proteina], [grasas], [precio], [fechaPublicacion]) VALUES (1, N'Cerdo', 5, N'https://i.blogs.es/6f9e87/dap-1---2023-04-14t121955.338/650_1200.jpg', 1, 10, 1000, 100, 50, 30, 1000, CAST(N'2023-06-24' AS Date))
INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carboidratos], [proteina], [grasas], [precio], [fechaPublicacion]) VALUES (2, N'Molleja', 5, N'https://assets.elgourmet.com/wp-content/uploads/2023/03/molle_6OAnLtqoPhdY59BmRbrTcWHD7v8u4i.png', 1, 15, 743, 57, 22, 21, 5300, CAST(N'2024-02-12' AS Date))
INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carboidratos], [proteina], [grasas], [precio], [fechaPublicacion]) VALUES (3, N'Pan integral', 3.5, N'https://assets.elgourmet.com/wp-content/uploads/2023/03/pan-c_EMIfoXkTu8L2j9vltgJ6rx1ymP3zbW-1024x683.png.webp', 3, 40, 188, 23, 1, 0, 2000, CAST(N'2024-03-21' AS Date))
SET IDENTITY_INSERT [dbo].[Recetas] OFF
GO
SET IDENTITY_INSERT [dbo].[TagRecetas] ON 

INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (1, 1, 1)
INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (2, 1, 2)
INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (3, 3, 3)
SET IDENTITY_INSERT [dbo].[TagRecetas] OFF
GO
INSERT [dbo].[Tags] ([id], [nombre]) VALUES (1, N'Carnivoro')
INSERT [dbo].[Tags] ([id], [nombre]) VALUES (2, N'Vegetariano')
INSERT [dbo].[Tags] ([id], [nombre]) VALUES (3, N'Celiaco')
GO
SET IDENTITY_INSERT [dbo].[TagUsuario] ON 

INSERT [dbo].[TagUsuario] ([id], [idTag], [idUsuario]) VALUES (1, 1, 1)
INSERT [dbo].[TagUsuario] ([id], [idTag], [idUsuario]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[TagUsuario] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoCocina] ON 

INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (1, N'Internacional')
INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (2, N'Argentina')
INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (3, N'Italiano')
SET IDENTITY_INSERT [dbo].[TipoCocina] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoCocinaEnReceta] ON 

INSERT [dbo].[TipoCocinaEnReceta] ([id], [idReceta], [idTipoCocina]) VALUES (1, 1, 1)
INSERT [dbo].[TipoCocinaEnReceta] ([id], [idReceta], [idTipoCocina]) VALUES (2, 2, 2)
INSERT [dbo].[TipoCocinaEnReceta] ([id], [idReceta], [idTipoCocina]) VALUES (3, 3, 1)
SET IDENTITY_INSERT [dbo].[TipoCocinaEnReceta] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (1, N'PocketChef', N'budin2024', N'pocketchef@gmail.com', N'Pocket', N'Chef', 1122842270, N'budin', N'pocketchef')
INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (2, N'juancitogamer', N'soyjuan', N'juancitopanchito@gmail.com', N'Juan', N'Galdames', 1158490335, N'hola soy juan', N'https://img.freepik.com/foto-gratis/chico-guapo-seguro-posando-contra-pared-blanca_176420-32936.jpg')
INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (3, N'vegano', N'soyvegano', N'veg@gmail.com', N'Maxi', N'Garbanzo', 1011124124, N'a', N'a')
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_RecetaCarrito] FOREIGN KEY([idRecetaCarrito])
REFERENCES [dbo].[RecetaCarrito] ([id])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_RecetaCarrito]
GO
ALTER TABLE [dbo].[Carrito]  WITH CHECK ADD  CONSTRAINT [FK_Carrito_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Carrito] CHECK CONSTRAINT [FK_Carrito_Usuarios]
GO
ALTER TABLE [dbo].[DetalleIngrediente]  WITH CHECK ADD  CONSTRAINT [FK_DetalleIngrediente_Ingredientes] FOREIGN KEY([idIngrediente])
REFERENCES [dbo].[Ingredientes] ([id])
GO
ALTER TABLE [dbo].[DetalleIngrediente] CHECK CONSTRAINT [FK_DetalleIngrediente_Ingredientes]
GO
ALTER TABLE [dbo].[Favoritos]  WITH CHECK ADD  CONSTRAINT [FK_Favoritos_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[Favoritos] CHECK CONSTRAINT [FK_Favoritos_Recetas]
GO
ALTER TABLE [dbo].[Favoritos]  WITH CHECK ADD  CONSTRAINT [FK_Favoritos_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Favoritos] CHECK CONSTRAINT [FK_Favoritos_Usuarios]
GO
ALTER TABLE [dbo].[FormaPago]  WITH CHECK ADD  CONSTRAINT [FK_FormaPago_Tarjeta] FOREIGN KEY([idTarjeta])
REFERENCES [dbo].[Tarjeta] ([id])
GO
ALTER TABLE [dbo].[FormaPago] CHECK CONSTRAINT [FK_FormaPago_Tarjeta]
GO
ALTER TABLE [dbo].[FormaPago]  WITH CHECK ADD  CONSTRAINT [FK_FormaPago_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[FormaPago] CHECK CONSTRAINT [FK_FormaPago_Usuarios]
GO
ALTER TABLE [dbo].[HistorialBusqueda]  WITH CHECK ADD  CONSTRAINT [FK_HistorialBusqueda_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[HistorialBusqueda] CHECK CONSTRAINT [FK_HistorialBusqueda_Recetas]
GO
ALTER TABLE [dbo].[HistorialBusqueda]  WITH CHECK ADD  CONSTRAINT [FK_HistorialBusqueda_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[HistorialBusqueda] CHECK CONSTRAINT [FK_HistorialBusqueda_Usuarios]
GO
ALTER TABLE [dbo].[HistorialPedidos]  WITH CHECK ADD  CONSTRAINT [FK_HistorialPedidos_RecetaCarrito] FOREIGN KEY([idRecetaCarrito])
REFERENCES [dbo].[RecetaCarrito] ([id])
GO
ALTER TABLE [dbo].[HistorialPedidos] CHECK CONSTRAINT [FK_HistorialPedidos_RecetaCarrito]
GO
ALTER TABLE [dbo].[HistorialPedidos]  WITH CHECK ADD  CONSTRAINT [FK_HistorialPedidos_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[HistorialPedidos] CHECK CONSTRAINT [FK_HistorialPedidos_Usuarios]
GO
ALTER TABLE [dbo].[IngredientePorReceta]  WITH CHECK ADD  CONSTRAINT [FK_IngredienteXReceta_Ingredientes] FOREIGN KEY([idingrediente])
REFERENCES [dbo].[Ingredientes] ([id])
GO
ALTER TABLE [dbo].[IngredientePorReceta] CHECK CONSTRAINT [FK_IngredienteXReceta_Ingredientes]
GO
ALTER TABLE [dbo].[IngredientePorReceta]  WITH CHECK ADD  CONSTRAINT [FK_IngredienteXReceta_Recetas] FOREIGN KEY([idreceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[IngredientePorReceta] CHECK CONSTRAINT [FK_IngredienteXReceta_Recetas]
GO
ALTER TABLE [dbo].[Notificaciones]  WITH CHECK ADD  CONSTRAINT [FK_Notificaciones_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Notificaciones] CHECK CONSTRAINT [FK_Notificaciones_Usuarios]
GO
ALTER TABLE [dbo].[PasosReceta]  WITH CHECK ADD  CONSTRAINT [FK_PasosReceta_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[PasosReceta] CHECK CONSTRAINT [FK_PasosReceta_Recetas]
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedido_EstadoPedido] FOREIGN KEY([idEstadoPedido])
REFERENCES [dbo].[EstadoPedido] ([id])
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [FK_Pedido_EstadoPedido]
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [FK_Pedidos_FormaPago] FOREIGN KEY([idFormapago])
REFERENCES [dbo].[FormaPago] ([id])
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [FK_Pedidos_FormaPago]
GO
ALTER TABLE [dbo].[RecetaCarrito]  WITH CHECK ADD  CONSTRAINT [FK_RecetaCarrito_DetalleIngrediente] FOREIGN KEY([idDetalleIngrediente])
REFERENCES [dbo].[DetalleIngrediente] ([id])
GO
ALTER TABLE [dbo].[RecetaCarrito] CHECK CONSTRAINT [FK_RecetaCarrito_DetalleIngrediente]
GO
ALTER TABLE [dbo].[RecetaCarrito]  WITH CHECK ADD  CONSTRAINT [FK_RecetaCarrito_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[RecetaCarrito] CHECK CONSTRAINT [FK_RecetaCarrito_Recetas]
GO
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD  CONSTRAINT [FK_Recetas_Usuarios] FOREIGN KEY([idcreador])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Recetas] CHECK CONSTRAINT [FK_Recetas_Usuarios]
GO
ALTER TABLE [dbo].[RecetasEnPedido]  WITH CHECK ADD  CONSTRAINT [FK_RecetasEnPedido_Pedido] FOREIGN KEY([idPedido])
REFERENCES [dbo].[Pedido] ([id])
GO
ALTER TABLE [dbo].[RecetasEnPedido] CHECK CONSTRAINT [FK_RecetasEnPedido_Pedido]
GO
ALTER TABLE [dbo].[RecetasEnPedido]  WITH CHECK ADD  CONSTRAINT [FK_RecetasEnPedido_RecetaCarrito] FOREIGN KEY([idRecetaCarrito])
REFERENCES [dbo].[RecetaCarrito] ([id])
GO
ALTER TABLE [dbo].[RecetasEnPedido] CHECK CONSTRAINT [FK_RecetasEnPedido_RecetaCarrito]
GO
ALTER TABLE [dbo].[ReviewReceta]  WITH CHECK ADD  CONSTRAINT [FK_Review_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[ReviewReceta] CHECK CONSTRAINT [FK_Review_Usuarios]
GO
ALTER TABLE [dbo].[ReviewReceta]  WITH CHECK ADD  CONSTRAINT [FK_ReviewReceta_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[ReviewReceta] CHECK CONSTRAINT [FK_ReviewReceta_Recetas]
GO
ALTER TABLE [dbo].[ReviewsRecetas]  WITH CHECK ADD  CONSTRAINT [FK_ReviewsRecetas_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[ReviewsRecetas] CHECK CONSTRAINT [FK_ReviewsRecetas_Recetas]
GO
ALTER TABLE [dbo].[TagRecetas]  WITH CHECK ADD  CONSTRAINT [FK_TagRecetas_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[TagRecetas] CHECK CONSTRAINT [FK_TagRecetas_Recetas]
GO
ALTER TABLE [dbo].[TagRecetas]  WITH CHECK ADD  CONSTRAINT [FK_TagRecetas_Tags] FOREIGN KEY([idTag])
REFERENCES [dbo].[Tags] ([id])
GO
ALTER TABLE [dbo].[TagRecetas] CHECK CONSTRAINT [FK_TagRecetas_Tags]
GO
ALTER TABLE [dbo].[TagUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TagUsuario_Tags] FOREIGN KEY([idTag])
REFERENCES [dbo].[Tags] ([id])
GO
ALTER TABLE [dbo].[TagUsuario] CHECK CONSTRAINT [FK_TagUsuario_Tags]
GO
ALTER TABLE [dbo].[TagUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TagUsuario_Usuarios] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[TagUsuario] CHECK CONSTRAINT [FK_TagUsuario_Usuarios]
GO
ALTER TABLE [dbo].[Tarjeta]  WITH CHECK ADD  CONSTRAINT [FK_Tarjeta_Usuarios] FOREIGN KEY([idTitular])
REFERENCES [dbo].[Usuarios] ([id])
GO
ALTER TABLE [dbo].[Tarjeta] CHECK CONSTRAINT [FK_Tarjeta_Usuarios]
GO
ALTER TABLE [dbo].[TipoCocinaEnReceta]  WITH CHECK ADD  CONSTRAINT [FK_TipoCocinaEnReceta_Recetas] FOREIGN KEY([idReceta])
REFERENCES [dbo].[Recetas] ([id])
GO
ALTER TABLE [dbo].[TipoCocinaEnReceta] CHECK CONSTRAINT [FK_TipoCocinaEnReceta_Recetas]
GO
ALTER TABLE [dbo].[TipoCocinaEnReceta]  WITH CHECK ADD  CONSTRAINT [FK_TipoCocinaEnReceta_TipoCocina] FOREIGN KEY([idTipoCocina])
REFERENCES [dbo].[TipoCocina] ([id])
GO
ALTER TABLE [dbo].[TipoCocinaEnReceta] CHECK CONSTRAINT [FK_TipoCocinaEnReceta_TipoCocina]
GO
USE [master]
GO
ALTER DATABASE [PocketChefDB] SET  READ_WRITE 
GO
