CREATE TABLE [dbo].[LiquidacionRegla] (
    [id]                INT      IDENTITY (0, 1) NOT NULL,
    [regla_id]          INT      NULL,
    [fecha_liquidacion] DATETIME NULL,
    [fecha_inicial]     DATETIME NULL,
    [fecha_final]       DATETIME NULL,
    [estado]            INT      NULL
);



