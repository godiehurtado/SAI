ALTER TABLE [dbo].[ModeloxMeta]
    ADD CONSTRAINT [FK_ModeloxMeta_FactorxNota] FOREIGN KEY ([factorxnota_id]) REFERENCES [dbo].[FactorxNota] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

