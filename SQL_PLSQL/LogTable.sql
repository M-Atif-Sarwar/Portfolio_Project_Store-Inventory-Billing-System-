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