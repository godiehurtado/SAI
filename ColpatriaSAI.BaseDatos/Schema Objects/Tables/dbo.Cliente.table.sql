CREATE TABLE [dbo].[Cliente] (
    [id]                    INT            IDENTITY (0, 1) NOT NULL,
    [cedula]                NVARCHAR (50)  NULL,
    [nombre]                NVARCHAR (250) NULL,
    [fechaNacimiento]       DATETIME       NULL,
    [actividadEconomica_id] INT            NULL,
    [microsegmento_id]      INT            NULL,
    [tipoDocumento_id]      INT            NULL
);





