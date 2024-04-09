CREATE TABLE [dbo].[HistoricoPersistenciaVida] (
    [id]                   INT        IDENTITY (1, 1) NOT NULL,
    [clave]                NCHAR (50) NULL,
    [ramo_id]              INT        NULL,
    [producto_id]          INT        NULL,
    [año]                  INT        NULL,
    [polizasExpedidas]     INT        NULL,
    [polizasVigentes]      INT        NULL,
    [totalPrimasExpedidas] FLOAT      NULL,
    [totalPrimasVigentes]  FLOAT      NULL,
    [porcentajePolizas]    FLOAT      NULL,
    [porcentajePrimas]     FLOAT      NULL,
    [porcentajePeriodo]    FLOAT      NULL
);



