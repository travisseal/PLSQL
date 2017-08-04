/*
	OrderitemsInsertTrg
	Purpose: update the inventory table
			to reflect the insert made into orderitems

*/

IF EXISTS (SELECT * FROM sys.objects WHERE name = 'OrderitemsInsertTrg')
	DROP TRIGGER OrderitemsInsertTrg;

GO

CREATE TRIGGER OrderitemsInsertTrg
ON ORDERITEMS FOR INSERT AS

DECLARE @v_OrderQty SMALLINT;
DECLARE @v_OrderPrt SMALLINT;
DECLARE @v_CurrentInventoryQty SMALLINT;
DECLARE @v_CalculatedInventory SMALLINT;
DECLARE @vErrStr VARCHAR(80);
BEGIN

	-- GET QUANTITY FROM RECENT ORDER
	SET @v_OrderQty = (SELECT qty FROM inserted);
	-- GET PART FROM RECENT ORDER
	SET @v_OrderPrt = (SELECT partid FROM inserted);
	
	-- GET CURRENT QTY FROM INVENTORY
	SET @v_CurrentInventoryQty = (
									SELECT INVENTORY.stockqty
									FROM INVENTORY
									WHERE INVENTORY.partid = @v_OrderPrt
								  );
	-- CALCULATE NEW INVENTORY 
	SET @v_CalculatedInventory = (@v_CurrentInventoryQty - @v_OrderQty)

    
	-- UPDATE THE NEW QUANTITY FOR THE RECENT ORDER USING THE PARTID

	IF (@v_CalculatedInventory >= 0)
		BEGIN
			
				PRINT 'Good inventory number';
				UPDATE INVENTORY
				SET stockqty = @v_CalculatedInventory
				WHERE partid = @v_OrderPrt;

				
		END;
	ELSE
		BEGIN
		---------------------
		--I only do this to trigger the next trigger.
		--	UPDATE INVENTORY
			--SET stockqty = @v_CalculatedInventory
		--	WHERE partid = @v_OrderPrt;
		---------------------
			SET @vErrStr = 'ERROR: CANNOT UPDATE TO A NEGITIVE NUMBER:';
			RaisError(@vErrStr,2,2) WITH SetError;
		END;

	

END; 

-- test it! This script will succeed

BEGIN

	DECLARE @v_newDetail SMALLINT;

	SET @v_newDetail =( 
						SELECT detail + 1
						FROM ORDERITEMS
						WHERE detail = (SELECT MAX(detail)
										FROM ORDERITEMS)
						);

begin transaction
	insert into ORDERITEMS values (6099,@v_newDetail,1002,10)
commit transaction
	
END;


-- test it too! This will fail
BEGIN

	DECLARE @v_newDetail SMALLINT;

	SET @v_newDetail =( 
						SELECT detail + 1
						FROM ORDERITEMS
						WHERE detail = (SELECT MAX(detail)
										FROM ORDERITEMS)
						);


	insert into ORDERITEMS values (6099,@v_newDetail,1002,100)

	
END;

