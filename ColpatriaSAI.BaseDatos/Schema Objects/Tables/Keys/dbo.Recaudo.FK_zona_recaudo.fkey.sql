ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_zona_recaudo] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

