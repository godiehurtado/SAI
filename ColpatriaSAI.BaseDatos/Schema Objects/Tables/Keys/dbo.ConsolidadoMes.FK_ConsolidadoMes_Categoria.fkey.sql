ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_ConsolidadoMes_Categoria] FOREIGN KEY ([categoria_id]) REFERENCES [dbo].[Categoria] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

