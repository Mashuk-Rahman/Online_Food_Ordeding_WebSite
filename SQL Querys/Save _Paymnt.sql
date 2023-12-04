CREATE PROCEDURE [dbo].[Save_Payment]
	@Name VARCHAR(100) = NULL,
	@CardNo VARCHAR(50) = NULL,
	@ExpiryDate VARCHAR(50) = NULL,
	@Cvv INT = NULL,
	@Address VARCHAR(MAX) = NULL,
	@PaymentMode VARCHAR(10) = 'card',
	@InsertedId int OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	--Insert
	BEGIN
	INSERT INTO dbo.Payment(Name, CardNo, ExpiryDate, CvvNo, Address, PaymentMode)
	VALUES (@Name, @CardNo, @ExpiryDate, @Cvv, @Address, @PaymentMode)

	SELECT @InsertedId = SCOPE_IDENTITY();
  END	

END