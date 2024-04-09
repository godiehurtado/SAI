CREATE TABLE [dbo].[PersistenciadeCAPIDetalle] (
    [id]                       INT            IDENTITY (1, 1) NOT NULL,
    [mesCierre]                INT            NULL,
    [clave]                    NVARCHAR (50)  NULL,
    [participante_id]          INT            NULL,
    [numeroNegocio]            NVARCHAR (50)  NULL,
    [plazo_id]                 INT            NULL,
    [valorPrimaTotal]          FLOAT          NULL,
    [cuotasPagadas]            INT            NULL,
    [cuotasVencidas]           INT            NULL,
    [fechaCierre]              DATETIME       NULL,
    [fechaUltimoRecaudo]       DATETIME       NULL,
    [anioCierreNegocio]        INT            NULL,
    [cumple]                   BIT            NULL,
    [comentarios]              NVARCHAR (MAX) NULL,
    [nombreSuscriptor]         NVARCHAR (100) NULL,
    [planDetalle_id]           INT            NULL,
    [zona_id]                  INT            NULL,
    [localidad_id]             INT            NULL,
    [ramo_id]                  INT            NULL,
    [identificacionSuscriptor] NVARCHAR (50)  NULL
);





