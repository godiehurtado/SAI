﻿ALTER TABLE [dbo].[RedDetalle]
    ADD CONSTRAINT [FK_RedDetalle_Red] FOREIGN KEY ([red_id]) REFERENCES [dbo].[Red] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

