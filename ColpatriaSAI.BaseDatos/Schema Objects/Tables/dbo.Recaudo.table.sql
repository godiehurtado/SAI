CREATE TABLE [dbo].[Recaudo] (
    [id]                         BIGINT         IDENTITY (0, 1) NOT NULL,
    [segmento_id]                INT            NULL,
    [compania_id]                INT            NULL,
    [lineaNegocio_id]            INT            NULL,
    [ramoDetalle_id]             INT            NULL,
    [productoDetalle_id]         INT            NULL,
    [planDetalle_id]             INT            NULL,
    [amparo_id]                  INT            NULL,
    [cobertura_id]               INT            NULL,
    [modalidadpago_id]           INT            NULL,
    [localidad_id]               INT            NULL,
    [zona_id]                    INT            NULL,
    [formaPago_id]               INT            NULL,
    [redDetalle_id]              INT            NULL,
    [bancoDetalle_id]            INT            NULL,
    [participante_id]            INT            NULL,
    [clave]                      NVARCHAR (250) NULL,
    [tipoRecaudo_id]             INT            NULL,
    [numeroNegocio]              NVARCHAR (250) NULL,
    [fechaRecaudo]               DATETIME       NULL,
    [fechaGrabacion]             DATETIME       NULL,
    [fechaCobranza]              DATETIME       NULL,
    [valorRecaudo]               FLOAT          NULL,
    [porcentajeParticipacion]    FLOAT          NULL,
    [numeroRecibo]               NVARCHAR (250) NULL,
    [periodoFacturado]           INT            NULL,
    [Altura]                     INT            NULL,
    [Concepto]                   NVARCHAR (250) NULL,
    [porcentajeAhorro_Inversion] FLOAT          NULL,
    [sistema]                    NVARCHAR (250) NULL,
    [codigoOcupacion]            NVARCHAR (250) NULL,
    [Colquines]                  FLOAT          NULL,
    [fechaCarga]                 DATETIME       NULL,
    [estadoCierre]               INT            NULL,
    [mesCierre]                  INT            NULL,
    [anioCierre]                 INT            NULL
);













