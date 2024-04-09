CREATE TABLE [dbo].[Premio] (
    [id]                 INT            IDENTITY (0, 1) NOT NULL,
    [descripcion]        TEXT           NULL,
    [tipoPremio_id]      INT            NULL,
    [operador_id]        INT            NULL,
    [valor]              FLOAT          NULL,
    [unidadmedida_id]    INT            NULL,
    [descripcion_premio] VARCHAR (8000) NULL,
    [variable_id]        INT            NULL,
    [regularidad]        BIT            NULL
);



