CREATE TABLE [dbo].[ConsolidadoMes] (
    [id]                 INT            IDENTITY (1, 1) NOT NULL,
    [compania_id]        INT            NOT NULL,
    [ramo_id]            INT            NULL,
    [producto_id]        INT            NULL,
    [tipoMedida_id]      INT            NULL,
    [zona_id]            INT            NULL,
    [localidad_id]       INT            NULL,
    [clave]              NVARCHAR (100) NULL,
    [participante_id]    INT            NULL,
    [lineaNegocio_id]    INT            NULL,
    [plazo_id]           INT            NULL,
    [amparo_id]          INT            NULL,
    [modalidadPago_id]   INT            NULL,
    [segmento_id]        INT            NULL,
    [categoria_id]       INT            NULL,
    [Enero]              FLOAT          NULL,
    [Febrero]            FLOAT          NULL,
    [Marzo]              FLOAT          NULL,
    [Abril]              FLOAT          NULL,
    [Mayo]               FLOAT          NULL,
    [Junio]              FLOAT          NULL,
    [Julio]              FLOAT          NULL,
    [Agosto]             FLOAT          NULL,
    [Septiembre]         FLOAT          NULL,
    [Octubre]            FLOAT          NULL,
    [Noviembre]          FLOAT          NULL,
    [Diciembre]          FLOAT          NULL,
    [Ene_Mar]            FLOAT          NULL,
    [Abr_Jun]            FLOAT          NULL,
    [Jul_Sep]            FLOAT          NULL,
    [Oct_Dic]            FLOAT          NULL,
    [Ene_Jun]            FLOAT          NULL,
    [Jul_Dic]            FLOAT          NULL,
    [Ene_Dic]            FLOAT          NULL,
    [Ene_Mar_Total]      FLOAT          NULL,
    [Abr_Jun_Total]      FLOAT          NULL,
    [Jul_Sep_Total]      FLOAT          NULL,
    [Oct_Dic_Total]      FLOAT          NULL,
    [Etapa_1]            FLOAT          NULL,
    [Etapa_2]            FLOAT          NULL,
    [Etapa_3]            FLOAT          NULL,
    [Etapa_4]            FLOAT          NULL,
    [Etapa_5]            FLOAT          NULL,
    [FASECOLDA]          INT            NULL,
    [LIMRA]              INT            NULL,
    [año]                INT            NULL,
    [fechaIngresoAsesor] DATE           NULL
);









