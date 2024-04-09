ALTER TABLE [dbo].[ExcepcionJerarquiaDetalle]
    ADD CONSTRAINT [FK_ExcepcionJerarquiaDetalle_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

