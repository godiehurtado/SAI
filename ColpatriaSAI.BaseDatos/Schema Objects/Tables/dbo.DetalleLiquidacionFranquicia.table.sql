CREATE TABLE [dbo].[DetalleLiquidacionFranquicia] (
    [id]                       BIGINT        IDENTITY (1, 1) NOT NULL,
    [porcentajeParticipacion]  FLOAT         NULL,
    [totalParticipacion]       FLOAT         NULL,
    [liquidacionFranquicia_id] INT           NULL,
    [localidad_id]             INT           NULL,
    [compania_id]              INT           NULL,
    [ramo_id]                  INT           NULL,
    [producto_id]              INT           NULL,
    [valorRecaudo]             FLOAT         NULL,
    [numeroNegocio]            NVARCHAR (50) NULL,
    [nivelDirector]            NVARCHAR (50) NULL,
    [claveParticipante]        NVARCHAR (50) NULL,
    [modalidadPagoId]          INT           NOT NULL,
    [numeroRecibo]             NVARCHAR (50) NULL,
    [fechaRecaudo]             DATETIME      NOT NULL,
    [fechaContabl]             DATETIME      NULL,
    [amparo_Id]                INT           NULL,
    [colquines]                FLOAT         NULL,
    [lineaNegocio_id]          INT           NULL,
    [zona_id]                  INT           NULL,
    [codigo_agrupador]         NVARCHAR (50) NULL,
    [tipoVehiculo]             VARCHAR (100) NULL,
    [liquidadoPor]             INT           NULL,
    [ramo_id_agrupado]         INT           NULL,
    [producto_id_agrupado]     INT           NULL,
	[concepto]				   VARCHAR (250) NULL,
	[altura]				   INT           NULL,
	[segmento_id]			   INT           NULL
);



