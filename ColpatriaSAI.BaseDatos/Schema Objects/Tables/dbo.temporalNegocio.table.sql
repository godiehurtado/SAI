﻿CREATE TABLE [dbo].[temporalNegocio] (
    [id]                       BIGINT         IDENTITY (0, 1) NOT NULL,
    [compania_id]              INT            NULL,
    [lineaNegocio_id]          INT            NULL,
    [ramoDetalle_id]           INT            NULL,
    [productoDetalle_id]       INT            NULL,
    [planDetalle_id]           INT            NULL,
    [amparo_id]                INT            NULL,
    [cobertura_id]             INT            NULL,
    [modalidadPago_id]         INT            NULL,
    [formaPago_id]             INT            NULL,
    [numeroNegocio]            NVARCHAR (250) NULL,
    [numeroSolicitud]          NVARCHAR (250) NULL,
    [codigoAgrupador]          NVARCHAR (100) NULL,
    [fechaExpedicion]          DATETIME       NULL,
    [fechaGrabacion]           DATETIME       NULL,
    [fechaRecaudoInicial]      DATETIME       NULL,
    [fechaEmisionMaximoEndoso] DATETIME       NULL,
    [fechaCancelacion]         DATETIME       NULL,
    [valorAsegurado]           FLOAT          NULL,
    [valorProteccion]          FLOAT          NULL,
    [valorAhorro]              FLOAT          NULL,
    [valorPrimaPensiones]      FLOAT          NULL,
    [valorPrimaTotal]          FLOAT          NULL,
    [estadoNegocio]            NVARCHAR (100) NULL,
    [zona_id]                  INT            NULL,
    [localidad_id]             INT            NULL,
    [clave]                    NVARCHAR (250) NULL,
    [participante_id]          INT            NULL,
    [porcentajeParticipacion]  FLOAT          NULL,
    [segmento_id]              INT            NULL,
    [tipoEndoso_id]            INT            NULL,
    [grupoEndoso_id]           INT            NULL,
    [cuotasPagadas]            FLOAT          NULL,
    [cuotasVencidas]           FLOAT          NULL,
    [cliente_id]               INT            NULL,
    [identificacionSuscriptor] NVARCHAR (250) NULL,
    [nombreSuscriptor]         NVARCHAR (250) NULL,
    [generoSuscriptor]         NVARCHAR (100) NULL,
    [actividadEconomica_id]    INT            NULL,
    [marcaVehiculo_id]         INT            NULL,
    [tipoVehiculo_id]          INT            NULL,
    [modeloVehiculo]           NVARCHAR (100) NULL,
    [sistema]                  NVARCHAR (100) NULL,
    [Usuarios]                 INT            NULL,
    [fechaCarga]               DATETIME       NULL,
    [estadoCierre]             INT            NULL,
    [mesCierre]                INT            NULL,
    [anioCierre]               INT            NULL
);

