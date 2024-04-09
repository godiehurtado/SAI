CREATE TABLE [dbo].[LiquidacionFranquicia] (
    [id]                    INT      IDENTITY (1, 1) NOT NULL,
    [fechaLiquidacion]      DATETIME NULL,
    [periodoLiquidacionIni] DATETIME NULL,
    [periodoLiquidacionFin] DATETIME NULL,
    [estado]                INT      NULL,
	[permite_reliquidar]    INT      NULL,
	[id_liquidacion_reliquidada]	INT      NULL
);



