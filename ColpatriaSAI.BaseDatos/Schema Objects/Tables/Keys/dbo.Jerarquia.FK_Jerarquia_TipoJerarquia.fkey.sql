ALTER TABLE [dbo].[Jerarquia]
    ADD CONSTRAINT [FK_Jerarquia_TipoJerarquia] FOREIGN KEY ([tipoJerarquia_id]) REFERENCES [dbo].[TipoJerarquia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

