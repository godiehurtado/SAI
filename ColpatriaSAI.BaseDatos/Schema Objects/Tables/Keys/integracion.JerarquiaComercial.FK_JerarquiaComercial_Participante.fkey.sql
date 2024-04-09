ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_Participante] FOREIGN KEY ([participante_id]) REFERENCES [integracion].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

