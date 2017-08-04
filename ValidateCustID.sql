USE s276TSeal


--1 check to see if procedure is created
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'ValidateCustID')

--2 drop procedure
DROP PROCEDURE ValidateCustID;

GO

--3 create procedure
CREATE PROCEDURE ValidateCustID

-- 4 declare variables
@v_Custid SMALLINT,
@v_RetVal CHAR(4) OUTPUT

AS
--5 main block
BEGIN 

	SET @v_RetVal = 'NO'; -- initailize
	SELECT @v_RetVal = 'YES'
	FROM CUSTOMERS
	WHERE CUSTOMERS.custid = @v_Custid;

END;

GO

-- TEST MY PROCEDURE


BEGIN
	DECLARE @thing CHAR(4);


	EXECUTE ValidateCustID 10, @thing OUTPUT;
	PRINT 'Customer 10 exists? ' + @thing;

	EXECUTE ValidateCustID 666, @thing OUTPUT;
	PRINT 'Customer 666 exists? ' + @thing;

END;