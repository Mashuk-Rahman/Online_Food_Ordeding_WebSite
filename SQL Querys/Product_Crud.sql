CREATE PROCEDURE [dbo].[Product_Crud]
@Action VARCHAR(10),
@ProductId INT = NULL,
@Name VARCHAR(100) = NULL,
@Description VARCHAR(MAX) = NULL,
@Price DECIMAL (18,2) = 0,
@Quantity INT = NULL,
@ImageUrl VARCHAR(MAX) = NULL,
@CategoryId INT = NULL,
@IsActive BIT = false
AS
BEGIN
SET NOCOUNT ON;
--SELECT--

	IF @Action = 'SELECT'
		BEGIN
			SELECT p.*,c.Name AS CategoryName FROM dbo.Products p
			INNER JOIN dbo.Categories c ON c.CategoryId = p.CategoryId ORDER BY p.CreateDate DESC
	END

--INSERT--

	IF @Action = 'INSERT'
		BEGIN
			INSERT INTO dbo.Products(Name, Description, Price, Quantity, ImageUrl, CategoryId, IsActive, CreateDate)
			VALUES(@Name, @Description, @Price, @Quantity, @ImageUrl, @CategoryId, @IsActive, GETDATE())
	END

--UPDATE--

	IF @Action = 'UPDATE'
		BEGIN
			DECLARE @UPDATE_IMAGE VARCHAR(20)
			SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
	IF @UPDATE_IMAGE = 'NO'
		BEGIN
			UPDATE dbo.Products
			SET Name = @Name, Description = @Description, Price = @Price, Quantity = @Quantity, CategoryId = @CategoryId, IsActive = @IsActive
			WHERE ProductId = @ProductId
	END
	ELSE
		BEGIN
			UPDATE dbo.Products
			SET Name =@Name, Description = @Description, Price = @Price, Quantity =@Quantity, ImageUrl = @ImageUrl, CategoryId = @CategoryId, IsActive = @IsActive
			WHERE ProductId = @ProductId
	END
END

--QUANTITY UPDATE--
	IF @Action = 'QTYUPDATE'
		BEGIN
			UPDATE DBO.Products SET Quantity = @Quantity
			WHERE ProductId = @ProductId
	END

--DELETE--

	IF @Action = 'DELETE'
		BEGIN
			DELETE FROM dbo.Products WHERE ProductId = @ProductId
	END
--GETBYID--
	IF @Action = 'GETBYID'
		BEGIN
			SELECT * FROM dbo.Products WHERE ProductId = @ProductId
	END
END