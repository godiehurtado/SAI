CREATE TABLE [dbo].[Siniestralidad] (
    [id]                   INT           IDENTITY (1, 1) NOT NULL,
    [participante_id]      INT           NULL,
    [compania_id]          INT           NULL,
    [fechaCorte]           DATETIME      NULL,
    [ramoDetalle_id]       INT           NULL,
    [clave]                NVARCHAR (50) NULL,
    [siniestrosIncurridos] FLOAT         NULL,
    [primasEmitidas]       FLOAT         NULL,
    [reservaTecnica]       FLOAT         NULL,
    [indSiniestralidad]    FLOAT         NULL,
    [jerarquiaDetalle_id]  INT           NULL
);



