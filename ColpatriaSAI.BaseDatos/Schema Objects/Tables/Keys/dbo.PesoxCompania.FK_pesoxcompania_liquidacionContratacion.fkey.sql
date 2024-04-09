ALTER TABLE [dbo].[PesoxCompania]
    ADD CONSTRAINT [FK_pesoxcompania_liquidacionContratacion] FOREIGN KEY ([liquidacionContratacion_id]) REFERENCES [dbo].[LiquidacionContratacion] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

