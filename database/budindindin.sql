
USE [PocketChefDB]
GO
/****** Object:  User [tomi]    Script Date: 2/9/2024 11:11:45 ******/
CREATE USER [tomi] FOR LOGIN [tomi] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [alumno]    Script Date: 2/9/2024 11:11:45 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Carrito]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[DetalleIngrediente]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[EstadoPedido]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Eventos]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Favoritos]    Script Date: 2/9/2024 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favoritos](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idUsuario] [int] NOT NULL,
	[idReceta] [int] NOT NULL,
	[fechaAgregado] [date] NOT NULL,
 CONSTRAINT [PK_Favoritos] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormaPago]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[HistorialBusqueda]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[HistorialPedidos]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[IngredientePorReceta]    Script Date: 2/9/2024 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngredientePorReceta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[idreceta] [int] NOT NULL,
	[idingrediente] [int] NOT NULL,
	[cant] [float] NOT NULL,
	[detalleCant] [nvarchar](100) NULL,
 CONSTRAINT [PK_IngredienteXReceta] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredientes]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Notificaciones]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[PasosReceta]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Pedido]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[RecetaCarrito]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Recetas]    Script Date: 2/9/2024 11:11:45 ******/
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
	[carbohidratos] [float] NOT NULL,
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
/****** Object:  Table [dbo].[RecetasEnPedido]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[ReviewReceta]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[ReviewsRecetas]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[TagRecetas]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Tags]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[TagUsuario]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Tarjeta]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[TipoCocina]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[TipoCocinaEnReceta]    Script Date: 2/9/2024 11:11:45 ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 2/9/2024 11:11:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombreusuario] [nvarchar](50) NOT NULL,
	[contrasena] [nvarchar](255) NOT NULL,
	[mail] [nvarchar](50) NOT NULL,
	[nombre] [nvarchar](50) NOT NULL,
	[apellido] [nvarchar](50) NOT NULL,
	[telefono] [int] NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[imagen] [nvarchar](150) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Favoritos] ON 

INSERT [dbo].[Favoritos] ([id], [idUsuario], [idReceta], [fechaAgregado]) VALUES (10, 4, 1, CAST(N'2024-09-02' AS Date))
SET IDENTITY_INSERT [dbo].[Favoritos] OFF
GO
SET IDENTITY_INSERT [dbo].[IngredientePorReceta] ON 

INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (1, 1, 186, 0.05, N'1 cucharada')
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (2, 1, 110, 0.3, N'2 cucharadas')
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (3, 1, 172, 1.25, N'1/2 taza')
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (4, 1, 131, 1.875, N'3/4 taza')
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (6, 1, 185, 1, N'2 unidades')
INSERT [dbo].[IngredientePorReceta] ([id], [idreceta], [idingrediente], [cant], [detalleCant]) VALUES (7, 1, 11, 5, N'2 tazas')
SET IDENTITY_INSERT [dbo].[IngredientePorReceta] OFF
GO
SET IDENTITY_INSERT [dbo].[Ingredientes] ON 

INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (1, N'Pechito de cerdo', 236, 0, 0, 0, 3900, N'https://acdn.mitiendanube.com/stores/861/458/products/181-3126e9cd2bf326723c15705626046671-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (2, N'Bondiola de cerdo', 265, 0, 0, 0, 3845, N'https://arcordiezb2c.vteximg.com.br/arquivos/ids/176381/Bondiola-De-Cerdo-Fresco-Cabanas-Del-Sur-X-Kg-1-10198.jpg?v=638043934042530000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (3, N'Matambre de cerdo', 184, 0, 0, 0, 2635, N'https://www.carnave.com.ar/wp-content/uploads/2020/05/10-8394.JPG.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (4, N'Riñon', 99, 0, 0, 0, 2600, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7SB4XSjBwPcFhcLw2DfPUX5AuuTiy5XzX2Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (5, N'Chinchulin', 84, 0, 0, 0, 2500, N'https://static.cotodigital3.com.ar/sitios/fotos/full/00000000/00000028.jpg?3.0.171b')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (6, N'Queso light', 39, 0, 0, 0, 3680, N'https://img.freepik.com/foto-gratis/queso-blanco-fresco-rodajas-leche-vaca-aislado-sobre-fondo-blanco_123827-27811.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (7, N'Queso cremon', 71, 0, 0, 0, 2350, N'https://www.laserenisima.com.ar/images/productos/grandescremondoblecrema.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (8, N'Queso cremon light', 71, 0, 0, 0, 2630, N'https://granjaus.com/wp-content/uploads/2020/07/47600-1.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (9, N'Queso provolone', 300, 0, 0, 0, 4630, N'https://e7.pngegg.com/pngimages/246/698/png-clipart-two-slices-of-cheese-provolone-food-cheese-thumbnail.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (10, N'Queso roquefort', 369, 0, 0, 0, 5480, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlL19nZ5VUA8L8nzTvIMmrbCsUuOVcVBlP4Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (11, N'Harina leudante', 332, 0, 0, 0, 1040, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7G6fWGDx0Az-yTL5NkCRvLMXLsh3SW4Ns0g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (12, N'Levadura', 325, 0, 0, 0, 1350, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS23ksz5PJm_oJmiT5lT4XUAUgUNXlGIsXNWQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (13, N'Pollo', 215, 0, 15.1, 18.6, NULL, N'https://www.edamam.com/food-img/d33/d338229d774a743f7858f6764e095878.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (14, N'Pechuga de pollo', 120, 0, 2.62, 22.5, NULL, N'https://www.edamam.com/food-img/da5/da510379d3650787338ca16fb69f4c94.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (15, N'Muslo de pollo', 221, 0.25, 16.6, 16.5, NULL, N'https://www.edamam.com/food-img/007/00792642367e1f55de680762f85cfb3b.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (16, N'Alitas de Pollo', 191, 0, 12.8, 17.5, NULL, N'https://www.edamam.com/food-img/f92/f928682fc890edded472c5d8baeffed5.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (17, N'Carne Molida de Res', 254, 0, 20, 17.2, NULL, N'https://www.edamam.com/food-img/cfa/cfae8f9276eaf8f0d9349ba662744a0c.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (18, N'Bife de chorizo', 228, 0, 15.8, 20, NULL, N'https://www.edamam.com/food-img/28f/28f2c7d960e01ff18685b6680ee5a150.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (19, N'Costillar', 336, 0.9, 29.9, 15.8, NULL, N'https://acdn.mitiendanube.com/stores/001/080/373/products/ef-redes-14911-089dad69b125ccdb3116571270780532-640-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (20, N'Asado', 276, 0, 22.2, 17.8, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk9hXnZ3yspM4-ee-JRtufRfUyv03PCZKpmA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (21, N'Lomo de Res', 246, 0, 17.9, 19.8, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqgehAbXi1YsgHXn_tgOcbiYQHBUdwm_8bSw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (22, N'Matambre', 215, 0, 15, 18.7, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrsjXJix6bahecrhfTIRHLPo3tfs9nJr38Rw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (23, N'Osobuco', 137, 0.1, 5.8, 21, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbevefwJtILhvwbW0Nhi5OoOB67WYezMfdZA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (24, N'Solomillo de ternera', 246, 0, 17.9, 19.8, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHBrST_OJRelRkH60sTJN-6i9deH1l_CtgBQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (25, N'Cerdo', 198, 0, 12.6, 19.7, NULL, N'https://www.edamam.com/food-img/d55/d553f23d42b9c8fb314416ccd5cde3d2.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (26, N'Costilla de cerdo', 277, 0, 23.4, 15.5, NULL, N'https://www.edamam.com/food-img/499/49977aabc381bd3889ad9100978e1bb6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (27, N'Solomillo de cerdo', 120, 0, 3.53, 20.6, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmu4Y6L7Yp6MKWurKJJOa6smgf_BwVueoh0g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (28, N'Chuleta de cerdo', 170, 0, 9.03, 20.7, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdJxwtqygAiYoUUxO_f8yzxrcQnbr3xJrNMQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (29, N'Panceta', 518, 0, 53, 9.34, NULL, N'https://www.edamam.com/food-img/d42/d426884a125fa39a70d5a5d7217864ec.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (30, N'Jamón', 164, 3.63, 8.8, 16.6, NULL, N'https://www.edamam.com/food-img/a4b/a4ba02f547d69f0ab89ae266903f1e49.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (32, N'Chorizo de cerdo', 261, 1.1, 20, 17.9, NULL, N'https://www.edamam.com/food-img/c01/c0139ae7ad8a0334a23365b6284a5819.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (33, N'Salchicha', 288, 0.93, 24.8, 15.4, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRlcxlWJmzkaOZOlcTtl8ZuHeFZLKWvkR13Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (34, N'Cordero', 648, 0, 68.9, 6.27, NULL, N'https://www.edamam.com/food-img/212/21293e4eb386543620627f7df3078200.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (35, N'Pierna de cordero', 209, 0, 14.4, 18.5, NULL, N'https://www.edamam.com/food-img/dad/dad70281fdf22cdda2e2d55972190cdf.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (36, N'Costilla de cordero', 372, 0, 34.4, 14.5, NULL, N'https://www.edamam.com/food-img/a90/a90c6b8376ae5feeaeeb3b81505a2089.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (37, N'Zanahorias', 41, 9.58, 0.24, 0.93, NULL, N'https://www.edamam.com/food-img/121/121e33fce0bb9546ed7d060b6c114e29.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (38, N'Papa', 77, 17.5, 0.09, 2.05, NULL, N'https://www.edamam.com/food-img/651/6512e82417bce15c2899630c1a2799df.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (39, N'Batata', 76, 17.7, 0.1, 1.4, NULL, N'https://www.edamam.com/food-img/b66/b660e3d37b4ea9d58cb98e8ea73933b6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (40, N'Cebolla', 40, 9.34, 0.1, 1.1, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbzZrNwctf9iXmMimW5b1_oidDaiVCCxsgoA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (41, N'Cebolla de verdeo', 32, 7.3, 0.2, 1.8, NULL, N'https://www.edamam.com/food-img/b89/b89986ed6aa466285bdd99bac34b3c46.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (42, N'Ajo', 149, 33.1, 0.5, 6.36, NULL, N'https://www.edamam.com/food-img/6ee/6ee142951f48aaf94f4312409f8d133d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (43, N'Tomate', 18, 3.89, 0.2, 0.88, NULL, N'https://www.edamam.com/food-img/23e/23e727a14f1035bdc2733bb0477efbd2.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (44, N'Morron', 26, 6.03, 0.3, 0.99, NULL, N'https://www.edeal.com.ar/698-large_default/huevo-x-maple-.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (45, N'Berenjena', 25, 5.88, 0.18, 0.98, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ3Jb4OegAyrD8w-aw47VuppbHTb4P_y6hOg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (46, N'Brócoli', 34, 6.64, 0.37, 2.82, NULL, N'https://www.edamam.com/food-img/3e4/3e47317a3dd54dc911b9c44122285df1.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (47, N'Coliflor', 25, 4.97, 0.28, 1.92, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7z3TzwWCvS3W2LRsT0CuIKl1QYg9GjdO2Fw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (48, N'Espinacas', 23, 3.63, 0.39, 2.86, NULL, N'https://www.edamam.com/food-img/e6e/e6e4be375c4554ce01c8ea75232efaa6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (49, N'Lechuga', 13, 2.23, 0.22, 1.35, NULL, N'https://www.edamam.com/food-img/719/71996625d0cb47e197093ecd52c97dc2.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (50, N'Pepino', 15, 3.63, 0.11, 0.65, NULL, N'https://www.edamam.com/food-img/501/5015da0e5fc2b384696b3d949aefef86.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (51, N'Espárragos', 20, 3.88, 0.12, 2.2, NULL, N'https://www.edamam.com/food-img/159/159dec8bbcabf7ed641a57b40a2d2eb9.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (52, N'Champiñón', 22, 3.26, 0.34, 3.09, NULL, N'https://www.edamam.com/food-img/d63/d639cf4a2afc7407c1d1ce286028136b.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (53, N'Apio', 14, 2.97, 0.17, 0.69, NULL, N'https://www.edamam.com/food-img/d91/d91d2aed1c36d8fad54c4d7dc58f5a18.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (54, N'Rábano', 16, 3.4, 0.1, 0.68, NULL, N'https://www.edamam.com/food-img/ad7/ad78f4315cdba1dc26ccef0d7dba464b.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (55, N'Guisante', 81, 14.4, 0.4, 5.42, NULL, N'https://www.edamam.com/food-img/5ed/5ed641d646c028598a90bdb9ece34fc8.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (56, N'Choclo', 86, 18.7, 1.35, 3.27, NULL, N'https://www.edamam.com/food-img/eb5/eb5e11afb9f697720b2de2e0e0e27d8d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (57, N'Manzana', 52, 13.8, 0.17, 0.26, NULL, N'https://www.edamam.com/food-img/42c/42c006401027d35add93113548eeaae6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (58, N'Plátano', 89, 22.8, 0.33, 1.09, NULL, N'https://www.edamam.com/food-img/9f6/9f6181163a25c96022ee3fc66d9ebb11.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (59, N'Naranja', 47, 11.8, 0.12, 0.94, NULL, N'https://www.edamam.com/food-img/8ea/8ea264a802d6e643c1a340a77863c6ef.jpg ')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (60, N'Fresa', 32, 7.68, 0.3, 0.67, NULL, N'https://www.edamam.com/food-img/00c/00c8851e401bf7975be7f73499b4b573.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (61, N'Uva', 69, 18.1, 0.16, 0.72, NULL, N'https://www.edamam.com/food-img/ca5/ca55ac74deb991d159942c65777115df.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (62, N'Piña', 50, 13.1, 0.12, 0.54, NULL, N'https://www.edamam.com/food-img/2da/2da6f2397ab64ed185c082edebc4dd7c.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (63, N'Mango', 60, 15, 0.38, 0.82, NULL, N'https://www.edamam.com/food-img/6e0/6e04857756d0876f14bfc035ff238e0b.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (64, N'Pera', 57, 15.2, 0.14, 0.36, NULL, N'https://www.edamam.com/food-img/65a/65aec51d264db28bbe27117c9fdaaca7.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (65, N'Melones', 34, 8.16, 0.19, 0.84, NULL, N'https://resizer.glanacion.com/resizer/v2/el-melon-aporta-agua-vitaminas-a-b-c-y-e-acido-B3I6MPVBPRBXJELSROGCGVESSA.jpg?auth=e3448fb4ee3f3288c3c5cba5a71dfec8379b68ee5e4b381c1f02d0d51bbc1f89&width=880&height=586&quality=70&smart=true')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (66, N'Sandía', 30, 7.55, 0.15, 0.61, NULL, N'https://www.edamam.com/food-img/e83/e83c09ce97ecd44e00b8c561ab682202.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (67, N'Kiwi', 61, 14.7, 0.52, 1.14, NULL, N'https://www.edamam.com/food-img/dba/dbabbf58b6a43c9b65014f4c789d4409.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (68, N'Durazno', 39, 9.54, 0.25, 0.91, NULL, N'https://www.edamam.com/food-img/437/4378245cfab2121c9e6eb9e3c3dc9ac8.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (69, N'Cereza', 63, 16, 0.2, 1.06, NULL, N'https://www.edamam.com/food-img/34b/34b23d901752b022d6ab1ee6f9ed0b74.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (70, N'Limón', 29, 9.32, 0.3, 1.1, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1aCuj7EcWUVqFVa9Akd4Cr9QSGKkFfSDgHw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (71, N'Mandarinas', 53, 13.3, 0.31, 0.81, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-4oXBceSqkv-G5RH1x25ZJBb4nagkyHTq-Q&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (72, N'Papaya', 43, 10.8, 0.26, 0.47, NULL, N'https://www.edamam.com/food-img/ceb/ceb26874332d3523d92d79d44fa836ca.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (73, N'Ciruela', 46, 11.4, 0.28, 0.7, NULL, N'https://www.edamam.com/food-img/171/171e0c6dd5bc1090a0f574722f3c09b6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (74, N'Higos', 74, 19.2, 0.3, 0.75, NULL, N'https://www.edamam.com/food-img/3ce/3ce7b15338ac4ecb9a043df83ea6f9d4.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (75, N'Coco', 354, 15.2, 33.5, 3.33, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQflGyjz9_7tRFlB8ZKUmcqGAQycr9ElPjDsA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (76, N'Harina de trigo', 364, 76.3, 0.98, 10.3, NULL, N'https://www.edamam.com/food-img/368/368077bbcab62f862a8c766a56ea5dd1.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (77, N'Harina de maíz', 363, 76.6, 3.69, 8.46, NULL, N'https://www.edamam.com/food-img/95a/95a2e8b91ba3a3c42c36ae1a541782e8.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (78, N'Harina de Avena', 404, 65.7, 9.12, 14.7, NULL, N'https://www.edamam.com/food-img/dcf/dcf53f9c8f24c6d7eb22fae5e1a61f6a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (79, N'Harina de trigo integral', 340, 72, 2.5, 13.2, NULL, N'https://www.edamam.com/food-img/f46/f46a64137365c10237522be5980f769c.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (80, N'Harina de arroz', 366, 80.1, 1.42, 5.95, NULL, N'https://www.edamam.com/food-img/252/25233e59c8548d747b232000e7c3f939.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (81, N'Lentejas Verdes', 352, 63.4, 1.06, 24.6, NULL, N'https://www.edamam.com/food-img/d5a/d5aa5bc5a3142f3179f31310054a56e6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (82, N'Garbanzo', 378, 63, 6.04, 20.5, NULL, N'https://www.edamam.com/food-img/520/520c62055515f730b8947e0e445fd2be.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (83, N'Frijoles negros', 77, 14.62, 0, 5.38, NULL, N'https://images.cookforyourlife.org/wp-content/uploads/2015/08/Basic-Black-Beans-2-e1666973834544.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (84, N'Alubia roja', 333, 60, 0.83, 23.6, NULL, N'https://www.edamam.com/food-img/b38/b38474ab11c81e155df0ef5b7120bc27.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (85, N'Soja', 109, 7.61, 4.73, 11.2, NULL, N'https://www.edamam.com/food-img/325/325e012901331f9860df07f755adf197.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (86, N'Maní', 567, 16.1, 49.2, 25.8, NULL, N'https://www.edamam.com/food-img/6f4/6f41e31c53bb58cc1b7331d0764963f7.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (87, N'Almendra', 579, 21.6, 49.9, 21.2, NULL, N'https://www.edamam.com/food-img/6c2/6c2dc21adf11afc4c8d390ee2f651e56.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (88, N'Avellana', 628, 16.7, 60.8, 15, NULL, N'https://www.edamam.com/food-img/136/13615074edcc12bf37a30987ebfec6dc.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (89, N'Pistacho', 560, 27.2, 45.3, 20.2, NULL, N'https://www.edamam.com/food-img/1ed/1eda10468a9c3df61f8208fe156e832d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (90, N'Pecanas', 691, 13.9, 72, 9.17, NULL, N'https://www.edamam.com/food-img/42f/42ff4c36d4d0b4e8069604c97af1cfef.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (91, N'Castañas', 196, 44.2, 1.25, 1.63, NULL, N'https://www.edamam.com/food-img/c50/c504cfb40bafb475c594efe93bfe9bf4.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (92, N'Semillas de girasol', 584, 20, 51.5, 20.8, NULL, N'https://www.edamam.com/food-img/c03/c035107b6716331396e91f7c2c0f2a04.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (93, N'Salmón', 208, 0, 13.4, 20.4, NULL, N'https://www.edamam.com/food-img/9a0/9a0f38422e9f21dcedbc2dca0d8209ac.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (94, N'Atún', 109, 0, 0.49, 24.4, NULL, N'https://www.edamam.com/food-img/022/022db6571bd5b3dfbd3ef8941c775d12.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (95, N'Atun en lata', 157, 0, 5.5, 25.1, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRQ7VVS8QehXpemMgyXMdi1QEfPJXKHrGaBw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (96, N'Sardina', 131, 0, 4.84, 20.4, NULL, N'https://www.edamam.com/food-img/4e6/4e625d8f230469ed1cb2367bcca77fc8.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (97, N'Trucha', 141, 0, 6.18, 19.9, NULL, N'https://www.edamam.com/food-img/edc/edcf7d7c8b01a92c4e219e6a80707870.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (98, N'Merluza', 82, 0, 0.67, 17.8, NULL, N'https://www.edamam.com/food-img/d58/d58d0ccfc3a15f1dfb7877f17a068d4d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (99, N'Camarones', 71, 0.91, 1.01, 13.6, NULL, N'https://www.edamam.com/food-img/ebe/ebe2888b894f48d19762e1d606db0206.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (100, N'Langostino', 71, 0.91, 1.01, 13.6, NULL, N'https://cdn.elcocinerocasero.com/imagen/receta/1000/2021-11-29-16-52-13/langostinos-a-la-plancha.jpeg')
GO
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (101, N'Mejillones', 86, 3.69, 2.24, 11.9, NULL, N'https://www.edamam.com/food-img/8de/8de89f5f0c1602d847b4034fb1168d10.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (102, N'Almeja', 86, 3.57, 0.96, 14.7, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTziUNKXOiy6aY3WCN-hevw4xsqJQHnbCt6oQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (103, N'Ostra', 81, 4.95, 2.3, 9.45, NULL, N'https://www.edamam.com/food-img/09f/09f96476bd4f0af31803dfbf15049f94.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (104, N'Pulpo', 82, 2.2, 1.04, 14.9, NULL, N'https://www.edamam.com/food-img/e2b/e2b278b26595422dd8fe09a058e7e0b2.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (105, N'Calamar', 92, 3.08, 1.38, 15.6, NULL, N'https://www.edamam.com/food-img/45e/45e595bde976f5037269e69f1fb16745.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (106, N'Langosta', 77, 0, 0.75, 16.5, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0Du_EyfcqikjBE4pJ2MQQZioCDs5dmE6s-w&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (107, N'Cangrejo', 87, 0.04, 1.08, 18.1, NULL, N'https://www.edamam.com/food-img/448/4480300b78e0e169a0656f1d22099109.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (108, N'Caballa', 205, 0, 13.9, 18.6, NULL, N'https://www.edamam.com/food-img/f80/f803095970a3f5c5a8d4ea45ade6908a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (109, N'Anchoa', 210, 0, 9.71, 28.9, NULL, N'https://www.edamam.com/food-img/903/903f0e875a690dce724b7f4b6f09f931.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (110, N'Leche', 61, 4.8, 3.25, 3.15, NULL, N'https://www.edamam.com/food-img/7c9/7c9962acf83654a8d98ea6a2ade93735.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (111, N'Yogur', 61, 4.66, 3.25, 3.47, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoyuA5cQMaEhhrGfpz7WEjx5SJOMANC5_oPQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (112, N'Manteca', 717, 0.06, 81.1, 0.85, NULL, N'https://www.edamam.com/food-img/713/71397239b670d88c04faa8d05035cab4.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (113, N'Crema', 340, 2.84, 36.1, 2.84, NULL, N'https://ardiaprod.vtexassets.com/arquivos/ids/281968/Crema-para-Cocinar-La-Serenisima-330-Gr-_1.jpg?v=638322661399030000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (114, N'Queso Cheddar', 403, 3.37, 33.3, 22.9, NULL, N'https://www.los-almendros.com.ar/shop/wp-content/uploads/queso-cheddar.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (115, N'Queso Mozzarella', 318, 2.47, 24.6, 21.6, NULL, N'https://www.edamam.com/food-https://infoqueso.com/wp-content/uploads/2020/05/queso-mozzarella.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (116, N'Queso Parmesano', 392, 3.22, 25, 35.8, NULL, N'https://www.edamam.com/food-img/f58/f588658627c59d5041e4664119829aa9.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (117, N'Queso Brie', 334, 0.45, 27.7, 20.8, NULL, N'https://www.edamam.com/food-img/f53/f5340600239cf508f17b167265c6a1cf.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (118, N'Queso azul', 353, 2.34, 28.7, 21.4, NULL, N'https://www.edamam.com/food-img/b44/b442cfc174a1a691dca574c9b7dcb47a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (119, N'Queso Feta', 265, 3.88, 21.5, 14.2, NULL, N'https://www.edamam.com/food-img/37e/37ef3e404b1c02bf4707cb82010732b8.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (120, N'Queso Ricotta', 150, 7.27, 10.2, 7.54, NULL, N'https://www.edamam.com/food-img/fc4/fc42636b63848462aea5f5930c2b6268.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (121, N'Queso tybo', 343, 2, 25, 27, NULL, N'https://acdn.mitiendanube.com/stores/001/664/252/products/queso-tybo1-db41f4c6631e578eb416668151546141-640-01-a19e5ff29354ed68f416951260393987-480-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (122, N'Burrata', 352, 4, 29.2, 18.4, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1SIs0-ATgUsgwyCw5c0wkns27ZaChVjRTXA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (123, N'Salami', 378, 0.72, 31.6, 21.1, NULL, N'https://www.edamam.com/food-img/b1e/b1e1be598ceb08d50d9c1f5d49b49f6a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (124, N'Cebolla morada', 40, 9.7, 0.1, 0.9, NULL, N'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQVQ0lfK_4ULvOCJI__aG-sZnorDQQ0jL6-X4afF5gctHmli3ItNVvR5djGBg4K4lFc-O460LpvcHd_XuOXdRuZARfcxkdpdFmA7YoFsw')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (125, N'Pepperoni', 504, 1.18, 46.3, 19.2, NULL, N'https://www.edamam.com/food-img/10b/10b28aa71cbe520aef944186f2b365b9.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (126, N'Jamon crudo', 195, 0.3, 8.32, 27.8, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3zMeaXkDKHgT6iZTeiO2qgrDPGj3QLPQdNw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (127, N'Chocolate negro', 598, 45.9, 42.6, 7.79, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPUcl3ctw2Ix2LXbLViZ-vsuamwUVkl73Njw&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (128, N'Chocolate con leche', 535, 59.4, 29.7, 7.65, NULL, N'https://www.edamam.com/food-img/818/8181456202f62ca321fdaf8513ce3282.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (129, N'Chocolate blanco', 500, 71.43, 23.81, 4.76, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRmvyWrDAzn12bWQj5sD1mveuXdcowHLytXg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (130, N'Mermelada de Fresa', 278, 68.9, 0.07, 0.37, NULL, N'https://www.edamam.com/food-img/42b/42ba8bb2c0e13f6e69b3af18f0f641ae.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (131, N'Azúcar blanco', 419, 67.44, 16.28, 2.33, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNTMqYNsJwefqAVc0cFFgRG5FyTe7r5tiRxg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (132, N'Gelatina', 335, 0, 0.1, 85.6, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbEBzpxCyIGWnb_gFqBkAFSwSP8cfVKygT9g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (133, N'Turrón', 467, 62.22, 20, 11.11, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGX8oq1CviW3DhQBHI3XyATZcFAw4Yf5eHog&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (134, N'Vinagre balsámico', 88, 17, 0, 0.49, NULL, N'https://www.edamam.com/food-img/90a/90a1f211768e166ecfff19e8b4747498.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (135, N'Mostaza', 60, 5.83, 3.34, 3.74, NULL, N'https://www.edamam.com/food-img/e23/e238f2e4cfa6aa1a30f46dc73e7344eb.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (136, N'Salsa barbacoa', 172, 40.8, 0.63, 0.82, NULL, N'https://www.edamam.com/food-img/7e3/7e303aa2cbb51e4bd70f71bf5cb4a754.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (137, N'Salsa inglesa', 77, 19.2, 0, 0, NULL, N'https://www.edamam.com/food-img/072/072b61dd1ad5bb641f05b14f716ba6d0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (138, N'Orégano', 265, 68.9, 4.28, 9, NULL, N'https://www.edamam.com/food-img/1b0/1b0eaffb1c261606e0d82fed8e9747a7.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (139, N'Cilantro', 23, 3.67, 0.52, 2.13, NULL, N'https://www.edamam.com/food-img/d57/d57e375b6ff99a90c7ee2b1990a1af36.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (140, N'Romero', 131, 20.7, 5.86, 3.31, NULL, N'https://www.edamam.com/food-img/0ac/0ac8f7cf6f2d0ad7b1a2f9900fae44f3.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (141, N'Pimienta negra', 83, 13.33, 5, 0, NULL, N'https://s3.abcstatics.com/media/bienestar/2022/01/22/pimienta-negra-kjQB--1248x698@abc.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (142, N'Azafrán', 310, 65.4, 5.85, 11.4, NULL, N'https://www.edamam.com/food-img/b7c/b7c71604d7d5e7f54ac461079e6fe175.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (143, N'Curry', 325, 55.8, 14, 14.3, NULL, N'https://www.edamam.com/food-img/9ce/9ce02a2887385fd2adaec8dd8adcf9c5.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (144, N'Salsa de soja', 90, 0, 13, 0, NULL, N'https://www.edamam.com/food-img/f56/f562e461eb0618f367f538b836c17b82.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (145, N'Harina de avena', 379, 67.7, 6.52, 13.2, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrhupRrMiuLCMZBWb_g_JpsUhh47JEmJfREQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (146, N'Pan integral', 265, 43.34, 4.23, 13.36, NULL, N'https://www.edamam.com/food-https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/f1ec1b78-4db1-45ac-9189-40619b7fad74/Derivates/2c238c6b-e380-486e-b9dc-39e41695a5ba.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (147, N'Pan negro', 259, 48.3, 3.3, 8.5, NULL, N'https://www.recetasnestle.com.mx/sites/default/files/styles/recipe_detail_desktop/public/srh_recipes/00a082b31803f14ef07d305e4d3e882a.png?itok=1ZhMMFJh')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (148, N'Mortadela', 311, 3.05, 25.4, 16.4, NULL, N'https://www.edamam.com/food-img/6f7/6f77f6684bd11be1b240aea4f016e54a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (149, N'Molleja', 94, 0, 2.1, 18, NULL, N'https://acdn.mitiendanube.com/stores/001/144/602/products/molleja-frigorifico-901-ef32378140fa658c2815864485895514-1024-1024.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (150, N'Morcilla', 379, 1.29, 34.5, 14.6, NULL, N'https://www.edamam.com/food-img/ec9/ec997418be4fcde1b20d76042cde646d.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (151, N'Guanciale', 393, 0, 37.1, 13.7, NULL, N'https://www.clarin.com/2023/10/09/k3mTu7v4C_2000x1500__1.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (152, N'Cacao en polvo sin azúcar', 228, 57.9, 13.7, 19.6, NULL, N'https://www.edamam.com/food-img/89a/89af89595db3cf2c3007f2b064c5fef6.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (153, N'Dulce de Leche', 315, 55.4, 7.35, 6.84, NULL, N'https://www.edamam.com/food-img/c37/c37810c27f826685d463d9395f448851.jpg ')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (154, N'Miel de Azahar', 304, 82.4, 0, 0.3, NULL, N'https://www.edamam.com/food-img/198/198c7b25c23b4235b4cc33818c7b335f.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (155, N'Mermelada', 245, 68.9, 0.1, 0.4, NULL, N'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Sevilleorangemarmalade.jpg/220px-Sevilleorangemarmalade.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (156, N'Azúcar moreno', 125, 8.93, 2.68, 17.86, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYhki6G-zu7X56N9zddMnn7055lgiw6K4LLA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (157, N'Caramelos', 382, 77, 8.1, 4.6, NULL, N'https://st2.depositphotos.com/1000504/6019/i/450/depositphotos_60190247-stock-photo-caramel-candies-and-caramel-sauce.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (158, N'Malvavisco', 318, 81.3, 0.2, 1.8, NULL, N'https://www.edamam.com/food-img/9c8/9c86a95af817e527adebbf8781aa7c4f.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (159, N'Cookies', 423, 65.86, 22.08, 5.25, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqRZnTDKjvM7yudN1ciGhlKezCXyjr_0VpNQ&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (160, N'Mazapán', 458, 47.8, 27.7, 9, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn1ee-lutwjJAnI3hr4uGvfKWOHl9NgYMfgA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (161, N'Vinagre de manzana', 21, 0.93, 0, 0, NULL, N'https://jumboargentina.vtexassets.com/arquivos/ids/657918/Vinagre-De-Manzana-Menoyo-1-L-1-237443.jpg?v=637637193147870000')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (162, N'Mayonesa', 692, 0, 77, 0, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_Xkq0EGZNnY08IqhDBDrOwuWv5vuiLAX2Rg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (163, N'Ketchup', 101, 27.4, 0.1, 1.04, NULL, N'https://www.edamam.com/food-img/257/257207c446011b849001ae596390341c.jpeg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (164, N'Tabasco', 12, 0.8, 0.76, 1.29, NULL, N'https://dcdn.mitiendanube.com/stores/495/644/products/tabasco-b61b61c65c859289ae15132623998863-480-0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (165, N'Albahaca', 23, 2.65, 0.64, 3.15, NULL, N'https://www.edamam.com/food-img/5f1/5f1b05685ac2b404236a5d1c1f3c8c10.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (166, N'Perejil', 36, 6.33, 0.79, 2.97, NULL, N'https://www.edamam.com/food-img/46a/46a132e96626d7989b4d6ed8c91f4da0.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (167, N'Tomillo', 101, 24.4, 1.68, 5.56, NULL, N'https://www.edamam.com/food-img/3e7/3e7cf3c8d767a90b906447f5e74059f7.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (168, N'Sal', 0, 0, 0, 0, NULL, N'https://www.edamam.com/food-img/694/6943ea510918c6025795e8dc6e6eaaeb.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (169, N'Canela', 247, 80.6, 1.24, 3.99, NULL, N'https://www.edamam.com/food-img/d4d/d4daa18b92c596a1c99c08537c38e65b.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (170, N'Nuez Moscada', 525, 49.3, 36.3, 5.84, NULL, N'https://www.edamam.com/food-img/b9e/b9e54f78ae18cf99a6504b472ba25e7b.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (171, N'Aceite de Oliva', 884, 0, 100, 0, NULL, N'https://www.edamam.com/food-img/4d6/4d651eaa8a353647746290c7a9b29d84.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (172, N'Aceite de girasol y aceite de semilla de uva', 800, 0, 93.33, 0, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXia_qqDWor6SFf2ev5NIwPIqDd9hr0Y4p1g&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (173, N'Aceite de coco', 892, 0, 99.1, 0, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7LQdRNBFtbMHAi6J_Jxd26SbTAr0dHdzrhg&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (174, N'Aceite de maíz', 900, 0, 100, 0, NULL, N'https://mejorconsalud.as.com/wp-content/uploads/2020/06/aceite-maiz-salud.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (175, N'Arroz', 360, 79.3, 0.58, 6.61, NULL, N'https://www.edamam.com/food-img/0fc/0fc9fa8a3e0276198d75b2e259068f8a.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (176, N'Baguette', 272, 51.9, 2.42, 10.8, NULL, N'https://cuk-it.com/wp-content/uploads/2023/09/thumb03-low-1-1024x576.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (177, N'Pan Blanco', 271.61, 50.44, 3.88, 11.64, NULL, N'https://www.recetasnestle.com.mx/sites/default/files/styles/recipe_detail_desktop/public/srh_recipes/625b703fb44882f93d81818017559317.png?itok=SVSQlyjH')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (178, N'Pan', 259, 46.1, 3.4, 10.7, NULL, NULL)
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (179, N'Pan pita', 275, 55.7, 1.2, 9.1, NULL, N'https://www.edamam.com/food-img/b8c/b8c2794a59279b7e0553c27e0769fbaf.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (180, N'Pan de hamburguesa', 282, 50.6, 4, 10, NULL, N'https://www.edamam.com/food-img/dbe/dbe3d135d1336ed19703d359e33d58dd.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (181, N'Vino', 85, 2.6, 0, 0.1, NULL, N'https://lh3.googleusercontent.com/proxy/IeKqIPqa6fiP92sJjHKwlM0OnkMs8FecnZFbxOgGVtkhlXf9PXO_IsohNSl0UbejgX8QAP4W1TxOA9m8wNOcQdpvId1XZjjk_56ZT0R-kmFrSLUX6xclxNNEmDepXuVyDPkGDIl6sYr-mzCtFfw_k2eobpNXXSsVhWKrVDK4ispfqJ6U5fBPo6JS-NsJISJRbA')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (182, N'Vino blanco', 82, 2.6, 0.1, 0, NULL, N'https://borrachines.com.ar/wp-content/uploads/2024/03/SOTTANO-TORRONTES-PAGINA.png')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (183, N'Maizena', 360, 90, 0, 0, NULL, N'https://media.glamour.mx/photos/6527bcc399637ec66fadf0f8/16:9/w_2992,h_1683,c_limit/maicena-para-aclarar-la-piel.jpg')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (185, N'Huevo', 143, 0.7, 9.5, 12.6, NULL, N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2agWTagxCHlvZiQc7nHLc7-4zkmSNE623OA&s')
INSERT [dbo].[Ingredientes] ([id], [nombre], [calorias], [carbohidratos], [grasas], [proteinas], [precio], [imagen]) VALUES (186, N'Esencia de vainilla', 288, 12.7, 0.1, 0.1, NULL, N'https://alicante.com.ar/wp-content/uploads/2022/06/52.png')
SET IDENTITY_INSERT [dbo].[Ingredientes] OFF
GO
SET IDENTITY_INSERT [dbo].[PasosReceta] ON 

INSERT [dbo].[PasosReceta] ([id], [idReceta], [nro], [titulo], [descripcion], [duracionMin]) VALUES (1, 1, 1, N'Previo a inicio', N' Precalentar el horno a 180°En un bol grande batir los huevos con el azúcar y la vainilla hasta homogeneizar y lograr que estén espumosos y cremosos.', 1)
INSERT [dbo].[PasosReceta] ([id], [idReceta], [nro], [titulo], [descripcion], [duracionMin]) VALUES (2, 1, 2, N'Mezcla', N'Agregar las tazas de harina y remover hasta unir completamente. Esta parte y a partir de aquí se hace con espátula o cuchara, no con batidora. ', 4)
INSERT [dbo].[PasosReceta] ([id], [idReceta], [nro], [titulo], [descripcion], [duracionMin]) VALUES (3, 1, 3, N'Liquido', N'Agregar la taza de aceite y lo mismo: remover hasta unir.', 2)
INSERT [dbo].[PasosReceta] ([id], [idReceta], [nro], [titulo], [descripcion], [duracionMin]) VALUES (4, 1, 4, N'Coccion', N'Llevar a horno moderado 180° por más o menos 40 o 45 minutos (siempre depende mucho de cada horno). Chequear su cocción con un palito de madera, al pinchar el budín de vainilla el palito debe salir seco.', 45)
SET IDENTITY_INSERT [dbo].[PasosReceta] OFF
GO
SET IDENTITY_INSERT [dbo].[Recetas] ON 

INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carbohidratos], [proteina], [grasas], [precio], [fechaPublicacion], [descripcion]) VALUES (1, N'Budin ', 5, N'https://www.recetasnestle.com.ar/sites/default/files/styles/recipe_detail_desktop/public/srh_recipes/35f1fb00fc30fb33fa09a0528c87a2c2.jpg?itok=je0vGI5p', 1, 1, 1, 1, 1, 1, 1, CAST(N'2024-06-17' AS Date), NULL)
INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carbohidratos], [proteina], [grasas], [precio], [fechaPublicacion], [descripcion]) VALUES (3, N'Ensalada', 4.9, N'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=', 1, 1, 1, 1, 1, 1, 1, CAST(N'2024-06-16' AS Date), NULL)
INSERT [dbo].[Recetas] ([id], [nombre], [rating], [imagen], [idcreador], [tiempoMins], [calorias], [carbohidratos], [proteina], [grasas], [precio], [fechaPublicacion], [descripcion]) VALUES (5, N'TodosLosTags', 3, N'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=', 1, 1, 1, 1, 1, 1, 1, CAST(N'2024-06-16' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Recetas] OFF
GO
SET IDENTITY_INSERT [dbo].[TagRecetas] ON 

INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (1, 2, 3)
INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (2, 1, 5)
INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (3, 2, 5)
INSERT [dbo].[TagRecetas] ([id], [idTag], [idReceta]) VALUES (4, 3, 5)
SET IDENTITY_INSERT [dbo].[TagRecetas] OFF
GO
INSERT [dbo].[Tags] ([id], [nombre], [specialTag]) VALUES (1, N'Carnivoro', 1)
INSERT [dbo].[Tags] ([id], [nombre], [specialTag]) VALUES (2, N'Vegetariano', 1)
INSERT [dbo].[Tags] ([id], [nombre], [specialTag]) VALUES (3, N'Celiaco', 1)
GO
SET IDENTITY_INSERT [dbo].[TagUsuario] ON 

INSERT [dbo].[TagUsuario] ([id], [idTag], [idUsuario]) VALUES (1, 2, 2)
INSERT [dbo].[TagUsuario] ([id], [idTag], [idUsuario]) VALUES (2, 1, 2)
SET IDENTITY_INSERT [dbo].[TagUsuario] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoCocina] ON 

INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (1, N'Internacional')
INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (2, N'Argentina')
INSERT [dbo].[TipoCocina] ([id], [nombre]) VALUES (3, N'Italiano')
SET IDENTITY_INSERT [dbo].[TipoCocina] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (1, N'PocketChef', N'budin2024', N'pocketchef@gmail.com', N'Pocket', N'Chef', 1122842270, N'budin', N'https://ibb.co/KWBp2ck')
INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (2, N'juancitogamer', N'soyjuan', N'juancitopanchito@gmail.com', N'Juan', N'Galdames', 1158490335, N'hola soy juan', N'https://img.freepik.com/foto-gratis/chico-guapo-seguro-posando-contra-pared-blanca_176420-32936.jpg')
INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (3, N'vegano', N'soyvegano', N'veg@gmail.com', N'Maxi', N'Garbanzo', 1011124124, N'a', N'a')
INSERT [dbo].[Usuarios] ([id], [nombreusuario], [contrasena], [mail], [nombre], [apellido], [telefono], [descripcion], [imagen]) VALUES (4, N'canetesantiago@gmail.com', N'$2a$10$rj/UCRv1efajYNYyXPmHZOLNV4Lc8YrvYKVBQMnBxM5YqMbIDH9ua', N'canetesantiago@gmail.com', N'santiago', N'canete', 1183753875, NULL, N'')
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
