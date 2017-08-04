/*
	GetNewDetail
	Purpose: Determine the value for the new line item
	Input  : Call before an insert into line item
	--EXEC sp_help ORDERITEMS
*/

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'GetNewDetail')
	DROP PROCEDURE GetNewDetail;

GO



CREATE PROCEDURE GetNewDetail

 @v_orderItemDetail SMALLINT OUTPUT


AS
BEGIN

	SET @v_orderItemDetail = (select MAX(detail) + 1 from ORDERITEMS);
	

END;

BEGIN

	DECLARE @SQL SMALLINT

	SELECT @SQL EXECUTE GetNewDetail 6099;
	PRINT @SQL

END;

