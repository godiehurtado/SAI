CREATE TABLE [dbo].[ModeloxNodo] (
    [id]                  INT      IDENTITY (0, 1) NOT NULL,
    [modelo_id]           INT      NULL,
    [nivel_id]            INT      NULL,
    [zona_id]             INT      NULL,
    [localidad_id]        INT      NULL,
    [jerarquiaDetalle_id] INT      NULL,
    [fechaIni]            DATETIME NULL,
    [fechaFin]            DATETIME NULL
);



