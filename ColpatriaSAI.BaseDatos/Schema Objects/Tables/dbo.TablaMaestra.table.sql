CREATE TABLE [dbo].[TablaMaestra] (
    [id]                                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [fechaExpedicionNegocio]              DATETIME       NULL,
    [fechaCancelacionNegocio]             DATETIME       NULL,
    [numeroNegocio]                       NVARCHAR (250) NULL,
    [valorAsegurado]                      FLOAT          NULL,
    [compania_id]                         INT            NULL,
    [ramo_id]                             INT            NULL,
    [lineaNegocio_id]                     INT            NULL,
    [producto_id]                         INT            NULL,
    [participante_id]                     INT            NULL,
    [clave]                               NVARCHAR (250) NULL,
    [fechaIngresoAsesor]                  DATETIME       NULL,
    [primaAhorro]                         FLOAT          NULL,
    [primaProteccion]                     FLOAT          NULL,
    [primaPensiones]                      FLOAT          NULL,
    [primaTotal]                          FLOAT          NULL,
    [identificacionSuscriptor]            NVARCHAR (250) NULL,
    [generoSuscriptor]                    NVARCHAR (50)  NULL,
    [edadSuscriptor]                      FLOAT          NULL,
    [tipoVehiculo_id]                     INT            NULL,
    [porcentajeParticipacion]             FLOAT          NULL,
    [actividadEconomica_id]               INT            NULL,
    [formaPago_id]                        INT            NULL,
    [fechaRecaudo]                        DATETIME       NULL,
    [fechaGrabacion]                      DATETIME       NULL,
    [fechaCobranza]                       DATETIME       NULL,
    [valorRecaudo]                        FLOAT          NULL,
    [numeroReciboRecaudo]                 NVARCHAR (250) NULL,
    [alturaRecaudo]                       INT            NULL,
    [red_id]                              INT            NULL,
    [cuotasPagadas]                       INT            NULL,
    [cuotasVencidas]                      INT            NULL,
    [cantidadColquines]                   FLOAT          NULL,
    [segmento_id]                         INT            NULL,
    [zona_id]                             INT            NULL,
    [localidad_id]                        INT            NULL,
    [categoria_id]                        INT            NULL,
    [persistenciaCapi]                    FLOAT          NULL,
    [persistenciaVida]                    FLOAT          NULL,
    [siniestralidadAutos]                 FLOAT          NULL,
    [porcentajeCrecimientoColquinesTotal] FLOAT          NULL,
    [porcentajeCrecimientoColquinesMes]   FLOAT          NULL,
    [estadoNegocio]                       NVARCHAR (50)  NULL,
    [modalidadPago_id]                    INT            NULL,
    [codigoAgrupador]                     INT            NULL,
    [porcentajeCumplimientoPresupuesto]   FLOAT          NULL,
    [amparo_id]                           INT            NULL,
    [cobertura_id]                        INT            NULL,
    [cantidadColquinesAnoAnterior]        FLOAT          NULL,
    [idoneidadAsesor]                     INT            NULL,
    [cantidadSuscriptores]                INT            NULL,
    [nivel_id]                            INT            NULL,
    [añoActual]                           INT            NULL,
    [añoAnterior]                         INT            NULL,
    [ramoDetalle_id]                      INT            NULL,
    [productoDetalle_id]                  INT            NULL,
    [planDetalle_id]                      INT            NULL,
    [plan_id]                             INT            NULL,
    [primasxmillon]                       FLOAT          NULL,
    [estadoCierre]                        INT            NULL,
    [mesCierre]                           INT            NULL,
    [anioCierre]                          INT            NULL,
    [grupoEndoso_id]                      INT            NULL,
    [conceptoDescuento_id]                INT            NULL,
    [plazo_id]                            INT            NULL
);



















