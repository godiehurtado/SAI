CREATE TABLE [dbo].[Regla] (
    [id]                 INT            IDENTITY (0, 1) NOT NULL,
    [descripcion]        TEXT           NULL,
    [concurso_id]        INT            NULL,
    [nombre]             NVARCHAR (300) NULL,
    [tipoRegla_id]       INT            NULL,
    [periodoRegla_id]    INT            NULL,
    [fecha_inicio]       DATETIME       NULL,
    [estrategiaregla_id] INT            NULL,
    [fecha_fin]          DATETIME       NULL,
    [regla_id]           INT            NULL
);







