ALTER TABLE [dbo].[AnticipoFranquicia]
    ADD CONSTRAINT [DF_AnticipoFranquicia_saldo] DEFAULT ((0)) FOR [saldo];

