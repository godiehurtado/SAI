CREATE TYPE [dbo].[PresupuestoDetalle] AS  TABLE (
    [id]          INT           NULL,
    [codigoNivel] VARCHAR (50)  NULL,
    [codigoMeta]  VARCHAR (100) NULL,
    [Anio]        VARCHAR (4)   NULL,
    [Enero]       FLOAT         NULL,
    [Febrero]     FLOAT         NULL,
    [Marzo]       FLOAT         NULL,
    [Abril]       FLOAT         NULL,
    [Mayo]        FLOAT         NULL,
    [Junio]       FLOAT         NULL,
    [Julio]       FLOAT         NULL,
    [Agosto]      FLOAT         NULL,
    [Septiembre]  FLOAT         NULL,
    [Octubre]     FLOAT         NULL,
    [Noviembre]   FLOAT         NULL,
    [Diciembre]   FLOAT         NULL);



