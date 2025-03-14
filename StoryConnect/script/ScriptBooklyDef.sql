USE [master]
GO
/****** Object:  Database [BOOKLY]    Script Date: 14/03/2025 1:58:54 ******/
CREATE DATABASE [BOOKLY]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BOOKLY', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BOOKLY.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BOOKLY_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\BOOKLY_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [BOOKLY] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BOOKLY].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BOOKLY] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BOOKLY] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BOOKLY] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BOOKLY] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BOOKLY] SET ARITHABORT OFF 
GO
ALTER DATABASE [BOOKLY] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BOOKLY] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BOOKLY] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BOOKLY] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BOOKLY] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BOOKLY] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BOOKLY] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BOOKLY] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BOOKLY] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BOOKLY] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BOOKLY] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BOOKLY] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BOOKLY] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BOOKLY] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BOOKLY] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BOOKLY] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BOOKLY] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BOOKLY] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BOOKLY] SET  MULTI_USER 
GO
ALTER DATABASE [BOOKLY] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BOOKLY] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BOOKLY] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BOOKLY] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BOOKLY] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BOOKLY] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BOOKLY] SET QUERY_STORE = ON
GO
ALTER DATABASE [BOOKLY] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [BOOKLY]
GO
/****** Object:  Table [dbo].[autores]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[autores](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[biografia] [nvarchar](max) NULL,
	[imagen_perfil] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[libros]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros](
	[id] [int] NOT NULL,
	[titulo] [nvarchar](255) NOT NULL,
	[autor_id] [int] NULL,
	[saga] [nvarchar](255) NULL,
	[posicion_saga] [int] NULL,
	[fecha_publicacion] [date] NULL,
	[paginas] [int] NULL,
	[sinopsis] [nvarchar](max) NULL,
	[imagen] [nvarchar](max) NULL,
	[calificacion] [decimal](3, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario_lista_predefinida_libro]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario_lista_predefinida_libro](
	[usuario_id] [int] NOT NULL,
	[lista_predefinida_id] [int] NOT NULL,
	[libro_id] [int] NOT NULL,
	[fecha_agregado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC,
	[lista_predefinida_id] ASC,
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LIBROS_CON_LISTA]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[V_LIBROS_CON_LISTA] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    COALESCE(ulpl.lista_predefinida_id, 0) AS ListaId, -- Si no está en una lista, poner 0
    ulpl.usuario_id AS UsuarioID
FROM 
    libros l
JOIN 
    autores a ON l.autor_id = a.id
LEFT JOIN 
    usuario_lista_predefinida_libro ulpl 
    ON l.id = ulpl.libro_id;
GO
/****** Object:  View [dbo].[V_LIBROS]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[V_LIBROS] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor
FROM 
    libros l
JOIN 
    autores a ON l.autor_id = a.id;
GO
/****** Object:  View [dbo].[V_AUTORES_LIBROS]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_AUTORES_LIBROS] AS
SELECT 
    a.id AS AutorId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro
FROM 
    autores a
JOIN 
    libros l ON a.id = l.autor_id;
GO
/****** Object:  Table [dbo].[objetivos_lectura]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[objetivos_lectura](
	[id] [int] NOT NULL,
	[usuario_id] [int] NULL,
	[titulo] [nvarchar](255) NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_fin] [date] NOT NULL,
	[tipo] [nvarchar](10) NOT NULL,
	[meta] [int] NOT NULL,
	[progreso] [int] NULL,
	[estado] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_OBJETIVOS_LECTURA]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_OBJETIVOS_LECTURA] AS
SELECT 
    o.id AS ObjetivoId,
    o.usuario_id AS UsuarioId,
    o.titulo AS NombreObjetivo,
    o.fecha_inicio AS FechaInicio,
    o.fecha_fin AS FechaFin,
    o.tipo AS TipoObjetivo,  -- 'libros' o 'paginas'
    o.meta AS MetaTotal,
    o.progreso AS ProgresoActual,
    o.estado AS EstadoObjetivo  -- 'activo' o 'archivado'
FROM objetivos_lectura o;
GO
/****** Object:  Table [dbo].[etiquetas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[etiquetas](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[libros_etiquetas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros_etiquetas](
	[libro_id] [int] NOT NULL,
	[etiqueta_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[libro_id] ASC,
	[etiqueta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DETALLES_LIBRO]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DETALLES_LIBRO] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacion,
    l.paginas AS Paginas,
    l.sinopsis AS Sinopsis,
    l.imagen AS ImagenPortada,
    l.calificacion AS CalificacionPromedio,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    STRING_AGG(e.nombre, ', ') AS Etiquetas
FROM libros l
JOIN autores a ON l.autor_id = a.id
LEFT JOIN libros_etiquetas le ON l.id = le.libro_id
LEFT JOIN etiquetas e ON le.etiqueta_id = e.id
GROUP BY l.id, l.titulo, l.saga, l.posicion_saga, l.fecha_publicacion, 
         l.paginas, l.sinopsis, l.imagen, l.calificacion, a.id, a.nombre;
GO
/****** Object:  Table [dbo].[listas_predefinidas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[listas_predefinidas](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LIBROS_LEIDOS]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_LEIDOS] AS
SELECT 
    ulpl.usuario_id AS UsuarioId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.imagen AS ImagenLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    l.fecha_publicacion AS FechaPublicacion
FROM usuario_lista_predefinida_libro ulpl
JOIN listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN libros l ON ulpl.libro_id = l.id
JOIN autores a ON l.autor_id = a.id 
WHERE lp.nombre = 'Leído';
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[imagen_perfil] [nvarchar](max) NULL,
	[password_hash] [varbinary](max) NOT NULL,
	[password_salt] [nvarchar](50) NOT NULL,
	[password] [nvarchar](max) NULL,
	[tipo_usuario] [nvarchar](10) NULL,
	[fecha_registro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_COUNT_PREDEFINIDAS]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_COUNT_PREDEFINIDAS] AS
SELECT 
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    lp.id AS lista_id,
    lp.nombre AS nombre_lista,
    COUNT(ulpl.libro_id) AS cantidad_libros
FROM 
    usuarios u
CROSS JOIN 
    listas_predefinidas lp
LEFT JOIN 
    usuario_lista_predefinida_libro ulpl ON u.id = ulpl.usuario_id AND lp.id = ulpl.lista_predefinida_id
GROUP BY 
    u.id, u.nombre, lp.id, lp.nombre;
GO
/****** Object:  View [dbo].[V_LIBROS_PREDEFINIDAS]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_PREDEFINIDAS] AS
SELECT 
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    lp.id AS lista_id,
    lp.nombre AS nombre_lista,
    l.id AS libro_id,
    l.titulo AS titulo_libro,
    l.autor_id,  -- Incluimos el ID del autor
    a.nombre AS autor_nombre, -- Apellido del autor
    l.imagen AS portada_libro,
    ulpl.fecha_agregado
FROM 
    usuarios u
JOIN 
    usuario_lista_predefinida_libro ulpl ON u.id = ulpl.usuario_id
JOIN 
    listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN 
    libros l ON ulpl.libro_id = l.id
JOIN 
    autores a ON l.autor_id = a.id;  
GO
/****** Object:  View [dbo].[V_LIBROS_LEYENDO]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_LEYENDO] AS
SELECT 
    ulpl.usuario_id AS UsuarioId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.imagen AS ImagenLibro,
	l.paginas AS NumeroPaginas,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    l.fecha_publicacion AS FechaPublicacion,
    lp.id AS ListaId  -- Agregar el ID de la lista
FROM usuario_lista_predefinida_libro ulpl
JOIN listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN libros l ON ulpl.libro_id = l.id
JOIN autores a ON l.autor_id = a.id 
WHERE lp.nombre = 'Leyendo';
GO
/****** Object:  Table [dbo].[listas_personalizadas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[listas_personalizadas](
	[id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[progreso_lectura]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[progreso_lectura](
	[id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[libro_id] [int] NOT NULL,
	[porcentaje_leido] [decimal](5, 2) NULL,
	[pagina_actual] [int] NULL,
	[estado_lectura] [varchar](20) NOT NULL,
	[fecha_inicio] [date] NULL,
	[fecha_ultima_actualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_progreso_usuario_libro] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC,
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resenas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resenas](
	[id] [int] NOT NULL,
	[usuario_id] [int] NULL,
	[libro_id] [int] NULL,
	[calificacion] [int] NULL,
	[texto] [nvarchar](max) NULL,
	[fecha_publicacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_libro_titulo]    Script Date: 14/03/2025 1:58:55 ******/
