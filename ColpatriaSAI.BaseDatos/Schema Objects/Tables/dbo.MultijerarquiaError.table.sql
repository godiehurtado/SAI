CREATE TABLE [dbo].[MultijerarquiaError] (
	[id] [int] IDENTITY(1, 1) NOT NULL
	,[clave] [nvarchar](50) NULL
	,[companiaClave] [nvarchar](50) NULL
	,[segmentoClave] [nvarchar](50) NULL
	,[companiaDirector] [nvarchar](50) NULL
	,[codigoDirector] [nvarchar](50) NULL
	,[claseIntermediario] [nvarchar](50) NULL
	,[jerarquiaPago] [nvarchar](50) NULL
	,[provisional] [nvarchar](50) NULL
	,[tipoDocumentoDirector] [nvarchar](50) NULL
	,[documentoDirector] [nvarchar](50) NULL
	,[ErrorColumnName] [nvarchar](50) NULL
	,[ErrorColumnCode] [nvarchar](max) NULL
);
