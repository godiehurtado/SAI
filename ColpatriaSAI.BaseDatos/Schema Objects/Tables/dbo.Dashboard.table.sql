CREATE TABLE [dbo].[Dashboard] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [descripcion]  TEXT          NULL,
    [valor1]       VARCHAR (200) NULL,
    [valor2]       VARCHAR (200) NULL,
    [valor3]       VARCHAR (200) NULL,
    [tipoPanel_id] INT           NOT NULL
);





