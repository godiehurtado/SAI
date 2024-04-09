-- =============================================
-- Author:		Frank Payares
-- Create date: 03/01/2012
-- Description:	Insertar en la tabla LogCargue el cual se encuentra la información inválida durante el cargue
-- =============================================
CREATE PROCEDURE [dbo].[Presupuesto_InsertarLog]
	@hoja			varchar(50),
	@fila			int,
	@texto			varchar(500),
	@codigoNivel	varchar(50),
	@codigoMeta		varchar(100),
	@anio			varchar(4),
	@Enero			float,
	@Febrero		float,
	@Marzo			float,
	@Abril			float,
	@Mayo			float,
	@Junio			float,
	@Julio			float,
	@Agosto			float,
	@Septiembre		float,
	@Octubre		float,
	@Noviembre		float,
	@Diciembre		float,
	@presupuesto_id int
AS
BEGIN
	INSERT INTO LogCargue VALUES (
		'Hoja '+ @hoja +', Fila '+ CAST((@fila + 1) AS varchar(10)) +' - '+ @texto + ';' +
		@codigoNivel + ';' +
		@codigoMeta + ';' +
		@anio + ';' +
		CAST(@Enero AS varchar(100)) + ';' +
		CAST(@Febrero AS varchar(100)) + ';' +
		CAST(@Marzo AS varchar(100)) + ';' +
		CAST(@Abril AS varchar(100)) + ';' +
		CAST(@Mayo AS varchar(100)) + ';' +
		CAST(@Junio AS varchar(100)) + ';' +
		CAST(@Julio AS varchar(100)) + ';' +
		CAST(@Agosto AS varchar(100)) + ';' +
		CAST(@Septiembre AS varchar(100)) + ';' +
		CAST(@Octubre AS varchar(100)) + ';' +
		CAST(@Noviembre AS varchar(100)) + ';' +
		CAST(@Diciembre AS varchar(100)),
		@presupuesto_id,
		1
	)
END