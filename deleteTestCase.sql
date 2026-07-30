SELECT * FROM inventory;

SELECT * FROM activity_log;

DECLARE 
BEGIN 
    pkg_inventory.invertory_item_DELETE(2, :message);

    DBMS_OUTPUT.PUT_LINE(:message);
END;
/

-- GIBING id that does not exist in the inventory table
DECLARE 
BEGIN 
    pkg_inventory.invertory_item_DELETE(54, :message);

    DBMS_OUTPUT.PUT_LINE(:message);
END;
/

--giving random text instead of number as id
DECLARE 
BEGIN 
    pkg_inventory.invertory_item_DELETE('random_text', :message);

    DBMS_OUTPUT.PUT_LINE(:message);
END;
/