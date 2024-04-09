CREATE TABLE [dbo].[DetalleLiquidacionRegla] (
    [id]                               INT IDENTITY (1, 1) NOT NULL,
    [liquidacionReglaxParticipante_id] INT NULL,
    [subregla_id]                      INT NULL,
    [resultado]                        BIT NULL
);



