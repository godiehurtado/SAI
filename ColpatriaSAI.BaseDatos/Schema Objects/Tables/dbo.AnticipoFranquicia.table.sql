CREATE TABLE [dbo].[AnticipoFranquicia] (
    [Id]                 INT           IDENTITY (1, 1) NOT NULL,
    [localidad_id]       INT           NULL,
    [fecha_anticipo]     DATETIME      NULL,
    [descripcion]        TEXT          NULL,
    [usuarioEjecutoAnti] NVARCHAR (50) NULL,
    [valorAnti]          FLOAT         NULL,
    [estado]             VARCHAR (50)  NULL,
    [compania_id]        INT           NULL,
    [saldo]              FLOAT         NULL
);



