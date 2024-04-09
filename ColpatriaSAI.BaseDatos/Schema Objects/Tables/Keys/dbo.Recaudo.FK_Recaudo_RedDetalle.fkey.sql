ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_RedDetalle] FOREIGN KEY ([redDetalle_id]) REFERENCES [dbo].[RedDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

