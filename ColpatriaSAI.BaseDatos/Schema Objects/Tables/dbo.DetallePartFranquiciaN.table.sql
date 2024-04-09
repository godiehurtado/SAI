CREATE TABLE [dbo].[DetallePartFranquiciaN] (
    [id]                 INT        IDENTITY (1, 1) NOT NULL,
    [part_franquicia_id] INT        NULL,
    [compania_id]        INT        NULL,
    [ramo_id]            INT        NULL,
    [producto_id]        INT        NULL,
    [porcentaje]         NCHAR (10) NULL,
    [rangoinferior]      FLOAT      NULL,
    [rangosuperior]      FLOAT      NULL,
    [plan_id]            INT        NULL,
    [lineaNegocio_id]    INT        NULL,
    [tipoVehiculo_id]    INT        NOT NULL,
    [amparo_id]          INT        NULL
);

