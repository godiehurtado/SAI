CREATE TABLE [dbo].[TopeMoneda] (
    [id]               INT   IDENTITY (0, 1) NOT NULL,
    [concurso_id]      INT   NULL,
    [tope]             FLOAT NULL,
    [compania_id]      INT   NULL,
    [ramo_id]          INT   NULL,
    [producto_id]      INT   NULL,
    [maestromoneda_id] INT   NULL
);



