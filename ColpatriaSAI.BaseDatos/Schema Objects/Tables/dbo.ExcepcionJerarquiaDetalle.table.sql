CREATE TABLE [dbo].[ExcepcionJerarquiaDetalle] (
    [id]                           INT IDENTITY (1, 1) NOT NULL,
    [excepcionJerarquiaOrigen_id]  INT NULL,
    [excepcionJerarquiaDestino_id] INT NULL,
    [compania_id]                  INT NULL,
    [ramo_id]                      INT NULL,
    [producto_id]                  INT NULL
);



