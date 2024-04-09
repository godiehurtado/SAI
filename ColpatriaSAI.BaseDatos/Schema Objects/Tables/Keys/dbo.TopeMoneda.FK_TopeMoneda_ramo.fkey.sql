ALTER TABLE [dbo].[TopeMoneda]
    ADD CONSTRAINT [FK_TopeMoneda_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

