ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_cobertura_recaudo] FOREIGN KEY ([cobertura_id]) REFERENCES [dbo].[Cobertura] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

