﻿ALTER TABLE [dbo].[PackageTaskLog]
    ADD CONSTRAINT [PK_PackageTaskLog] PRIMARY KEY CLUSTERED ([PackageTaskLogID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

