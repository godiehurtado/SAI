CREATE TABLE [dbo].[PesoxCompania] (
    [id]                         INT   IDENTITY (0, 1) NOT NULL,
    [compania_id]                INT   NULL,
    [participante_id]            INT   NULL,
    [liquidacionContratacion_id] INT   NULL,
    [porcentaje]                 FLOAT NULL
);

