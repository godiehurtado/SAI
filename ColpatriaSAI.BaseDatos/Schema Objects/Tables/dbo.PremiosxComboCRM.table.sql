CREATE TABLE [dbo].[PremiosxComboCRM] (
    [id]              INT    IDENTITY (1, 1) NOT NULL,
    [participante_id] INT    NULL,
    [tipoPremio_id]   INT    NULL,
    [producto_id]     INT    NULL,
    [localidad_id]    INT    NULL,
    [ramo_id]         INT    NULL,
    [compania_id]     INT    NULL,
    [numeroNegocio]   BIGINT NULL,
    [cantidad]        FLOAT  NULL,
    [año]             INT    NULL,
    [fechaProceso]    DATE   NULL
);

