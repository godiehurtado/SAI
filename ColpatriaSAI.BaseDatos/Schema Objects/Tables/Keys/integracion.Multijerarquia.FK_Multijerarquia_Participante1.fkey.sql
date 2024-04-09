ALTER TABLE [integracion].[Multijerarquia]
    ADD CONSTRAINT [FK_Multijerarquia_Participante1] FOREIGN KEY ([participante_id]) REFERENCES [integracion].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

