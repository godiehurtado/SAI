ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_formaPago_recaudo] FOREIGN KEY ([formaPago_id]) REFERENCES [dbo].[FormaPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

