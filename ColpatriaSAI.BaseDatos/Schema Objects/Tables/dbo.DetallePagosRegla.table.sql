CREATE TABLE [dbo].[DetallePagosRegla] (
    [compania_id]             INT            NULL,
    [clave]                   NVARCHAR (50)  NULL,
    [tipoDocumento_id]        INT            NULL,
    [documento]               NVARCHAR (30)  NULL,
    [totalParticipacion]      FLOAT          NULL,
    [porcentajeComision]      FLOAT          NULL,
    [porcentajeParticipacion] FLOAT          NULL,
    [descripcion]             NVARCHAR (150) NULL,
    [id]                      INT            IDENTITY (0, 1) NOT NULL,
    [liquidacionRegla_id]     INT            NOT NULL,
    [estado]                  INT            NULL,
    [fechaLiquidacion]        DATETIME       NULL,
    [valorAjuste]             FLOAT          NULL,
    [totalAjuste]             FLOAT          NULL
);





