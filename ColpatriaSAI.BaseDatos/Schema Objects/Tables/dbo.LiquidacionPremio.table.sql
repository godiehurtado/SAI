CREATE TABLE [dbo].[LiquidacionPremio] (
    [id]                               INT           IDENTITY (1, 1) NOT NULL,
    [liquidacionReglaxParticipante_id] INT           NULL,
    [premio_id]                        INT           NULL,
    [resultado]                        NVARCHAR (50) NULL,
    [estado]                           NVARCHAR (50) NULL,
    [subregla_id]                      INT           NULL
);





