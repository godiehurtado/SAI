ALTER TABLE [dbo].[PremiosxComboCRM]
    ADD CONSTRAINT [FK_PremiosxComboCRM_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

