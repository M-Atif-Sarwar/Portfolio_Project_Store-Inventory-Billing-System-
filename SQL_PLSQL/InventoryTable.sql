CREATE TABLE inventory(
    Product_ID number GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Product_Name varchar2(50) NOT NULL,
    ProducT_Flavor varchar2(50),
    Product_Size varchar2(50) NOT NULL,
    Product_Price number(10,2) NOT NULL,
    Product_Quantity number NOT NULL
                          
);

COMMIT;