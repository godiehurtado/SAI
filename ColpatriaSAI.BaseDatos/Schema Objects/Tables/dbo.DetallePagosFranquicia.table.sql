CREATE TABLE [dbo].[DetallePagosFranquicia] (
    [compania_id]             INT            NULL,
    [clave]                   NVARCHAR (50)  NULL,
    [tipoDocumento_id]        INT            NULL,
    [documento]               NVARCHAR (20)  NULL,
    [numeroNegocio]           NVARCHAR (100) NULL,
    [ramo_id]                 INT            NULL,
    [fechaRecaudo]            DATETIME       NULL,
    [concepto_id]             INT            NULL,
    [totalParticipacion]      FLOAT          NULL,
    [porcentajeComision]      FLOAT          NULL,
    [porcentajeParticipacion] FLOAT          NULL,
    [descripcion]             NVARCHAR (150) NULL,
    [id]                      INT            IDENTITY (0, 1) NOT NULL,
    [pagoFranquicia_id]       INT            NOT NULL,
    [valorAjuste]             FLOAT          NULL,
    [totalAjuste]             FLOAT          NULL
);





