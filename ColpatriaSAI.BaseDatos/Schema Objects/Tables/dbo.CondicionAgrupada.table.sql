CREATE TABLE [dbo].[CondicionAgrupada] (
    [id]           INT            IDENTITY (0, 1) NOT NULL,
    [subregla_id1] INT            NULL,
    [subregla_id2] INT            NULL,
    [operador_id]  INT            NULL,
    [regla_id]     INT            NULL,
    [nombre]       NVARCHAR (100) NULL
);



