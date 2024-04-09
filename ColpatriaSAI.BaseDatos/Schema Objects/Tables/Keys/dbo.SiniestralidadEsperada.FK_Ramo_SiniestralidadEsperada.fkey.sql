ALTER TABLE [dbo].[SiniestralidadEsperada]
    ADD CONSTRAINT [FK_Ramo_SiniestralidadEsperada] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

