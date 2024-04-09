CREATE TABLE [dbo].[LiquiContratPpacionPpante] (
    [id]                  INT   IDENTITY (1, 1) NOT NULL,
    [liqui_contrat_id]    INT   NULL,
    [jerarquiaDetalle_id] INT   NULL,
    [canal_id]            INT   NULL,
    [compania_id]         INT   NULL,
    [basePpanteOriginal]  FLOAT NULL,
    [peso]                FLOAT NULL,
    [basePpantePonderada] FLOAT NULL
);



