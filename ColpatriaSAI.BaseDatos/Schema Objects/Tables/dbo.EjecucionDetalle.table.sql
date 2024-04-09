CREATE TABLE [dbo].[EjecucionDetalle] (
    [id]           INT           IDENTITY (1, 1) NOT NULL,
    [ejecucion_id] INT           NULL,
    [meta_id]      INT           NULL,
    [nodo_id]      INT           NULL,
    [periodo]      DATE          NULL,
    [valor]        FLOAT         NULL,
    [tipo]         SMALLINT      NULL,
    [canal_id]     INT           NULL,
    [descripcion]  TEXT          NULL,
    [fechaAjuste]  DATE          NULL,
    [usuario]      VARCHAR (250) NULL
);



