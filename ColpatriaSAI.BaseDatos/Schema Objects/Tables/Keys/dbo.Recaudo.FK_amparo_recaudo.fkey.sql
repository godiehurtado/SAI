ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_amparo_recaudo] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

