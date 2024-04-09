CREATE TYPE [dbo].[Comisiontemp] AS  TABLE (
    [companiaMovimiento_id] INT            NULL,
    [ramo_id]               INT            NULL,
    [lineaNegocio_id]       INT            NULL,
    [participante_id]       INT            NULL,
    [segmento_id]           INT            NULL,
    [año]                   INT            NULL,
    [mes]                   INT            NULL,
    [valorConcepto]         FLOAT          NULL,
    [numeroNegocio]         NVARCHAR (250) NULL);

