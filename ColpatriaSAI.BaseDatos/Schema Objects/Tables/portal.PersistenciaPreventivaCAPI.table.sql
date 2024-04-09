CREATE TABLE [portal].[PersistenciaPreventivaCAPI] (
    [zona]                     NVARCHAR (100) NULL,
    [localidad]                NVARCHAR (100) NULL,
    [clave]                    NVARCHAR (100) NULL,
    [nombreAsesor]             NVARCHAR (100) NULL,
    [periodo]                  INT            NULL,
    [plazo]                    NVARCHAR (50)  NULL,
    [numeroNegocio]            NVARCHAR (100) NULL,
    [año]                      INT            NULL,
    [fechaExpedicion]          DATETIME       NULL,
    [fechaRecaudoInicial]      DATETIME       NULL,
    [valorCuota]               FLOAT          NULL,
    [cuotasPagadas]            INT            NULL,
    [cuotasVencidas]           INT            NULL,
    [identificacionSuscriptor] NVARCHAR (50)  NULL,
    [nombreSuscriptor]         NVARCHAR (200) NULL,
    [localidadSuscriptor]      NVARCHAR (100) NULL
);





