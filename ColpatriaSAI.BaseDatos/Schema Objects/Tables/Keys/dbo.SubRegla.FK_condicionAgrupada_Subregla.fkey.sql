ALTER TABLE [dbo].[SubRegla]
    ADD CONSTRAINT [FK_condicionAgrupada_Subregla] FOREIGN KEY ([condicionAgrupada_id]) REFERENCES [dbo].[CondicionAgrupada] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

