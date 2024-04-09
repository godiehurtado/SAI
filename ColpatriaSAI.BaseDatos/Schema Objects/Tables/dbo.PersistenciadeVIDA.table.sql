CREATE TABLE [dbo].[PersistenciadeVIDA] (
    [participante_id]                     INT           NULL,
    [compania_id]                         INT           NULL,
    [ramo_id]                             INT           NULL,
    [jerarquiaDetalle_id]                 INT           NULL,
    [añoAMedir]                           INT           NULL,
    [añoAnterior]                         INT           NULL,
    [tipoPersistencia]                    NVARCHAR (50) NULL,
    [cantidadNegociosAñoActual]           FLOAT         NULL,
    [cantidadNegociosVigentesAñoActual]   FLOAT         NULL,
    [sumaPrimasAñoActual]                 FLOAT         NULL,
    [sumaPrimasVigentesAñoActual]         FLOAT         NULL,
    [cumplimientoNegociosAñoActual]       FLOAT         NULL,
    [cumplimientoPrimasAñoActual]         FLOAT         NULL,
    [ponderacionNegociosAñoActual]        FLOAT         NULL,
    [ponderacionPrimasAñoActual]          FLOAT         NULL,
    [cantidadNegociosAñoAnterior]         FLOAT         NULL,
    [sumaPrimasAñoAnterior]               FLOAT         NULL,
    [cantidadNegociosVigentesAñoAnterior] FLOAT         NULL,
    [sumaPrimasVigentesAñoAnterior]       FLOAT         NULL,
    [cumplimientoNegociosAñoAnterior]     FLOAT         NULL,
    [cumplimientoPrimasAñoAnterior]       FLOAT         NULL,
    [ponderacionNegociosAñoAnterior]      FLOAT         NULL,
    [ponderacionPrimasAñoAnterior]        FLOAT         NULL,
    [ponderadaNegocios]                   FLOAT         NULL,
    [ponderadaPrimas]                     FLOAT         NULL,
    [subtotalNegocios]                    NVARCHAR (50) NULL,
    [subtotalPrimas]                      NVARCHAR (50) NULL,
    [persistenciaDefinitiva]              FLOAT         NULL,
    [fechaMedicionPersistencia]           DATETIME      NULL,
    [mesCorte]                            INT           NULL,
    [colquinesDescontar]                  FLOAT         NULL,
    [recaudosDescontar]                   FLOAT         NULL
);











