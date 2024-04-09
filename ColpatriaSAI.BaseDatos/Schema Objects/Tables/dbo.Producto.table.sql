CREATE TABLE [dbo].[Producto] (
    [id]       INT            IDENTITY (0, 1) NOT NULL,
    [nombre]   NVARCHAR (150) NOT NULL,
    [ramo_id]  INT            NULL,
    [plazo_id] INT            NULL
);



