CREATE TABLE [dbo].[ProductoConcurso] (
    [id]              INT      IDENTITY (0, 1) NOT NULL,
    [fecha_inicio]    DATETIME NULL,
    [fecha_fin]       DATETIME NULL,
    [producto_id]     INT      NULL,
    [concurso_id]     INT      NULL,
    [lineaNegocio_id] INT      NULL,
    [compania_id]     INT      NULL,
    [ramo_id]         INT      NULL
);



