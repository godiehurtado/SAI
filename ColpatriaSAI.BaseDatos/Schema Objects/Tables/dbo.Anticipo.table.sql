CREATE TABLE [dbo].[Anticipo] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [fecha]           DATETIME NULL,
    [participante_id] INT      NULL,
    [valor]           FLOAT    NULL,
    [estado]          INT      NULL
);



