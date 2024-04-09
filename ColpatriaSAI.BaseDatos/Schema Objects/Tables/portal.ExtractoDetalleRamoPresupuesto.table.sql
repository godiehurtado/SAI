CREATE TABLE [portal].[ExtractoDetalleRamoPresupuesto] (
    [id]              INT           IDENTITY (1, 1) NOT NULL,
    [Clave]           NVARCHAR (50) NULL,
    [Ramo_id]         INT           NULL,
    [UnidadMedida_id] INT           NULL,
    [Enero]           FLOAT         NULL,
    [Febrero]         FLOAT         NULL,
    [Marzo]           FLOAT         NULL,
    [Abril]           FLOAT         NULL,
    [Mayo]            FLOAT         NULL,
    [Junio]           FLOAT         NULL,
    [Julio]           FLOAT         NULL,
    [Agosto]          FLOAT         NULL,
    [Septiembre]      FLOAT         NULL,
    [Octubre]         FLOAT         NULL,
    [Noviembre]       FLOAT         NULL,
    [Diciembre]       FLOAT         NULL
);



