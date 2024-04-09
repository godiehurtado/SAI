ALTER TABLE [dbo].[Participaciones]
    ADD CONSTRAINT [FK_participaciones_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

