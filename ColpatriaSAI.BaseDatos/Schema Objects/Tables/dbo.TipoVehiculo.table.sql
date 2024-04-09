CREATE TABLE [dbo].[TipoVehiculo] (
    [id]         INT            IDENTITY (0, 1) NOT NULL,
    [Nombre]     NVARCHAR (150) NOT NULL,
    [codigoCore] NVARCHAR (50)  NULL,
    [ramo_id]    INT            NULL
);



