CREATE TABLE [dbo].[DetallePartFranquicia] (
    [id]                 INT   IDENTITY (1, 1) NOT NULL,
    [part_franquicia_id] INT   NULL,
    [compania_id]        INT   NULL,
    [ramo_id]            INT   NULL,
    [producto_id]        INT   NULL,
    [porcentaje]         FLOAT NULL,
    [rangoinferior]      FLOAT NULL,
    [rangosuperior]      FLOAT NULL,
    [plan_id]            INT   NULL,
    [lineaNegocio_id]    INT   NULL,
    [tipoVehiculo_id]    INT   NOT NULL,
    [amparo_id]          INT   NULL
);



