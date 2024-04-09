ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_zona_id] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

