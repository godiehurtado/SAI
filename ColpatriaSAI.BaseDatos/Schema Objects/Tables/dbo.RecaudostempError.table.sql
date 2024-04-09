CREATE TABLE [dbo].[RecaudostempError] (
    [id]                        INT            IDENTITY (1, 1) NOT NULL,
    [compania_id]               NVARCHAR (50)  NULL,
    [lineaNegocio_id]           NVARCHAR (50)  NULL,
    [ramo_id]                   NVARCHAR (50)  NULL,
    [amparo_id]                 NVARCHAR (50)  NULL,
    [cobertura_id]              NVARCHAR (50)  NULL,
    [modalidadPago_id]          NVARCHAR (50)  NULL,
    [producto_id]               NVARCHAR (50)  NULL,
    [plan_id]                   NVARCHAR (50)  NULL,
    [numeroNegocio]             NVARCHAR (50)  NULL,
    [fechaRecaudo]              NVARCHAR (50)  NULL,
    [fechaGrabacion]            NVARCHAR (50)  NULL,
    [fechaCobranza]             NVARCHAR (50)  NULL,
    [valorRecaudo]              NVARCHAR (50)  NULL,
    [numeroRecibo]              NVARCHAR (50)  NULL,
    [tipoRecaudo]               NVARCHAR (50)  NULL,
    [formaPago_id]              NVARCHAR (50)  NULL,
    [altura]                    NVARCHAR (50)  NULL,
    [zona_id]                   NVARCHAR (50)  NULL,
    [localidad_id]              NVARCHAR (50)  NULL,
    [clave]                     NVARCHAR (50)  NULL,
    [porcentajeParticipacion]   NVARCHAR (50)  NULL,
    [concepto]                  NVARCHAR (50)  NULL,
    [porcentajeAhorroInversion] NVARCHAR (50)  NULL,
    [codigoOcupacion]           NVARCHAR (50)  NULL,
    [sistema]                   NVARCHAR (50)  NULL,
    [red_id]                    NVARCHAR (50)  NULL,
    [codigoBanco]               NVARCHAR (50)  NULL,
    [ErrorCode]                 NVARCHAR (50)  NULL,
    [ErrorColumnName]           NVARCHAR (250) NULL,
    [ErrorColumnCode]           NVARCHAR (250) NULL,
    [periodoFacturado]          NVARCHAR (250) NULL,
    [estadoCierre]              INT            NULL,
    [mesCierre]                 INT            NULL,
    [anioCierre]                INT            NULL
);





