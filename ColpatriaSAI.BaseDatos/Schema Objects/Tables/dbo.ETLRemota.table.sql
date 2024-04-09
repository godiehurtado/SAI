CREATE TABLE [dbo].[ETLRemota] (
    [id]                    INT            IDENTITY (1, 1) NOT NULL,
    [packageFileName]       NVARCHAR (50)  NOT NULL,
    [packageConfigFileName] NVARCHAR (50)  NOT NULL,
    [nombre]                NVARCHAR (100) NOT NULL,
    [tipoETLRemota_id]      INT            NOT NULL
);

