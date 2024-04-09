ALTER TABLE [dbo].[CondicionAgrupada]
    ADD CONSTRAINT [FK_SubRegla2_condicionAgrupada] FOREIGN KEY ([subregla_id2]) REFERENCES [dbo].[SubRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

