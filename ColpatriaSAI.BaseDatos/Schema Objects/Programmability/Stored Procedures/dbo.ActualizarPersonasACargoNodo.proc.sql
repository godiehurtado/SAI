-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarPersonasACargoNodo]
	-- Add the parameters for the stored procedure here
	@jerarquiaDetalleId int = null 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @nivel_id int, @contNivel int, @mes int, @anio int

	SET @mes = MONTH(GETDATE())
	SET @anio = YEAR(GETDATE())

	-- Borramos las personas a cargo para este mes
	IF @jerarquiaDetalleId is null
		DELETE FROM PersonasACargoNivel WHERE mes = @mes AND anio = @anio
	ELSE
		DELETE FROM PersonasACargoNivel WHERE mes = @mes AND anio = @anio AND jerarquiaDetalle_id = @jerarquiaDetalleId

	DECLARE @Niveles CURSOR SET @Niveles = CURSOR /*SCROLL*/ FAST_FORWARD FOR	
	
	-- Traemos los niveles de la jerarquia
	SELECT id as nivel_id FROM nivel as n WHERE n.id <> 0 ORDER BY id
	
	-- Recorro los niveles
	OPEN @Niveles FETCH NEXT FROM @Niveles INTO @nivel_id
	WHILE @@FETCH_STATUS = 0 BEGIN	

		IF @jerarquiaDetalleId is null
		BEGIN
			INSERT INTO PersonasACargoNivel(jerarquiaDetalle_id, nivel_id, cantidad, mes, anio)
			SELECT
			jd.id,	
			@nivel_id,			
			count(*) as totalHijos,
			@mes,
			@anio			
			FROM	
				jerarquiaDetalle as jd
				CROSS APPLY ObtenerHijosNodoNivel(jd.id, @nivel_id) as hijos
				INNER JOIN Participante p ON p.id = hijos.participante_id
			WHERE hijos.id <> jd.id	and jd.id <> 0  and p.fechaRetiro = '1900-01-01'
			GROUP BY jd.id, jd.nivel_id
		END
		ELSE
		BEGIN
			INSERT INTO PersonasACargoNivel(jerarquiaDetalle_id, nivel_id, cantidad, mes, anio)
			SELECT 
				@jerarquiaDetalleId as id,
				@nivel_id,
				count(*) as totalHijos,
				@mes,
				@anio
			FROM 
				ObtenerHijosNodoNivel(@jerarquiaDetalleId, @nivel_id) as hijos
				INNER JOIN Participante p ON p.id = hijos.participante_id
			WHERE hijos.id <> @jerarquiaDetalleId  and p.fechaRetiro = '1900-01-01'
		END
			
		FETCH NEXT FROM @Niveles INTO @nivel_id
	END CLOSE @Niveles DEALLOCATE @Niveles	
END
