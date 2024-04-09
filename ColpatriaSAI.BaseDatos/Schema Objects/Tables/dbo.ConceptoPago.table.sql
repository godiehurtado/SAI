CREATE TABLE [dbo].[ConceptoPago] (
    [id]                INT            IDENTITY (0, 1) NOT NULL,
    [nombre]            NVARCHAR (100) NULL,
    [codigoIncentivos]  NVARCHAR (5)   NULL,
    [codigoFranquicias] NVARCHAR (5)   NULL,
    [compania_id]       INT            NULL
);



