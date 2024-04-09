ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_Combo] FOREIGN KEY ([combo_id]) REFERENCES [dbo].[Combo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;















