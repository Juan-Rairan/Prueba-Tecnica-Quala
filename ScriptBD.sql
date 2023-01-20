USE [TestDB]
GO
/****** Object:  Table [dbo].[SUCURSALES]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUCURSALES](
	[Id_Sucursal] [bigint] IDENTITY(1,1) NOT NULL,
	[Codigo_Sucursal] [bigint] NULL,
	[Descripcion] [varchar](251) NULL,
	[Direccion] [varchar](300) NULL,
	[Identificacion] [varchar](251) NULL,
	[Fecha_Creacion_User] [datetime] NULL,
	[Id_Moneda] [int] NULL,
	[Estado] [bit] NULL,
	[Fecha_Creacion] [datetime] NULL,
 CONSTRAINT [PK_SUCURSALES] PRIMARY KEY CLUSTERED 
(
	[Id_Sucursal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIPOS_MONEDA]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOS_MONEDA](
	[Id_Moneda] [int] IDENTITY(1,1) NOT NULL,
	[Pais] [varchar](30) NULL,
	[Moneda] [varchar](50) NULL,
	[Acronimo] [varchar](20) NULL,
	[Estado] [bit] NULL,
	[Fecha_Creacion] [datetime] NULL,
	[Usuario_Creacion] [varchar](25) NULL,
 CONSTRAINT [PK_TIPOS_MONEDA] PRIMARY KEY CLUSTERED 
(
	[Id_Moneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOS](
	[Id_Usuario] [bigint] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](50) NULL,
	[Contrasena] [varchar](200) NULL,
	[Nombres] [varchar](60) NULL,
	[Apellidos] [varchar](60) NULL,
	[Estado] [bit] NULL,
	[Fecha_Creacion] [datetime] NULL,
 CONSTRAINT [PK_USUARIOS] PRIMARY KEY CLUSTERED 
(
	[Id_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SUCURSALES] ADD  CONSTRAINT [DF_SUCURSALES_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[SUCURSALES] ADD  CONSTRAINT [DF_SUCURSALES_Fecha_Creacion]  DEFAULT (getdate()) FOR [Fecha_Creacion]
GO
ALTER TABLE [dbo].[TIPOS_MONEDA] ADD  CONSTRAINT [DF_TIPOS_MONEDA_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[TIPOS_MONEDA] ADD  CONSTRAINT [DF_TIPOS_MONEDA_Fecha_Creacion]  DEFAULT (getdate()) FOR [Fecha_Creacion]
GO
ALTER TABLE [dbo].[TIPOS_MONEDA] ADD  CONSTRAINT [DF_TIPOS_MONEDA_Usuario_Creacion]  DEFAULT (suser_sname()) FOR [Usuario_Creacion]
GO
ALTER TABLE [dbo].[USUARIOS] ADD  CONSTRAINT [DF_USUARIOS_Estado]  DEFAULT ((1)) FOR [Estado]
GO
ALTER TABLE [dbo].[USUARIOS] ADD  CONSTRAINT [DF_USUARIOS_Fecha_Creacion]  DEFAULT (getdate()) FOR [Fecha_Creacion]
GO
ALTER TABLE [dbo].[SUCURSALES]  WITH CHECK ADD  CONSTRAINT [FK_SUCURSALES_SUCURSALES] FOREIGN KEY([Id_Sucursal])
REFERENCES [dbo].[SUCURSALES] ([Id_Sucursal])
GO
ALTER TABLE [dbo].[SUCURSALES] CHECK CONSTRAINT [FK_SUCURSALES_SUCURSALES]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Delete_Sucursal]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para desactivar sucursales
-- =============================================
--GRANT EXEC ON Sp_Get_Moneda TO SA  - EL USUARIO ADMINISTRADOR NO NECESITA PERMISOS EN ESTE CASO
create PROCEDURE [dbo].[Sp_Delete_Sucursal] 
	@Id_Sucursal int

AS
BEGIN
	SET NOCOUNT ON;
	
		BEGIN TRY
		BEGIN TRANSACTION T1
			UPDATE SUCURSALES SET Estado = 0 WHERE Id_Sucursal = @Id_Sucursal 
			IF(@@ROWCOUNT > 0)
			BEGIN 
				SELECT 'Se ha eliminado la sucursal de manera correcta' as RESULT 
			END
			ELSE
			BEGIN
				SELECT 'Error al eliminar la sucursal'  as RESULT 
			END

		COMMIT TRANSACTION T1
	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION T1
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Moneda]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para traer los tipos de Moneda guardadas en la BD
-- =============================================
--GRANT EXEC ON Sp_Get_Moneda TO SA  - EL USUARIO ADMINISTRADOR NO NECESITA PERMISOS EN ESTE CASO
CREATE PROCEDURE [dbo].[Sp_Get_Moneda] 

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		SELECT Id_Moneda, Pais, Moneda, Acronimo FROM TIPOS_MONEDA 
		WHERE Estado = 1
	END TRY
	BEGIN CATCH
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Get_Sucursales]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para traer las sucursales activas
-- =============================================
--GRANT EXEC ON Sp_Get_Moneda TO SA  - EL USUARIO ADMINISTRADOR NO NECESITA PERMISOS EN ESTE CASO
CREATE PROCEDURE [dbo].[Sp_Get_Sucursales] 

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

		SELECT a.Id_Sucursal, a.Codigo_Sucursal, a.Descripcion, Direccion, Identificacion, CONVERT(VARCHAR, CONVERT(DATE,Fecha_Creacion_User, 31)) AS Fecha_Creacion_User, a.Id_Moneda, B.Moneda
		FROM SUCURSALES a
			JOIN TIPOS_MONEDA b ON a.Id_Moneda = b.Id_Moneda
		WHERE a.Estado = 1

	END TRY
	BEGIN CATCH
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Save_Sucursal]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para guardar sucursales
-- =============================================
--GRANT EXEC ON Sp_Get_Moneda TO SA  - EL USUARIO ADMINISTRADOR NO NECESITA PERMISOS EN ESTE CASO
CREATE PROCEDURE [dbo].[Sp_Save_Sucursal] 
	@code int, 
	@description varchar(250), 
	@address varchar(250), 
	@CreateDate DATE, 
	@money int,
	@identi varchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	
		BEGIN TRY
		BEGIN TRANSACTION T1
	
			DECLARE
				@ERROR VARCHAR(200) = ''

				IF LEN(@description) > 250 
				BEGIN
					SET @ERROR  = 'Error - la descripción no puede superar los 250 caracteres' 
				END

				IF LEN(@address) > 250 
				BEGIN
					SET @ERROR  = 'Error - la Dirección no puede superar los 250 caracteres' 
				END

				IF LEN(@identi)> 250  
				BEGIN
					SET @ERROR  = 'Error - la Identificacion no puede superar los 50 caracteres' 
				END

				IF CONVERT(DATE,@CreateDate, 31) > CONVERT(DATE, GETDATE())
				BEGIN
					SET @ERROR  = 'Error - la Fecha de creación no puede ser mayor a la actual' 
				END

				IF(@ERROR != '')
				BEGIN
					SELECT @ERROR AS RESULT
				END
				ELSE
				BEGIN 
					INSERT INTO SUCURSALES (Codigo_Sucursal, Descripcion ,Direccion ,Identificacion ,Fecha_Creacion_User, Id_Moneda) VALUES
					(@code, @description, @address, @identi, @CreateDate, @money)
					SELECT 'Se creó la sucursal de manera correcta' as RESULT
				END

		COMMIT TRANSACTION T1
	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION T1
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_Update_Sucursal]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para Actualizar las sucursales
-- =============================================
--GRANT EXEC ON Sp_Get_Moneda TO SA  - EL USUARIO ADMINISTRADOR NO NECESITA PERMISOS EN ESTE CASO
create PROCEDURE [dbo].[Sp_Update_Sucursal] 
	@Id_Sucursal int,
	@Codigo_Sucursal int ,
	@Descripcion varchar(251),
	@Direccion varchar(251), 
	@Fecha_Creacion_User date, 
	@Id_Moneda int, 
	@Identificacion varchar(51)
AS
BEGIN
	SET NOCOUNT ON;
	
		BEGIN TRY
		BEGIN TRANSACTION T1
	
			DECLARE
				@ERROR VARCHAR(200) = ''

				IF LEN(@Descripcion) > 250 
				BEGIN
					SET @ERROR  = 'Error - la descripción no puede superar los 250 caracteres' 
				END

				IF LEN(@Direccion) > 250 
				BEGIN
					SET @ERROR  = 'Error - la Dirección no puede superar los 250 caracteres' 
				END

				IF LEN(@Identificacion)> 250  
				BEGIN
					SET @ERROR  = 'Error - la Identificacion no puede superar los 50 caracteres' 
				END

				IF CONVERT(DATE,@Fecha_Creacion_User, 31) > CONVERT(DATE, GETDATE())
				BEGIN
					SET @ERROR  = 'Error - la Fecha de creación no puede ser mayor a la actual' 
				END

				IF(@ERROR != '')
				BEGIN
					SELECT @ERROR AS RESULT
				END
				ELSE
				BEGIN 
					UPDATE SUCURSALES SET 
						Codigo_Sucursal = @Codigo_Sucursal, 
						Descripcion = @Descripcion,
						Direccion = @Direccion,
						Fecha_Creacion = @Fecha_Creacion_User,
						Id_Moneda = @Id_Moneda,
						Identificacion = @Identificacion
					WHERE Id_Sucursal = @Id_Sucursal

					SELECT 'Se ha actualizado la sucursal de manera correcta' as RESULT
				END

		COMMIT TRANSACTION T1
	END TRY	
	BEGIN CATCH
		ROLLBACK TRANSACTION T1
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Sp_valid_User]    Script Date: 20/01/2023 6:44:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Juan Camilo Rairan
-- Create date: 2023-01-19
-- Description:	Procedimineto para validar que el usuario se encuentre en la base de datos
-- =============================================
--GRANT EXEC ON Sp_valid_User TO SA
CREATE PROCEDURE [dbo].[Sp_valid_User] 
	@user varchar(200),
	@passw varchar(200)

AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		IF
			(
				SELECT COUNT(*) FROM USUARIOS 
				WHERE Usuario = @user 
				AND Contrasena = @passw
			 ) > 0
			BEGIN 
				SELECT 'OK' RESULT
			END
			ELSE
			BEGIN 
				SELECT 'ERROR - Usuario o contraseña invalido' AS RESULT
			END
	END TRY
	BEGIN CATCH
		SELECT 'ERROR - ' + TRY_CONVERT(VARCHAR,ERROR_MESSAGE()) + ' EN LA LÍNEA ' + TRY_CONVERT(VARCHAR,ERROR_LINE()) 
	END CATCH
END
GO
SET IDENTITY_INSERT [dbo].[TIPOS_MONEDA] ON 
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (1, N'África occidental ', N' Franco CFA de África Occidental ', N' XOF', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (2, N'Albania ', N' Lek ', N' ALL', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (3, N'Alemania ', N' Euro ', N' EUR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (4, N'American Samoa ', N' Dólar americano ', N' USD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (5, N'Angola ', N' Kwanza ', N' AOA', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (6, N'Antigua y Barbuda ', N' Dólar del caribe oriental ', N' XCD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (7, N'Antillas Holandesas ', N' Florín de Antillas Holandesas ', N' ANG', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (8, N'Arabia Saudí ', N' Rial saudí ', N' SAR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (9, N'Argel ', N' Dinar argelino ', N' DZD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (10, N'Argentina ', N' Peso argentino ', N' ARS', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (11, N'Aruba ', N' Florín de Aruba ', N' AWG', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (12, N'Australia ', N' Dólar australiano ', N' AUD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (13, N'Austria ', N' Euro ', N' EUR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (14, N'India ', N' Rupia india ', N' INR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (15, N'Indonesia ', N' Rupia indonesia ', N' IDR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (16, N'Iraq ', N' Dinar iraquí ', N' IQD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (17, N'Isla Christmas ', N' Dólar australiano ', N' AUD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (18, N'Isla Cocos ', N' Dólar australiano ', N' AUD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (19, N'Islandia ', N' Corona islandesa ', N' ISK', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (20, N'Islas Caimán ', N' Dólar de Islas Caimán ', N' KYD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (21, N'Islas Fiyi ', N' Dólar fiyiano ', N' FJD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (22, N'Islas Heard y Mc Donald ', N' Dólar australiano ', N' AUD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (23, N'Islas Marianas del Norte ', N' Dólar americano ', N' USD', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (24, N'Israel ', N' Nuevo shequel israelí ', N' ILS', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
INSERT [dbo].[TIPOS_MONEDA] ([Id_Moneda], [Pais], [Moneda], [Acronimo], [Estado], [Fecha_Creacion], [Usuario_Creacion]) VALUES (25, N'Italia ', N' Euro ', N' EUR', 1, CAST(N'2023-01-20T00:50:37.420' AS DateTime), N'sa')
GO
SET IDENTITY_INSERT [dbo].[TIPOS_MONEDA] OFF