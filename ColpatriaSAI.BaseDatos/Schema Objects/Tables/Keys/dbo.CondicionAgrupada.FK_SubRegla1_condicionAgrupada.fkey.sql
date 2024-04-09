ALTER TABLE [dbo].[CondicionAgrupada]
    ADD CONSTRAINT [FK_SubRegla1_condicionAgrupada] FOREIGN KEY ([subregla_id1]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

