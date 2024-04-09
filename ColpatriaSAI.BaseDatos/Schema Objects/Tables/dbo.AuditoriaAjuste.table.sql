CREATE TABLE [dbo].[AuditoriaAjuste] (
    [id]                                INT            IDENTITY (1, 1) NOT NULL,
    [detallePagosRegla_id]              INT            NULL,
    [detallePagosFranquicia_id]         INT            NULL,
    [liquiContratFactorParticipante_id] INT            NULL,
    [fecha]                             DATETIME       NOT NULL,
    [usuario]                           NVARCHAR (50)  NOT NULL,
    [valor]                             FLOAT          NOT NULL,
    [descripcion]                       NVARCHAR (250) NOT NULL
);

