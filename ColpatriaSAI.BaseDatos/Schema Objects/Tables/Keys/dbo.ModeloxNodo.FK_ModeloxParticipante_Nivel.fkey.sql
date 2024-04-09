ALTER TABLE [dbo].[ModeloxNodo]
    ADD CONSTRAINT [FK_ModeloxParticipante_Nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

