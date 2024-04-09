ALTER TABLE [dbo].[CompaniaxEtapa]
    ADD CONSTRAINT [FK_CompaniaxEtapa_etapa] FOREIGN KEY ([etapa_id]) REFERENCES [dbo].[EtapaProducto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

