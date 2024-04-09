CREATE TABLE [dbo].[TipoPanel] (
    [id]                INT            IDENTITY (1, 1) NOT NULL,
    [nombre]            NVARCHAR (50)  NOT NULL,
    [descripcion]       NVARCHAR (250) NULL,
    [nombreDescripcion] NVARCHAR (50)  NULL,
    [nombreValor1]      NVARCHAR (50)  NULL,
    [nombreValor2]      NVARCHAR (50)  NULL,
    [nombreValor3]      NVARCHAR (50)  NULL,
    [visible]           BIT            NOT NULL
);

