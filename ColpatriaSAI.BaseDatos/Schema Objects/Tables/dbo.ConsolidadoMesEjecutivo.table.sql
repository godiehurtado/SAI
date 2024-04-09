CREATE TABLE [dbo].[ConsolidadoMesEjecutivo] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [jerarquiaDetalle_id]  INT           NOT NULL,
    [compania_id]          INT           NULL,
    [ramo_id]              INT           NULL,
    [producto_id]          INT           NULL,
    [mes]                  INT           NULL,
    [anio]                 INT           NULL,
    [nivel_id]             INT           NULL,
    [personasACargo]       INT           NULL,
    [personasACargoVenden] INT           NULL,
    [numeroNegocios]       INT           NULL,
    [totalPrimas]          FLOAT         NULL,
    [promedioPrimas]       FLOAT         NULL,
    [totalColquines]       FLOAT         NULL,
    [totalRecaudos]        FLOAT         NULL,
    [codigoNivel]          NVARCHAR (80) NULL,
    [categoria_id]         INT           NULL,
    [canal_id]             INT           NULL,
    [promedioNegocios]     FLOAT         NULL,
	[colquinesDescontarPV]     FLOAT         NULL,
	[RecaudosDescontarPV]      FLOAT         NULL,
	[ColquinesDescontarS]      FLOAT         NULL,
	[RecaudosDescontarS]       FLOAT         NULL,
	[ColquinesDescontarPC]     FLOAT         NULL,
	[RecaudosDescontarPC]      FLOAT         NULL,
	[plazo_id]				   FLOAT         NULL
);





