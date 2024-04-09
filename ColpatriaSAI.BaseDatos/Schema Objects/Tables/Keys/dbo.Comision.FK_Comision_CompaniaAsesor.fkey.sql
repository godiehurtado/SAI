ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_Comision_CompaniaAsesor] FOREIGN KEY ([companiaAsesor_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

