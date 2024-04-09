CREATE TABLE [dbo].[LiquiContratFactorParticipante] (
    [id]                  INT   IDENTITY (1, 1) NOT NULL,
    [liqui_contrat_id]    INT   NULL,
    [modelo_id]           INT   NULL,
    [jerarquiaDetalle_id] INT   NULL,
    [notaDefinitiva]      FLOAT NULL,
    [factor]              FLOAT NULL,
    [salarioBase]         FLOAT NULL,
    [valorIncremento]     FLOAT NULL,
    [salarioTotal]        FLOAT NULL,
    [valorFVD]            FLOAT NULL,
    [valorFVC]            FLOAT NULL,
    [totalPago]           FLOAT NULL,
    [valorAjuste]         FLOAT NULL,
    [totalAjuste]         FLOAT NULL
);





