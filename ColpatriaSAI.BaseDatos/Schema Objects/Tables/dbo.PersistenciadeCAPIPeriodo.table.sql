CREATE TABLE [dbo].[PersistenciadeCAPIPeriodo] (
    [id]                  INT           IDENTITY (1, 1) NOT NULL,
    [clave]               NVARCHAR (50) NULL,
    [participante_id]     INT           NULL,
    [periodo]             INT           NULL,
    [plazo_id]            INT           NULL,
    [sumaTotal]           FLOAT         NULL,
    [sumaCumple]          FLOAT         NULL,
    [persistenciaPeriodo] FLOAT         NULL,
    [anioCierreNegocio]   INT           NULL,
    [fechaCalculo]        DATETIME      NULL,
    [ramo_id]             INT           NULL,
    [jerarquiaDetalle_id] INT           NULL
);





