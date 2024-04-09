ALTER TABLE [dbo].[ModeloxNodo]
    ADD CONSTRAINT [FK_ModeloxParticipante_Zona] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

