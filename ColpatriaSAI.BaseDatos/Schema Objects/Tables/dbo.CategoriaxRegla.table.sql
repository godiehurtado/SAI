CREATE TABLE [dbo].[CategoriaxRegla] (
    [id]           INT IDENTITY(1,1) NOT NULL,
    [regla_id]     INT NOT NULL,
    [categoria_id] INT NOT NULL,
    [esRecaudo]    BIT NOT NULL,
    [esColquin]    BIT NOT NULL
);

