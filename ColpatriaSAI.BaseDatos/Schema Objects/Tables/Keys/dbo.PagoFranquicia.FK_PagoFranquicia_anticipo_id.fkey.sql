ALTER TABLE [dbo].[PagoFranquicia]
    ADD CONSTRAINT [FK_PagoFranquicia_anticipo_id] FOREIGN KEY ([anticipo_id]) REFERENCES [dbo].[AnticipoFranquicia] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

