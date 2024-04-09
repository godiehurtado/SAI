CREATE TABLE [dbo].[Pago] (
    [id]                        INT            IDENTITY (1, 1) NOT NULL,
    [detallePagosFranquicia_id] INT            NULL,
    [detallePagosRegla_id]      INT            NULL,
    [anticipoFranquicia_id]     INT            NULL,
    [compania_id]               INT            NULL,
    [clave]                     NVARCHAR (50)  NULL,
    [tipoDocumento_id]          INT            NULL,
    [documento]                 NVARCHAR (30)  NULL,
    [totalParticipacion]        FLOAT          NULL,
    [descripcion]               NVARCHAR (150) NULL,
    [fechaPago]                 DATETIME       NOT NULL,
    [estado]                    INT            NOT NULL
);





