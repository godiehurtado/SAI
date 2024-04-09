CREATE TABLE [dbo].[ParametrosApp] (
    [id]            INT            IDENTITY (1, 1) NOT NULL,
    [parametro]     NVARCHAR (100) NULL,
    [valor]         NVARCHAR (500) NULL,
    [descripcion]   NVARCHAR (200) NULL,
    [tipoParametro] INT            NULL
);



