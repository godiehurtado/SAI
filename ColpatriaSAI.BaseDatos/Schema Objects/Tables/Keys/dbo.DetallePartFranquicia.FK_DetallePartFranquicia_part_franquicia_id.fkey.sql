ALTER TABLE [dbo].[DetallePartFranquicia]
    ADD CONSTRAINT [FK_DetallePartFranquicia_part_franquicia_id] FOREIGN KEY ([part_franquicia_id]) REFERENCES [dbo].[ParticipacionFranquicia] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

