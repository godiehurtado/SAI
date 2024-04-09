ALTER TABLE [dbo].[Localidad]
    ADD CONSTRAINT [DF_dbo_Localidad_clavePago] DEFAULT ((0)) FOR [clavePago];

