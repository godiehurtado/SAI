ALTER TABLE [dbo].[Pago]
    ADD CONSTRAINT [FK_Pago_AnticipoFranquicia] FOREIGN KEY ([anticipoFranquicia_id]) REFERENCES [dbo].[AnticipoFranquicia] ([Id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

