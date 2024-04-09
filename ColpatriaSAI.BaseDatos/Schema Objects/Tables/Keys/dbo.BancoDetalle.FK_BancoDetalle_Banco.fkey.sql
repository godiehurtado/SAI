ALTER TABLE [dbo].[BancoDetalle]
    ADD CONSTRAINT [FK_BancoDetalle_Banco] FOREIGN KEY ([banco_id]) REFERENCES [dbo].[Banco] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

