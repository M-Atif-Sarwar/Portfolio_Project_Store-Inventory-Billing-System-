SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE pkg_inventory AS
     TYPE inventory_item IS RECORD (
         product_name VARCHAR2(100),
         flavor VARCHAR2(100),
         Product_size VARCHAR2(50),
         quantity NUMBER,
         price NUMBER(10,2)
     );

     TYPE inventory_list IS TABLE OF inventory_item INDEX BY PLS_INTEGER;


    PROCEDURE insert_inventory_item(p_items IN inventory_list);

    --procedure to get data from json file and insert into inventory table
    -- PROCEDURE get_data_from_json_and_insert(p_json IN CLOB,status OUT VARCHAR2);

    PROCEDURE invertory_item_DELETE(item_id IN inventory.Product_ID%TYPE ,message OUT VARCHAR2);

   
END pkg_inventory;
/


CREATE OR REPLACE PACKAGE BODY pkg_inventory AS

    PROCEDURE insert_inventory_item(p_items IN inventory_list) IS
    BEGIN
        -- Using FORALL to insert multiple records into the inventory table
      FORALL i IN p_items.FIRST .. p_items.LAST
        INSERT INTO inventory (Product_Name, Product_Flavor, Product_Size, Product_Quantity, Product_Price)
            VALUES 
        (p_items(i).product_name, p_items(i).flavor, p_items(i).Product_size, p_items(i).quantity, p_items(i).price);

        commit;
        log_activity('INSERT', 'Inventory', NULL, 'Inserted inventory item: ' ,NULL);

    EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error inserting inventory item: ' || SQLERRM || SQLCODE);

          -- sql errm returns the error message and sqlcode returns the error code

          log_activity('ERROR', 'Inventory', NULL, 'Error inserting inventory item: ' || SQLERRM, SQLCODE);
           
    END insert_inventory_item;



-- delete procedure to delete inventory item based on item_id
    PROCEDURE invertory_item_DELETE(item_id IN inventory.Product_ID%TYPE ,message OUT VARCHAR2) IS
    BEGIN
        DELETE FROM inventory WHERE Product_ID = item_id;

        IF SQL%ROWCOUNT = 0 THEN
            message := 'No inventory item found with ID: ' || item_id;
            log_activity('ERROR', 'Inventory', NULL, 'No inventory item found with ID: ' || item_id, NULL);
            RETURN ;
        END IF;

        COMMIT;

        message := 'Inventory item deleted successfully.';

        log_activity('DELETE', 'Inventory', NULL, 'Deleted inventory item with ID: ' || item_id, NULL);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            message := 'Error deleting inventory item: ' || SQLERRM;

            log_activity('ERROR', 'Inventory', NULL, 'Error deleting inventory item with ID: ' || item_id || '. Error: ' || SQLERRM, SQLCODE);

    END invertory_item_DELETE;

END pkg_inventory;
/


-- testing of insert procedure
DECLARE 
v_items pkg_inventory.inventory_list;
BEGIN 
    
    v_items(1).product_name := 'Coca Cola';
    v_items(1).flavor := 'Classic';
    v_items(1).Product_size := '500ml';
    v_items(1).quantity := 100;
    v_items(1).price := 1.50;
    
-- inserting second itwm into the collection of records
    v_items(2).product_name := 'Pepsi';
    v_items(2).flavor := 'Diet';
    v_items(2).Product_size := '330ml';
    v_items(2).quantity := 200;
    v_items(2).price := 1.20;

    pkg_inventory.insert_inventory_item(v_items);
END;
/

SELECT * FROM inventory;