CREATE NONCLUSTERED INDEX [idx_libro_titulo] ON [dbo].[libros]
(
	[titulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_objetivos_usuario]    Script Date: 14/03/2025 1:58:55 ******/
CREATE NONCLUSTERED INDEX [idx_objetivos_usuario] ON [dbo].[objetivos_lectura]
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_reseñas_libro]    Script Date: 14/03/2025 1:58:55 ******/
CREATE NONCLUSTERED INDEX [idx_reseñas_libro] ON [dbo].[resenas]
(
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_usuario_email]    Script Date: 14/03/2025 1:58:55 ******/
CREATE NONCLUSTERED INDEX [idx_usuario_email] ON [dbo].[usuarios]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[libros] ADD  DEFAULT ((0)) FOR [calificacion]
GO
ALTER TABLE [dbo].[listas_personalizadas] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT (getdate()) FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT ((0)) FOR [progreso]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT ('activo') FOR [estado]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT ((0)) FOR [porcentaje_leido]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT ((0)) FOR [pagina_actual]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT (getdate()) FOR [fecha_ultima_actualizacion]
GO
ALTER TABLE [dbo].[resenas] ADD  DEFAULT (getdate()) FOR [fecha_publicacion]
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro] ADD  DEFAULT (getdate()) FOR [fecha_agregado]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT ('lector') FOR [tipo_usuario]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD FOREIGN KEY([autor_id])
REFERENCES [dbo].[autores] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros_etiquetas]  WITH CHECK ADD FOREIGN KEY([etiqueta_id])
REFERENCES [dbo].[etiquetas] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros_etiquetas]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[listas_personalizadas]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
/****** Object:  StoredProcedure [dbo].[INSERT_OBJETIVO]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_OBJETIVO]
    @usuario_id INT,
    @titulo NVARCHAR(255),
    @fecha_fin DATE,
    @tipo NVARCHAR(10),
    @meta INT
AS
BEGIN
    DECLARE @nuevo_id INT;

    -- Obtenemos el ID máximo actual y sumamos 1
    SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM objetivos_lectura;

    -- Verificamos que el tipo de objetivo sea válido
    IF @tipo NOT IN ('libros', 'paginas')
    BEGIN
        RAISERROR('El tipo de objetivo debe ser "libros" o "paginas".', 16, 1);
        RETURN;
    END

    -- Insertamos el nuevo objetivo en la tabla
    INSERT INTO objetivos_lectura (id, usuario_id, titulo, fecha_inicio, fecha_fin, tipo, meta, progreso, estado)
    VALUES (@nuevo_id, @usuario_id, @titulo, GETDATE(), @fecha_fin, @tipo, @meta, 0, 'activo');
    
    -- Confirmamos que el objetivo se ha insertado correctamente
    PRINT 'Objetivo insertado correctamente con ID: ' + CAST(@nuevo_id AS NVARCHAR);
END;
GO
/****** Object:  StoredProcedure [dbo].[INSERT_RESENA]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_RESENA]
    @usuario_id INT,
    @libro_id INT,
    @calificacion INT,
    @texto NVARCHAR(MAX) = NULL
AS
BEGIN
    -- Declaramos la variable para el nuevo ID
    DECLARE @nuevo_id INT;

    -- Obtenemos el nuevo ID (máximo actual + 1)
    SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM resenas;

    -- Insertamos la nueva reseña
    INSERT INTO resenas (id, usuario_id, libro_id, calificacion, texto)
    VALUES (@nuevo_id, @usuario_id, @libro_id, @calificacion, @texto);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarProgresoLectura]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarProgresoLectura]
    @UsuarioId INT,
    @LibroId INT
	AS
	BEGIN
		DECLARE @nuevo_id INT;
		DECLARE @time DATETIME = GetDate();

    -- Obtenemos el nuevo ID (máximo actual + 1)
		SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM progreso_lectura;
        INSERT INTO progreso_lectura (id, usuario_id, libro_id, porcentaje_leido, pagina_actual, estado_lectura, fecha_inicio, fecha_ultima_actualizacion)
        VALUES (@nuevo_id, @UsuarioId, @LibroId, 0,0,'leyendo', @time,@time)
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_MoverLibroEntreListas]    Script Date: 14/03/2025 1:58:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_MoverLibroEntreListas]
    @UsuarioID INT,
    @LibroID INT,
    @ListaOrigenID INT,
    @ListaDestinoID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ResultCode INT = 0;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Si el libro está en CUALQUIER lista (no solo la de origen), eliminarlo
        DELETE FROM usuario_lista_predefinida_libro
        WHERE usuario_id = @UsuarioID 
        AND libro_id = @LibroID;
        
        -- Si el ListaDestinoID no es 0 (0 podría ser un código para "quitar de todas las listas"), 
        -- entonces agregamos a la lista destino
        IF @ListaDestinoID > 0
        BEGIN
            -- Insertar en la lista de destino
            INSERT INTO usuario_lista_predefinida_libro (usuario_id, lista_predefinida_id, libro_id, fecha_agregado)
            VALUES (@UsuarioID, @ListaDestinoID, @LibroID, GETDATE());
            SET @ResultCode = 1;
        END
        ELSE
        BEGIN
            -- Solo eliminamos el libro de todas las listas
            SET @ResultCode = 2;
        END
        
        COMMIT TRANSACTION;
        SELECT @ResultCode AS ResultCode;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage,
               -1 AS ResultCode;
    END CATCH;
END;
GO
USE [master]
GO
ALTER DATABASE [BOOKLY] SET  READ_WRITE 
GO
