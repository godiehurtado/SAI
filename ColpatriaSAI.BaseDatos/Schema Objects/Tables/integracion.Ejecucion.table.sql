CREATE TABLE [integracion].[Ejecucion] (
    [id]              INT   IDENTITY (1, 1) NOT NULL,
    [zona_id]         INT   NULL,
    [localidad_id]    INT   NULL,
    [participante_id] INT   NULL,
    [nodo_id]         INT   NOT NULL,
    [meta_id]         INT   NULL,
    [segmento_id]     INT   NULL,
    [fecha]           DATE  NULL,
    [valor]           FLOAT NULL
);





