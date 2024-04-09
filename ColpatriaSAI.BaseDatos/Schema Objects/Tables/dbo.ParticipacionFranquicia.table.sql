CREATE TABLE [dbo].[ParticipacionFranquicia] (
    [id]                  INT      IDENTITY (1, 1) NOT NULL,
    [fecha_ini]           DATETIME NOT NULL,
    [fecha_fin]           DATETIME NULL,
    [Localidad_id]        INT      NULL,
    [fecha_actualizacion] DATETIME NOT NULL
);



