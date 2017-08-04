/*
	Validate PartID
	inputs: PartID
	outputs: True/False
	--EXEC sp_help INVENTORY
*/

-- check to see if the procedure already exists
IF EXISTS (SELECT * FROM sys.objects WHERE name = 'ValidatePartID')
	DROP PROCEDURE ValidatePartID;

GO




CREATE PROCEDURE ValidatePartID

@v_PartID SMALLINT,
@v_RetVal CHAR(16) OUTPUT

AS 
	BEGIN

		SET @v_RetVal = 'Not Found';
	
		SELECT @v_RetVal = 'Found'
		FROM INVENTORY
		WHERE INVENTORY.partid = @v_PartID;

	END;


--test the procedure

BEGIN

	DECLARE @boing CHAR(16);

	EXECUTE ValidatePartID 1001, @boing OUTPUT;
	PRINT 'PartID 1001? ' + @boing;

	
END;