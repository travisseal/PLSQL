/*
	Type   : Procedure
	Purpose: Brings all the parts together under one roof.
	Input  : Custid, Orderid, PartID, Qty
	

*/



IF EXISTS (SELECT * FROM sys.objects WHERE name = 'Lab8proc')
	DROP PROCEDURE Lab8proc;

GO

CREATE PROCEDURE Lab8proc


AS 

BEGIN
	-- Input parameters

	DECLARE @v_CustID SMALLINT = 10;
	DECLARE @v_OrderID SMALLINT;
	DECLARE @v_PartID SMALLINT;
	DECLARE @v_Qty SMALLINT;
	
	DECLARE @orderRetVal CHAR(16);
	DECLARE @custRetVal CHAR(16);
	-- 1
	PRINT 'Lab 8 Procedure Started';
	
	-- 2 execute custid validation procedure print line giving the input custid and where it is valid or not
		
		BEGIN
			
			EXECUTE ValidateCustID @v_CustID, @custRetVal OUTPUT;
			PRINT 'Checking for customer: '
			
			IF @custRetVal = 'YES'
				BEGIN
					PRINT 'Customer is valid'
				END;
			ELSE
				BEGIN
					PRINT 'Customer is not valid';
				END;

		END;

		-- 3 Execute OrderID validation 
		BEGIN
			-- good orderID and Good customer
			EXECUTE ValidateOrderID 6099,10, @orderRetVal OUTPUT
		END;
		


END;

EXECUTE Lab8proc