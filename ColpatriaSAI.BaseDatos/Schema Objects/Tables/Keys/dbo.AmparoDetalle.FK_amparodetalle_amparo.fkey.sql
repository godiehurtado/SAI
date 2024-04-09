ALTER TABLE [dbo].[AmparoDetalle]
    ADD CONSTRAINT [FK_amparodetalle_amparo] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

