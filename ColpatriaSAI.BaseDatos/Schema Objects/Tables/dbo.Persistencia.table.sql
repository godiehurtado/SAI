CREATE TABLE [dbo].[Persistencia] (
    [id]              INT      IDENTITY (1, 1) NOT NULL,
    [compania_id]     INT      NULL,
    [producto_id]     INT      NULL,
    [participante_id] INT      NULL,
    [valor]           FLOAT    NULL,
    [fecha]           DATETIME NULL
);



