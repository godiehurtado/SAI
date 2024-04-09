CREATE TABLE [dbo].[PersistenciadeCAPIAcumulada] (
    [id]                    INT           IDENTITY (1, 1) NOT NULL,
    [clave]                 NVARCHAR (50) NULL,
    [participante_id]       INT           NULL,
    [plazo_id]              INT           NULL,
    [meses]                 INT           NULL,
    [persistenciaPeriodo]   FLOAT         NULL,
    [persistenciaAcumulada] FLOAT         NULL,
    [ultimoPeriodo]         INT           NULL,
    [anioCierreNegocio]     INT           NULL,
    [fechaCalculo]          DATETIME      NULL,
    [colquinesDescontar]    FLOAT         NULL,
    [ramo_id]               INT           NULL,
    [jerarquiaDetalle_id]   INT           NULL,
    [recaudosDescontar]     FLOAT         NULL
);





