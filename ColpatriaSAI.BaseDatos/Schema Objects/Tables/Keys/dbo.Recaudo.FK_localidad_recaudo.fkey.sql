ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_localidad_recaudo] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

