CREATE TABLE [sig].[COMJSN] (
    [id]                 INT            IDENTITY (1, 1) NOT NULL,
    [codCompania]        NVARCHAR (10)  NULL,
    [codSucursal]        INT            NULL,
    [codRamo]            NVARCHAR (10)  NULL,
    [numeroNegocio]      NVARCHAR (50)  NULL,
    [segmentoNegocio]    INT            NULL,
    [claveAsesor]        NVARCHAR (50)  NULL,
    [nombreDirector]     NVARCHAR (250) NULL,
    [nombreGerente]      NVARCHAR (250) NULL,
    [segmentoNatural]    INT            NULL,
    [sectorEyE]          INT            NULL,
    [sectorPyP]          INT            NULL,
    [sectorCH]           INT            NULL,
    [microsegmentacion]  NVARCHAR (10)  NULL,
    [codigoCIUUSegmento] NVARCHAR (10)  NULL
);



