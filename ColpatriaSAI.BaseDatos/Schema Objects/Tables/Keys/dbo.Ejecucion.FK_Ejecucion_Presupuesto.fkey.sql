ALTER TABLE [dbo].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Presupuesto] FOREIGN KEY ([presupuesto_id]) REFERENCES [dbo].[Presupuesto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

