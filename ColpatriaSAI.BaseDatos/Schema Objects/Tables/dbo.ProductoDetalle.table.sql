CREATE TABLE [dbo].[ProductoDetalle] (
    [id]             INT            IDENTITY (1, 1) NOT NULL,
    [nombre]         NVARCHAR (150) NULL,
    [ramoDetalle_id] INT            NULL,
    [producto_id]    INT            NULL,
    [codigoCore]     NVARCHAR (20)  NULL
);



