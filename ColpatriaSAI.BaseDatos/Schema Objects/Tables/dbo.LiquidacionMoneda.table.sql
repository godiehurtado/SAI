CREATE TABLE [dbo].[LiquidacionMoneda] (
    [id]                  BIGINT         IDENTITY (1, 1) NOT NULL,
    [moneda_id]           INT            NULL,
    [compania_id]         INT            NULL,
    [cantidad]            FLOAT          NULL,
    [participante_id]     INT            NULL,
    [factor]              FLOAT          NULL,
    [base]                FLOAT          NULL,
    [tipo]                INT            NULL,
    [recaudo_id]          INT            NULL,
    [concepto]            NVARCHAR (500) NULL,
    [fechaLiquidacion]    DATETIME       NULL,
    [fechaCargue]         DATETIME       NULL,
    [jerarquiaDetalle_id] INT            NULL,
    [anioCierreRecaudo]   INT            NULL
);







