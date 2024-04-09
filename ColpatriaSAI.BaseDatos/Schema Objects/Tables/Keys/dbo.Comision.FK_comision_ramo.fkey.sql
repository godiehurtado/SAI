ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_comision_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

