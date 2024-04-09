CREATE TABLE [dbo].[LogIntegracion] (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [fechaInicio]    DATETIME       NULL,
    [fechaFin]       DATETIME       NULL,
    [proceso]        NVARCHAR (150) NULL,
    [estado]         INT            NULL,
    [cantidad]       INT            NULL,
    [sistemaOrigen]  NVARCHAR (100) NULL,
    [sistemaDestino] NVARCHAR (100) NULL,
    [tablaDestino]   NVARCHAR (50)  NULL
);



