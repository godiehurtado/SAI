ALTER TABLE [dbo].[EtapaProducto]
    ADD CONSTRAINT [FK_etapaProducto_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

