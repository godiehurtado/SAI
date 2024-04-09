ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_Red] FOREIGN KEY ([red_id]) REFERENCES [dbo].[Red] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

