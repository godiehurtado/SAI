CREATE TABLE [dbo].[Condicion] (
    [id]             INT            IDENTITY (0, 1) NOT NULL,
    [variable_id]    INT            NULL,
    [operador_id]    INT            NULL,
    [valor]          VARCHAR (100)  NULL,
    [tabla_id]       INT            NULL,
    [subregla_id]    INT            NULL,
    [seleccion]      VARCHAR (100)  NULL,
    [textoSeleccion] VARCHAR (100)  NULL,
    [fecha]          DATETIME       NULL,
    [descripcion]    NVARCHAR (100) NULL
);



