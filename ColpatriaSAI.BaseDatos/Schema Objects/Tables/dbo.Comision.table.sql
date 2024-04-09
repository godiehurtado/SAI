CREATE TABLE [dbo].[Comision] (
    [id]                    INT            IDENTITY (0, 1) NOT NULL,
    [ramo_id]               INT            NULL,
    [participante_id]       INT            NULL,
    [lineaNegocio_id]       INT            NULL,
    [localidad_id]          INT            NULL,
    [concepto]              INT            NULL,
    [companiaMovimiento_id] INT            NULL,
    [companiaAsesor_id]     INT            NULL,
    [clave]                 NVARCHAR (50)  NULL,
    [año]                   INT            NULL,
    [mes]                   INT            NULL,
    [valorConcepto]         NVARCHAR (50)  NULL,
    [indicadorPago]         NVARCHAR (50)  NULL,
    [numeroNegocio]         NVARCHAR (150) NULL,
    [segmento_id]           INT            NULL
);



