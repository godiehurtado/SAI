-- =============================================
-- Author:		Frank Payares
-- Create date: 15/09/2011
-- Description:	Obtiene la nota del cumplimiento de una meta
-- =============================================
CREATE FUNCTION [dbo].[getNotaModelo] (
	@NotaDefinitiva	float = 0,
    @idModelo		int = 0,
    @Mes			int = 0
)
RETURNS float
AS
BEGIN
	DECLARE @FactorFinal float = 0
	IF (@NotaDefinitiva <> 0 AND @idModelo <> 0 and @Mes <> 0)
	BEGIN
		--DECLARE @NotaDefinitiva float set @NotaDefinitiva = 108	DECLARE @idModelo int set @idModelo = 19	DECLARE @Mes int set @Mes = 8
		DECLARE @Factor1 float		DECLARE @Nota1 float
		DECLARE @Factor2 float		DECLARE @Nota2 float

		SELECT Top 1 @Factor1 = factor, @Nota1 = nota
		FROM Modelo INNER JOIN
			FactorxNota ON Modelo.factorxnota_id = FactorxNota.id INNER JOIN
			PeriodoFactorxNota ON FactorxNota.id = PeriodoFactorxNota.factorxnota_id INNER JOIN
			FactorxNotaDetalle ON PeriodoFactorxNota.id = FactorxNotaDetalle.periodofactorxnota_id
		WHERE month(PeriodoFactorxNota.fechaIni) = @Mes AND Modelo.id = @idModelo and nota <= @NotaDefinitiva order by nota desc
			
		SELECT Top 1 @Factor2 = factor, @Nota2 = nota
		FROM Modelo INNER JOIN
			FactorxNota ON Modelo.factorxnota_id = FactorxNota.id INNER JOIN
			PeriodoFactorxNota ON FactorxNota.id = PeriodoFactorxNota.factorxnota_id INNER JOIN
			FactorxNotaDetalle ON PeriodoFactorxNota.id = FactorxNotaDetalle.periodofactorxnota_id
		WHERE month(PeriodoFactorxNota.fechaIni) = @Mes AND Modelo.id = @idModelo and nota >= @NotaDefinitiva
		
		--select @Factor1 as Factor1, @Nota1 as Nota1		select @Factor2 as Factor2, @Nota2 as Nota2
		IF (@NotaDefinitiva > @Nota1 and @NotaDefinitiva < @Nota2)
			DECLARE @NotaFinal float = ((@NotaDefinitiva-@Nota1)/(@Nota2-@Nota1))*(@Factor2-@Factor1)+@Factor1
			DECLARE @NotaMedia float = ((@Nota2-@Nota1)/2)+@Nota1
			
			IF (@Nota1 <= @NotaFinal and @NotaFinal <= @NotaMedia) SET @FactorFinal = @Factor1
			ELSE IF (@NotaMedia <= @NotaFinal and @NotaFinal <= @Nota2) SET @FactorFinal = @Factor2
			
		ELSE IF @NotaDefinitiva = @Nota1
			SET @FactorFinal = @Factor1
		ELSE
			SET @FactorFinal = @Factor2
	END
	RETURN CASE WHEN @FactorFinal IS NOT NULL THEN @FactorFinal ELSE 0 END
END
