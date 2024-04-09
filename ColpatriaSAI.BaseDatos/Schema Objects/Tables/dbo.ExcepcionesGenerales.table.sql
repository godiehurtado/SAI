CREATE TABLE [dbo].[ExcepcionesGenerales] (
    [id]            INT           IDENTITY (0, 1) NOT NULL,
    [ramo_id]       INT           NULL,
    [clave]         NVARCHAR (50) NULL,
    [numeroNegocio] BIGINT        NULL,
    [fechaInicio]   DATE          NULL,
    [fechaFin]      DATE          NULL,
    [factor]        FLOAT         NULL,
    [moneda_id]     INT           NULL
);

