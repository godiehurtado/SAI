CREATE TABLE [dbo].[ConceptoDescuento] (
    [id]            INT            IDENTITY (0, 1) NOT NULL,
    [nombre]        NVARCHAR (50)  NULL,
    [descripcion]   NVARCHAR (MAX) NULL,
    [tipoMedida_id] INT            NULL
);

