CREATE TABLE [dbo].[LiquidacionContratacion] (
    [id]               INT          IDENTITY (0, 1) NOT NULL,
    [fechaIni]         DATETIME     NULL,
    [fechaFin]         DATETIME     NULL,
    [usuario]          VARCHAR (50) NULL,
    [fechaLiquidacion] DATETIME     NULL,
    [estado]           INT          NULL
);



