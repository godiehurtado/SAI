ALTER TABLE [dbo].[JerarquiaDetalle]
    ADD CONSTRAINT [FK_JerarquiaDetalle_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

