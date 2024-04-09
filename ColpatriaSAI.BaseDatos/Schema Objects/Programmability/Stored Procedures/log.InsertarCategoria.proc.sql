
       CREATE PROCEDURE [log].[InsertarCategoria]
             -- Add the parameters for the function here
             @CategoryName nvarchar(64),
             @LogID int
       AS
       BEGIN
             SET NOCOUNT ON;
             DECLARE @CatID INT
             SELECT @CatID = CategoryID FROM log.Categoria WHERE CategoryName = @CategoryName
             IF @CatID IS NULL
             BEGIN
                    INSERT INTO log.Categoria (CategoryName) VALUES(@CategoryName)
                    SELECT @CatID = @@IDENTITY
             END

             EXEC InsertCategoryLog @CatID, @LogID 

             RETURN @CatID
       END
       