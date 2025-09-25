*** Settings ***
Resource    App.resource
Resource    TableDataRetrieval.resource


*** Keywords ***
Calculate Total Spending Of All Users
    ${total_spent}    Set Variable    0
    ${user_count}    Get Number Of Current Table Rows
    FOR    ${index}    IN RANGE    1    ${user_count}+1
        Get Customer Total Spent    ${index}
        ${tb_total_spent}    Get Text    ((${table_row })[${index}]//td)[5]/span
        ${amount}    Evaluate    float(${tb_total_spent.replace("$", "").replace(",", "")})
        ${total_spent}    Evaluate    ${total_spent} + ${amount}
    END
    RETURN    ${total_spent}
