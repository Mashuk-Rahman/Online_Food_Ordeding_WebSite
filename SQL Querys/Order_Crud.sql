CREATE PROCEDURE [dbo].[Save_Orders] @tblOrders OrderDetails READONLY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Orders(OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate)
	SELECT OrderNo, ProductId, Quantity, UserId, Status, PaymentId, OrderDate FROM @tblOrders
END



