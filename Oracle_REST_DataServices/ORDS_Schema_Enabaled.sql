BEGIN 
    ORDS.ENABLE_SCHEMA(
        p_enabled => TRUE,      
        p_schema => 'Atif_Sarwar',
        p_url_mapping_type => 'BASE_PATH',
        p_url_mapping_pattern => 'atif_sarwar',
        p_auto_rest_auth => FALSE
    );

END;
/

BEGIN
  ORDS.ENABLE_OBJECT(
    p_enabled      => TRUE,
    p_schema       => 'ATIF_SARWAR',
    p_object       => 'INVENTORY',
    p_object_type  => 'TABLE',
    p_object_alias => 'inventory'
  );
  COMMIT;
END;
/


