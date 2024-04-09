CREATE TABLE [integracion].[Recaudo] (
    [id]                         INT            NOT NULL,
    [compania_id]                INT            NULL,
    [lineaNegocio_id]            INT            NULL,
    [ramo_id]                    INT            NULL,
    [producto_id]                INT            NULL,
    [plan_id]                    INT            NULL,
    [ramoDetalle_id]             INT            NULL,
    [productoDetalle_id]         INT            NULL,
    [planDetalle_id]             INT            NULL,
    [amparo_id]                  INT            NULL,
    [modalidadPago_id]           INT            NULL,
    [zona_id]                    INT            NULL,
    [localidad_id]               INT            NULL,
    [participante_id]            INT            NULL,
    [clave]                      NVARCHAR (250) NULL,
    [numeroNegocio]              NVARCHAR (250) NULL,
    [fechaRecaudo]               DATETIME       NULL,
    [fechaGrabacion]             DATETIME       NULL,
    [fechaCobranza]              DATETIME       NULL,
    [valorRecaudo]               FLOAT          NULL,
    [numeroRecibo]               NVARCHAR (250) NULL,
    [periodoFacturado]           INT            NULL,
    [Altura]                     INT            NULL,
    [porcentajeParticipacion]    FLOAT          NULL,
    [Concepto]                   NVARCHAR (250) NULL,
    [porcentajeAhorro_Inversion] FLOAT          NULL,
    [codigoBanco]                INT            NULL,
    [segmento_id]                INT            NULL,
    [numeroDocumentoSuscriptor]  NVARCHAR (250) NULL,
    [tipoDocumentoSuscriptor_id] INT            NULL,
    [Colquines]                  FLOAT          NULL,
    [mesCierre]                  INT            NULL,
    [anioCierre]                 INT            NULL
);







