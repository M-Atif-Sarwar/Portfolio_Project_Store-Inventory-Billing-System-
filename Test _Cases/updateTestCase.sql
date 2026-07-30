SELECT * FROM inventory;

--updating flovor and size of the item with id 1
DECLARE
  v_item pkg_inventory.inventory_item_update_record;
  v_message VARCHAR2(200);
BEGIN
  v_item.product_id   := 1;
  v_item.product_name := 'Coca Cola';
  v_item.flavor       := 'Cherry';
  v_item.Product_size := '600ml';
  v_item.quantity     := 100;
  v_item.price        := 1.75;

  pkg_inventory.inventory_item_update(v_item, v_message);

  DBMS_OUTPUT.PUT_LINE(v_message);
END;
/