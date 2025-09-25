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
        ${total_spent}    Evaluate    round(${total_spent}, 2)
    END
    RETURN    ${total_spent}

Validate Total Spending Threshold
    [Arguments]    ${total_spent}    ${threshold}=3500
    ${is_valid}    Run Keyword And Return Status    Should Be True    ${total_spent} >= ${threshold}
    ${status}    Set Variable If    ${is_valid}    PASS    FAIL
    ${message}    Set Variable If    ${is_valid}
    ...    PASS: Total spending ($${total_spent}) meets the minimum threshold ($${threshold}).
    ...    FAIL: Total spending ($${total_spent}) is below the minimum threshold ($${threshold}).
    IF    not ${is_valid}    Fail    ${message}
    RETURN    ${message}
