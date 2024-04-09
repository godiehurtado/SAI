ALTER TABLE [dbo].[UsuarioxSegmento]
    ADD CONSTRAINT [FK_UsuarioxSegmento_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

