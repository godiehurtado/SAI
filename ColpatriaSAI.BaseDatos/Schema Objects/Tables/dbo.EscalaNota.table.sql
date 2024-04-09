CREATE TABLE [dbo].[EscalaNota] (
    [id]             INT      IDENTITY (0, 1) NOT NULL,
    [nota]           FLOAT    NULL,
    [porcentaje]     FLOAT    NULL,
    [tipoEscala_id]  INT      NULL,
    [limiteInferior] INT      NULL,
    [limiteSuperior] INT      NULL,
    [fechaIni]       DATETIME NULL,
    [fechaFin]       DATETIME NULL
);



