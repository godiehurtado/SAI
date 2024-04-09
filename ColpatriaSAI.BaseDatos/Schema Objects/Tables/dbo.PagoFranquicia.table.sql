CREATE TABLE [dbo].[PagoFranquicia] (
    [id]                       INT            IDENTITY (1, 1) NOT NULL,
    [fechaPago]                DATETIME       NULL,
    [liquidacionFranquicia_id] INT            NULL,
    [anticipo_id]              INT            NULL,
    [usuario]                  NVARCHAR (100) NULL
);



