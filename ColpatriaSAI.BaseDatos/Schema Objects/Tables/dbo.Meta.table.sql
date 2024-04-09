CREATE TABLE [dbo].[Meta] (
    [id]                 INT            IDENTITY (0, 1) NOT NULL,
    [nombre]             NVARCHAR (100) NULL,
    [tipoMedida_id]      INT            NULL,
    [tipoMeta_id]        INT            NULL,
    [automatica]         BIT            NULL,
    [tipoMetaCalculo_id] INT            NULL,
    [meta_id]            INT            NULL
);



