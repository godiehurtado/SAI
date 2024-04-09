CREATE TABLE [dbo].[BancoDetalle] (
    [id]          INT            IDENTITY (0, 1) NOT NULL,
    [nombre]      NVARCHAR (100) NULL,
    [codigoCore]  NVARCHAR (50)  NULL,
    [compania_id] INT            NULL,
    [banco_id]    INT            NULL
);

