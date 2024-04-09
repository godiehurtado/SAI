CREATE TABLE [dbo].[Excepcion] (
    [id]              INT            IDENTITY (1, 1) NOT NULL,
    [Localidad_id]    INT            NOT NULL,
	[localidad_de_id] INT		     NULL,
    [compania_id]     INT            NULL,
    [lineaNegocio_id] INT            NULL,
    [ramo_id]         INT            NULL,
    [producto_id]     INT            NULL,
    [participante_id] INT            NULL,
    [clave]           NVARCHAR (50)  NULL,
    [negocio_id]      NVARCHAR (100) NULL,
    [poliza]          NVARCHAR (50)  NULL,
    [codigoAgrupador] NVARCHAR (50)  NULL,
    [fecha_ini]       DATETIME       NULL,
    [fecha_fin]       DATETIME       NULL,
    [Tipo]            INT            NULL,
    [Estado]          BIT            NOT NULL,
    [Porcentaje]      FLOAT          NULL,
    [zona_id]         INT            NULL,
	[tipoVehiculo_id] INT            NULL,
	[excepcion_recaudo] BIT            NULL
);



