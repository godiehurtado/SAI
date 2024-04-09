ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_Plan] FOREIGN KEY ([plan_id]) REFERENCES [dbo].[Plan] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

