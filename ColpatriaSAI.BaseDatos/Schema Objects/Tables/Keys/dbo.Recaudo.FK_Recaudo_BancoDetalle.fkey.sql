ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_BancoDetalle] FOREIGN KEY ([bancoDetalle_id]) REFERENCES [dbo].[BancoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

