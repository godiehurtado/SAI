CREATE TABLE [dbo].[Jerarquia] (
    [id]               INT            IDENTITY (1, 1) NOT NULL,
    [nombre]           NVARCHAR (100) NOT NULL,
    [tipoJerarquia_id] INT            NOT NULL,
    [segmento_id]      INT            NOT NULL,
    [ano]              INT            NOT NULL
);



