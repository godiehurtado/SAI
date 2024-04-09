ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_ramo_id] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

