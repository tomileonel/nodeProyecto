USE [master]
GO
/****** Object:  Database [PocketChefDB]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  User [tomi]    Script Date: 30/8/2024 10:13:10 ******/
CREATE USER [tomi] FOR LOGIN [tomi] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [alumno]    Script Date: 30/8/2024 10:13:10 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[DetalleIngrediente]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[EstadoPedido]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Eventos]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Favoritos]    Script Date: 30/8/2024 10:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favoritos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
	[fechaAgregado] [date] NULL,
 CONSTRAINT [PK_Favoritos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormaPago]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[HistorialBusqueda]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[HistorialPedidos]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[IngredientePorReceta]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Ingredientes]    Script Date: 30/8/2024 10:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredientes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[calorias] [float] NOT NULL,
	[carbohidratos] [float] NOT NULL,
	[grasas] [float] NOT NULL,
	[proteinas] [float] NOT NULL,
	[precio] [float] NULL,
	[imagen] [nvarchar](250) NULL,
 CONSTRAINT [PK_Ingredientes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[PasosReceta]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Pedido]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[RecetaCarrito]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Recetas]    Script Date: 30/8/2024 10:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recetas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[rating] [float] NOT NULL,
	[imagen] [nvarchar](300) NOT NULL,
	[idcreador] [int] NOT NULL,
	[tiempoMins] [float] NOT NULL,
	[calorias] [float] NOT NULL,
	[carboidratos] [float] NOT NULL,
	[proteina] [float] NOT NULL,
	[grasas] [float] NOT NULL,
	[precio] [float] NOT NULL,
	[fechaPublicacion] [date] NOT NULL,
	[descripcion] [nvarchar](100) NULL,
 CONSTRAINT [PK_Recetas] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RecetasEnPedido]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[ReviewReceta]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[ReviewsRecetas]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[TagRecetas]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Tags]    Script Date: 30/8/2024 10:13:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[id] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[specialTag] [bit] NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TagUsuario]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Tarjeta]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[TipoCocina]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[TipoCocinaEnReceta]    Script Date: 30/8/2024 10:13:10 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 30/8/2024 10:13:10 ******/
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
