-- =============================================
-- Author:		Frank Payares
-- Create date: 15/09/2011
-- Description:	Obtiene la nota del cumplimiento de una meta
-- =============================================
CREATE FUNCTION [dbo].[getNotaMeta] (
	@Cumplimiento	float = 0,
    @idMeta			int = 0,
    @Mes			int = 0
)
RETURNS float
AS
BEGIN
	--DECLARE @Cumplimiento float=1.23663547761317, @idMeta int=222, @Mes int=8
	DECLARE @NotaFinal float = 0
	IF (@Cumplimiento <> 0 AND @idMeta <> 0 and @Mes <> 0)
	BEGIN
		--DECLARE @Cumplimiento float=1.23663547761317, @idMeta int=222, @Mes int=8
		DECLARE @Factor1 float		DECLARE @Nota1 float
		DECLARE @Factor2 float		DECLARE @Nota2 float

		SELECT Top 1 @Factor1 = factor, @Nota1 = nota
		FROM ModeloxMeta INNER JOIN
			FactorxNota ON ModeloxMeta.factorxnota_id = FactorxNota.id INNER JOIN
			PeriodoFactorxNota ON FactorxNota.id = PeriodoFactorxNota.factorxnota_id INNER JOIN
			FactorxNotaDetalle ON PeriodoFactorxNota.id = FactorxNotaDetalle.periodofactorxnota_id
		WHERE month(PeriodoFactorxNota.fechaIni) = @Mes AND ModeloxMeta.id = @idMeta and nota <= @Cumplimiento ORDER BY nota DESC
			
		SELECT Top 1 @Factor2 = factor, @Nota2 = nota
		FROM ModeloxMeta INNER JOIN
			FactorxNota ON ModeloxMeta.factorxnota_id = FactorxNota.id INNER JOIN
			PeriodoFactorxNota ON FactorxNota.id = PeriodoFactorxNota.factorxnota_id INNER JOIN
			FactorxNotaDetalle ON PeriodoFactorxNota.id = FactorxNotaDetalle.periodofactorxnota_id
		WHERE month(PeriodoFactorxNota.fechaIni) = @Mes AND ModeloxMeta.id = @idMeta and nota >= @Cumplimiento ORDER BY nota DESC
		
		--select @Factor1 as Factor1, @Nota1 as Nota1		select @Factor2 as Factor2, @Nota2 as Nota2
		IF (@Cumplimiento > @Nota1 and @Cumplimiento < @Nota2)
			SET @NotaFinal = ((@Cumplimiento-@Nota1)/(@Nota2-@Nota1))*(@Factor2-@Factor1)+@Factor1
		ELSE IF @Cumplimiento = @Nota1
			SET @NotaFinal = @Nota1
		ELSE
			SET @NotaFinal = @Nota2
	END
	--select @NotaFinal
	RETURN @NotaFinal
END
--select dbo.getNotaMeta(108,15,8)