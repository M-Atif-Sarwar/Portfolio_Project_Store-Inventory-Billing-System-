BEGIN 

ORDS.DEFINE_MODULE(
    p_module_name    => 'inventory_api',
    p_base_path      => '/inventory_api/'
);

ORDS.DEFINE_TEMPLATE(
    p_module_name    => 'inventory_api',
    p_pattern        => 'delete_item'
);

-- end point for deleting an item from the inventory

ORDS.DEFINE_HANDLER(
    p_module_name    => 'inventory_api',
    p_pattern        => 'delete_item',
    p_method         => 'POST',
    p_source_type    => ORDS.source_type_plsql,
    p_source         => 'BEGIN
                            pkg_inventory.invertory_item_DELETE(:item_id, :message);
                            COMMIT;
                          END;'
);


--response parameter for the delete_item endpoint
ORDS.DEFINE_PARAMETER(
    p_module_name        => 'inventory_api',
    p_pattern            => 'delete_item',
    p_method             => 'POST',
    p_name               => 'message',
    p_bind_variable_name => 'message',
    p_source_type        => 'RESPONSE',
    p_param_type         => 'STRING',
    p_access_method      => 'OUT'
);

commit;
END;
/





-- SELECT name, uri_prefix
-- FROM user_ords_modules;

-- SELECT module_name,
--        uri_template
-- FROM user_ords_templates;


-- SELECT ords.installed_version FROM dual;



-- SELECT * FROM USER_ORDS_MODULES;
-- SELECT * FROM USER_ORDS_TEMPLATES;
-- SELECT * FROM USER_ORDS_HANDLERS;


-- SELECT *
-- FROM USER_ORDS_SCHEMAS;



-- SELECT SYS_CONTEXT('USERENV', 'SERVICE_NAME') AS service_name,
--        SYS_CONTEXT('USERENV', 'CON_NAME') AS pdb_name
-- FROM dual;



-- SELECT column_name 
-- FROM user_tab_columns 
-- WHERE table_name = 'USER_ORDS_SCHEMAS';


-- SELECT * FROM user_ords_schemas;

-- SELECT * FROM user_ords_privileges;


-- SELECT * FROM user_ords_privilege_mappings;     


-- SELECT name, uri_prefix, parsing_schema 
-- FROM user_ords_modules 
-- WHERE name = 'inventory_api';




-- SELECT p.name, p.bind_variable_name, p.access_method, p.param_type
-- FROM user_ords_parameters p
-- JOIN user_ords_templates t ON p.template_id = t.id
-- WHERE t.uri_template = 'delete_item';



-- SELECT * FROM user_ords_parameters;