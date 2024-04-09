CREATE TABLE [dbo].[Participaciones] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [fechaIni]        DATETIME NULL,
    [fechaFin]        DATETIME NULL,
    [compania_id]     INT      NULL,
    [lineaNegocio_id] INT      NULL,
    [ramo_id]         INT      NULL,
    [mesesAntiguedad] INT      NULL,
    [porcentaje]      FLOAT    NULL
);



