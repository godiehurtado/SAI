CREATE TABLE [dbo].[RamoDetalle] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [nombre]      NVARCHAR (50) NULL,
    [compania_id] INT           NULL,
    [ramo_id]     INT           NULL,
    [codigoCore]  NVARCHAR (20) NULL
);



