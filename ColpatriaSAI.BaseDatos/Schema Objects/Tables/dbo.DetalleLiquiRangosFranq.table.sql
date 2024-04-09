CREATE TABLE [dbo].[DetalleLiquiRangosFranq] (
    [id]                INT            IDENTITY (1, 1) NOT NULL,
    [compania_id]       INT            NULL,
    [ramo_id]           INT            NULL,
    [producto_id]       INT            NULL,
    [numeroNegocio]     NVARCHAR (100) NULL,
    [acumuladoTotal]    FLOAT          NULL,
    [RangoActual]       FLOAT          NULL,
    [PorcentajeActual]  FLOAT          NULL,
    [acumuladoAnterior] FLOAT          NULL,
	[enero]				FLOAT          NULL,
	[febrero]			FLOAT          NULL,
	[marzo]				FLOAT          NULL,
	[abril]				FLOAT          NULL,
	[mayo]				FLOAT          NULL,
	[junio]				FLOAT          NULL,
	[julio]				FLOAT          NULL,
	[agosto]			FLOAT          NULL,
	[septiembre]		FLOAT          NULL,
	[octubre]			FLOAT          NULL,
	[noviembre]			FLOAT          NULL,
	[diciembre]			FLOAT          NULL,
	[anio]				INT			   NULL
);



