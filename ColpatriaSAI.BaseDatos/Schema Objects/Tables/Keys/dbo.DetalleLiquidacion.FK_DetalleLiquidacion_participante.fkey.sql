ALTER TABLE [dbo].[DetalleLiquidacion]
    ADD CONSTRAINT [FK_DetalleLiquidacion_participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

