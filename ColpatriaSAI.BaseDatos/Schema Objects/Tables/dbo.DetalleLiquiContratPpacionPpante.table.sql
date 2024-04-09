CREATE TABLE [dbo].[DetalleLiquiContratPpacionPpante] (
    [id]                      INT            IDENTITY (1, 1) NOT NULL,
    [liqui_contrat_id]        INT            NULL,
    [jerarquiaDetalle_id]     INT            NULL,
    [clave]                   NCHAR (10)     NULL,
    [canal_id]                INT            NULL,
    [compania_id]             INT            NULL,
    [ramo_id]                 INT            NULL,
    [producto_id]             INT            NULL,
    [lineaNegocio_id]         INT            NULL,
    [fecha]                   DATETIME       NULL,
    [numNegocio]              NVARCHAR (250) NULL,
    [valorComision]           FLOAT          NULL,
    [segmento_id]             INT            NULL,
    [porcentajeParticipacion] FLOAT          NULL,
    [valorParticipacion]      FLOAT          NULL
);



