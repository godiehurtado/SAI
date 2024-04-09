CREATE TABLE [dbo].[Concurso] (
    [id]              INT            IDENTITY (0, 1) NOT NULL,
    [fecha_inicio]    DATETIME       NULL,
    [fecha_fin]       DATETIME       NULL,
    [tipoConcurso_id] INT            NULL,
    [nombre]          VARCHAR (100)  NULL,
    [descripcion]     VARCHAR (8000) NULL,
    [segmento_id]     INT            NULL,
    [principal]       BIT            NULL
);



