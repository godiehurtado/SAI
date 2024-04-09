CREATE TABLE [dbo].[ParticipacionDirector] (
    [id]                  INT      IDENTITY (1, 1) NOT NULL,
    [fechaIni]            DATETIME NULL,
    [fechaFin]            DATETIME NULL,
    [compania_id]         INT      NULL,
    [jerarquiaDetalle_id] INT      NULL,
    [porcentaje]          FLOAT    NULL,
    [canal_id]            INT      NULL
);



