﻿
       /****** Object:  Stored Procedure log.EscribirLog    Script Date: 10/1/2004 3:16:36 PM ******/

       CREATE PROCEDURE [log].[EscribirLog]
       (
             @EventID int, 
             @Priority int, 
             @Severity nvarchar(32), 
             @Title nvarchar(256), 
             @Timestamp datetime,
             @MachineName nvarchar(32), 
             @AppDomainName nvarchar(512),
             @ProcessID nvarchar(256),
             @ProcessName nvarchar(512),
             @ThreadName nvarchar(512),
             @Win32ThreadId nvarchar(128),
             @Message nvarchar(1500),
             @FormattedMessage ntext,
             @LogId int OUTPUT
       )
       AS 
             INSERT INTO [log].[Log] (
                    EventID,
                    Priority,
                    Severity,
                    Title,
                    [Timestamp],
                    MachineName,
                    AppDomainName,
                    ProcessID,
                    ProcessName,
                    ThreadName,
                    Win32ThreadId,
                    Message,
                    FormattedMessage
             )
             VALUES (
                    @EventID, 
                    @Priority, 
                    @Severity, 
                    @Title, 
                    @Timestamp,
                    @MachineName, 
                    @AppDomainName,
                    @ProcessID,
                    @ProcessName,
                    @ThreadName,
                    @Win32ThreadId,
                    @Message,
                    @FormattedMessage)

             SET @LogID = @@IDENTITY
             RETURN @LogID
             