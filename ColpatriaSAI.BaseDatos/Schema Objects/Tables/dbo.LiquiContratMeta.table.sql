CREATE TABLE [dbo].[LiquiContratMeta] (
    [id]                  INT   IDENTITY (1, 1) NOT NULL,
    [liqui_contrat_id]    INT   NULL,
    [jerarquiaDetalle_id] INT   NULL,
    [modelo_id]           INT   NULL,
    [meta_id]             INT   NULL,
    [presupuesto]         FLOAT NULL,
    [ejecutado]           FLOAT NULL,
    [cumplimiento]        FLOAT NULL,
    [nota]                FLOAT NULL,
    [pesoNota]            FLOAT NULL,
    [notaPonderada]       FLOAT NULL,
    [salario]             FLOAT NULL
);



