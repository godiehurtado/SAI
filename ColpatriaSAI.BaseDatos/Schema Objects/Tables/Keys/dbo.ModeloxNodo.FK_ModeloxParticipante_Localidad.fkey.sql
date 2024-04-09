ALTER TABLE [dbo].[ModeloxNodo]
    ADD CONSTRAINT [FK_ModeloxParticipante_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

