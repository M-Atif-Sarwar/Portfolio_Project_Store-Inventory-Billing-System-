CREATE TABLE activity_log(
    Log_ID number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Log_Type varchar2(50) NOT NULL,
    Log_ModuleName varchar2(100),
    LOg_UserName varchar2(100) DEFAULT USER NOT NULL,
    Log_ReferenceID number,
    Log_Message varchar2(500) NOT NULL,
    Log_ErrorCode number,
    Log_Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

COMMIT;


CREATE OR REPLACE PROCEDURE log_activity(
    p_log_type IN VARCHAR2,
    p_log_module_name IN VARCHAR2,
    p_log_reference_id IN NUMBER,
    p_log_message IN VARCHAR2,
    p_log_error_code IN NUMBER
) AS

PRAGMA AUTONOMOUS_TRANSACTION;

BEGIN

    INSERT INTO activity_log (
        Log_Type,
        Log_ModuleName,
        Log_ReferenceID,
        Log_Message,
        Log_ErrorCode
    ) VALUES (
        p_log_type,
        p_log_module_name,
        p_log_reference_id,
        p_log_message,
        p_log_error_code
    );
    
    COMMIT;
    
END log_activity;