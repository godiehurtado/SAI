CREATE TABLE [dbo].[Ingreso] (
    [id]                    INT      IDENTITY (1, 1) NOT NULL,
    [participante_id]       INT      NOT NULL,
    [estadoParticipante_id] INT      NOT NULL,
    [fechaIngreso]          DATETIME NULL,
    [fechaRetiro]           DATETIME NULL,
    [ComisionesCAPI]        FLOAT    NULL,
    [ComisionesVIDA]        FLOAT    NULL,
    [ComisionesGENERALES]   FLOAT    NULL,
    [ComisionesORV]         FLOAT    NULL,
    [ComisionesORG]         FLOAT    NULL,
    [ComisionesSALUD]       FLOAT    NULL,
    [ComisionesSOAT]        FLOAT    NULL,
    [TotalComisiones]       FLOAT    NULL,
    [Periodo]               DATETIME NULL
);



