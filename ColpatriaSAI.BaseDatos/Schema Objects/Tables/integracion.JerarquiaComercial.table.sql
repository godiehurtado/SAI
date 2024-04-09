CREATE TABLE [integracion].[JerarquiaComercial] (
    [id]              INT            NOT NULL,
    [nombreJerarquia] NVARCHAR (100) NULL,
    [nombreNodo]      NVARCHAR (100) NULL,
    [padre_id]        INT            NULL,
    [zona_id]         INT            NULL,
    [localidad_id]    INT            NULL,
    [canal_id]        INT            NULL,
    [segmento_id]     INT            NULL,
    [participante_id] INT            NULL
);



