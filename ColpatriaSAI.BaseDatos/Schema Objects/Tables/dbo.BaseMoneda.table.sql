CREATE TABLE [dbo].[BaseMoneda] (
    [id]                   INT      IDENTITY (0, 1) NOT NULL,
    [fecha_inicioVigencia] DATETIME NULL,
    [fecha_finVigencia]    DATETIME NULL,
    [base]                 FLOAT    NULL,
    [moneda_id]            INT      NULL
);



