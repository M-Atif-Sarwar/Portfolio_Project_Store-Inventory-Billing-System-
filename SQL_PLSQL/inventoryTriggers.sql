
CREATE OR REPLACE TRIGGER trg_inventory_insert
BEFORE INSERT ON inventory
FOR EACH ROW
DECLARE
    Invalid_Name EXCEPTION;
    
    NULL_Quantity_Error EXCEPTION;
    
    Invalid_Price EXCEPTION;
    ZERO_Price_Error EXCEPTION;
    NULL_Price_Error EXCEPTION;
  
    NULL_Size_Error EXCEPTION;
   
BEGIN
    :NEW.Product_Name := TRIM(INITCAP(:NEW.Product_Name));
    :NEW.Product_Flavor := TRIM(INITCAP(:NEW.Product_Flavor));
    :NEW.Product_Size := TRIM(:NEW.Product_Size);

-- name validation 
    IF :NEW.Product_Name IS NULL THEN
        RAISE Invalid_Name;
    END IF;
-- price validations 
    IF :NEW.Product_Price < 0 THEN
        RAISE Invalid_Price;
    ELSIF :NEW.Product_Price IS NULL THEN
        RAISE NULL_Price_Error;
    ELSIF :NEW.Product_Price = 0 THEN
        RAISE ZERO_Price_Error;
    END IF;

-- size validations 
    IF :NEW.Product_Size IS NULL THEN
        RAISE NULL_Size_Error;
    END IF;

-- flavor validation  and replacement 
    IF :NEW.Product_Flavor IS NULL THEN
        :NEW.Product_Flavor := 'N/A';
    END IF;

--quantity Validations
    IF :NEW.Product_Quantity IS NULL THEN
            RAISE NULL_Quantity_Error;
    END IF;

  EXCEPTION
  WHEN Invalid_Name THEN
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: Product name cannot be null.', -20000);
        RAISE_APPLICATION_ERROR(-20000, 'Product name cannot be null.');

    WHEN NULL_Quantity_Error THEN
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: Quantity cannot be null.', -20001);
        
        RAISE_APPLICATION_ERROR(-20001, 'Invalid quantity. Quantity cannot be null.');

    WHEN Invalid_Price THEN  
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: Price cannot be negative (' || :NEW.Product_Price || ')', -20002);
        RAISE_APPLICATION_ERROR(-20002, 'Price cannot be negative: ' || :NEW.Product_Price);
        
    WHEN NULL_Price_Error THEN
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: NULL Price', -20003);
        RAISE_APPLICATION_ERROR(-20003, 'Product price cannot be null.');

    WHEN ZERO_Price_Error THEN
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: ZERO Price', -20004);

        RAISE_APPLICATION_ERROR(-20004, 'Product price cannot be zero.');

    WHEN NULL_Size_Error THEN
        log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: NULL Size', -20005);
        RAISE_APPLICATION_ERROR(-20005, 'Product size cannot be null.');

    WHEN OTHERS THEN
        log_activity('ERROR', 'Inventory', NULL, 'Unexpected error: ' || SQLERRM, SQLCODE);
        RAISE_APPLICATION_ERROR(-20999, 'Error in trg_inventory_insert: ' || SQLERRM);
END;
/