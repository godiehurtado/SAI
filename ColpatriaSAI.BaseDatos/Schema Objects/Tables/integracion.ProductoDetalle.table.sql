CREATE TABLE [integracion].[ProductoDetalle](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](50) NULL,
	[ramoDetalle_id] [int] NULL,
	[producto_id] [int] NULL,
	[codigoCore] [nvarchar](20) NULL
);