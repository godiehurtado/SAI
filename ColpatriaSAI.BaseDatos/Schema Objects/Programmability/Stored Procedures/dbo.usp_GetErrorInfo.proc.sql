
-- Create procedure to retrieve error information.
CREATE PROCEDURE [dbo].[usp_GetErrorInfo]
AS
INSERT INTO logHomologacion (errorNumber, errorSeverity, errorState, errorProcedure, errorLine, errorMessage) VALUES (ERROR_NUMBER(),ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(),ERROR_LINE(), ERROR_MESSAGE())

    --ERROR_NUMBER() AS ErrorNumber
    --,ERROR_SEVERITY() AS ErrorSeverity
    --,ERROR_STATE() AS ErrorState
    --,ERROR_PROCEDURE() AS ErrorProcedure
    --,ERROR_LINE() AS ErrorLine
    --,ERROR_MESSAGE() AS ErrorMessage;
