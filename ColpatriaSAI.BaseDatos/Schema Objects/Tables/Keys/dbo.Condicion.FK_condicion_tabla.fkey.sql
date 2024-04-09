ALTER TABLE [dbo].[Condicion]
    ADD CONSTRAINT [FK_condicion_tabla] FOREIGN KEY ([tabla_id]) REFERENCES [dbo].[tablas] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

