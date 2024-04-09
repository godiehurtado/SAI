CREATE TABLE [dbo].[Variable] (
    [id]                     INT            IDENTITY (0, 1) NOT NULL,
    [nombre]                 NVARCHAR (100) NULL,
    [descripcion]            TEXT           NULL,
    [tipoVariable_id]        INT            NULL,
    [tabla_id]               INT            NULL,
    [agregacion]             BIT            NULL,
    [columnaTablaMaestra]    VARCHAR (100)  NULL,
    [tipoDato]               VARCHAR (100)  NULL,
    [operacionAgregacion_id] INT            NULL,
    [esFiltro]               BIT            NULL,
    [tipoMedida_id]          INT            NULL,
    [tipoTabla]              INT            NULL,
    [tipoConcurso]           INT            NULL
);



