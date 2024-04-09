CREATE TABLE [dbo].[Multijerarquia] (
    [id]                    INT           IDENTITY (0, 1) NOT NULL,
    [clave]                 NVARCHAR (50) NULL,
    [companiaClave]         NVARCHAR (50) NULL,
    [segmentoClave]         NVARCHAR (50) NULL,
    [companiaDirector]      NVARCHAR (50) NULL,
    [codigoDirector]        NVARCHAR (50) NULL,
    [claseIntermediario]    NVARCHAR (50) NULL,
    [jerarquiaPago]         NVARCHAR (50) NULL,
    [provisional]           NVARCHAR (50) NULL,
    [tipoDocumentoDirector] NVARCHAR (50) NULL,
    [documentoDirector]     NVARCHAR (50) NULL
);



