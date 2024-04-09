CREATE TABLE [dbo].[DetallePresupuesto] (
    [id]                  INT      IDENTITY (0, 1) NOT NULL,
    [fechaIni]            DATETIME NULL,
    [fechaFin]            DATETIME NULL,
    [valor]               FLOAT    NULL,
    [meta_id]             INT      NULL,
    [presupuesto_id]      INT      NULL,
    [jerarquiaDetalle_id] INT      NULL
);



