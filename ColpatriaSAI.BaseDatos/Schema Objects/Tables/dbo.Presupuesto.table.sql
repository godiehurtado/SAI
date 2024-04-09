CREATE TABLE [dbo].[Presupuesto] (
    [id]                INT      IDENTITY (0, 1) NOT NULL,
    [fechaInicio]       DATETIME NULL,
    [fechaFin]          DATETIME NULL,
    [fechaModificacion] DATETIME NULL,
    [segmento_id]       INT      NOT NULL,
    [calculado]         BIT      NULL
);



