ALTER TABLE [dbo].[TopexEdad]
    ADD CONSTRAINT [FK_TopexEdad_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

