CREATE TABLE [dbo].[PresupuestoEjecutadoxMetaTemp] (
    [id]                  INT   IDENTITY (1, 1) NOT NULL,
    [presupuesto_id]      INT   NULL,
    [meta_id]             INT   NULL,
    [jerarquiaDetalle_id] INT   NULL,
    [anio]                INT   NULL,
    [mes]                 INT   NULL,
    [presupuesto]         FLOAT NULL,
    [ejecutado]           FLOAT NULL,
    [porcentaje]          FLOAT NULL,
    [categoria_id]        INT   NULL,
    [canal_id]            INT   NULL
);

