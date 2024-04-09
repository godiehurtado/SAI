CREATE TABLE [integracion].[Log] (
    [id]                          INT            IDENTITY (1, 1) NOT NULL,
    [proceso]                     NVARCHAR (100) NULL,
    [sistema]                     NVARCHAR (100) NULL,
    [estado]                      INT            NULL,
    [fechaInicio]                 DATETIME       NULL,
    [fechaFin]                    DATETIME       NULL,
    [cantidadRegistrosOriginales] INT            NULL,
    [cantidadRegistrosProcesados] INT            NULL
);



