ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_amparo_negocio] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

