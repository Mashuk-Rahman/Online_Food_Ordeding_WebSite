SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Invoice 
	@Action VARCHAR(10),
	@PaymentId INT = NULL,
	@UserId INT = NULL,
	@OrderDetailsId INT = NULL,
	@Status VARCHAR(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
	--Get Invoice by Id
	IF @Action = 'INVOICBYID'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo], o.OrderNo, p.Name, p.Price, o.Quantity,
			(p.Price * o.Quantity) as TotalPrice, o.OrderDate, o.Status FROM Orders o
			INNER JOIN Products p ON p.ProductId = o.ProductId
			WHERE o.PaymentId = @PaymentId AND o.UserId = @UserId
		END
    --Select Order History
	IF @Action = 'ODRHISTORY'
		BEGIN
			SELECT DISTINCT o.PaymentId, p.PaymentMode, p.CardNo FROM Orders o
			INNER JOIN Payment p on o.PaymentId = o.PaymentId
			WHERE o.UserId = @UserId
		END

	--Get Order Status
	IF @Action = 'GETSTATUS'
		BEGIN
			SELECT o.OrderDetailsId, o.OrderNo, (pr.Price * o.Quantity) as TotalPrice, o.Status,
			o.OrderDate, p.PaymentMode, pr.Name FROM Orders o
			INNER JOIN Payment p ON p.PaymentId = o.PaymentId
			INNER JOIN Products pr ON Pr.ProductId = o.ProductId
		END

	--Get Order Status By Id
	IF @Action = 'STATUSBYID'
		BEGIN
			SELECT OrderDetailsId, Status fROM Orders
			WHERE OrderDetailsId = @OrderDetailsId
		END
	--Update Order Status 
	IF @Action = 'UPDSTATUS'
		BEGIN
			UPDATE dbo.Orders
			SET Status = @Status WHERE OrderDetailsId = @OrderDetailsId
		END
END	
GO
