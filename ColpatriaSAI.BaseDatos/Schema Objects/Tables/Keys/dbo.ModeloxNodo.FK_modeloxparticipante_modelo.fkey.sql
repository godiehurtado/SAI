ALTER TABLE [dbo].[ModeloxNodo]
    ADD CONSTRAINT [FK_modeloxparticipante_modelo] FOREIGN KEY ([modelo_id]) REFERENCES [dbo].[Modelo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

