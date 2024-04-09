ALTER TABLE [dbo].[ParticipacionFranquicia]
    ADD CONSTRAINT [FK_ParticipacionFranquicia_Localidad] FOREIGN KEY ([Localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

