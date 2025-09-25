*** Settings ***
Resource    App.resource
Resource    TableDataRetrieval.resource
Resource    TableDataOperations.resource


*** Keywords ***
Display Available Customers Info
    ${user_count}    Get Number Of Current Table Rows
    FOR    ${index}    IN RANGE    1    ${user_count}+1
        Display Single Customer Info    ${index}
    END

Display Single Customer Info
    [Arguments]    ${index}
    ${tb_name}    Get Customer Name    ${index}
    ${tb_last_seen}    Get Customer Last Seen    ${index}
    ${tb_orders}    Get Customer Orders    ${index}
    ${tb_total_spent}    Get Customer Total Spent    ${index}
    ${tb_latest_purchase}    Get Customer Latest Purchase    ${index}
    ${tb_subscribed}    Get Customer Subscribed    ${index}
    ${segment_names}    Get Customer Segments    ${index}
    ${user_info}    Catenate    SEPARATOR=\n
    ...    ====== User ${index} ======
    ...    Name: ${tb_name}
    ...    Last seen: ${tb_last_seen}
    ...    Orders: ${tb_orders}
    ...    Total spent: ${tb_total_spent}
    ...    Latest purchase: ${tb_latest_purchase}
    ...    Subscribed: ${tb_subscribed}
    ...    Segments: ${segment_names}
    Log To Console    \n${user_info}\n

Display User Spending
    ${user_count}    Get Number Of Current Table Rows
    Log To Console    \n----- Users with Spending -----
    FOR    ${index}    IN RANGE    1    ${user_count}+1
        Get Customer Name    ${index}
        ${tb_name}    Get Text    ((${table_row })[${index}]//td)[2]
        IF    "\\n" in """${tb_name}"""
            ${tb_name}    Evaluate    """${tb_name}""".replace("\\n", "")[1:]
        END
        Get Customer Total Spent    ${index}
        ${tb_total_spent}    Get Text    ((${table_row })[${index}]//td)[5]/span
        IF    "${tb_total_spent}" != "$0.00"
            Log To Console    ${tb_name}: ${tb_total_spent}
        END
    END

Display Total Spending
    [Arguments]    ${total_spent}
    ${total_spent_display}    Catenate    SEPARATOR=\n
    ...    =========================================
    ...    Total Customer Spending: $${total_spent}
    ...    =========================================
    Log To Console    \n${total_spent_display}\n

Validate Total Spending Threshold
    [Arguments]    ${total_spent}    ${threshold}=3500
    ${is_valid}    Run Keyword And Return Status    Should Be True    ${total_spent} >= ${threshold}
    ${status}    Set Variable If    ${is_valid}    PASS    FAIL
    ${message}    Set Variable If    ${is_valid}
    ...    PASS: Total spending ($${total_spent}) meets the minimum threshold ($${threshold}).
    ...    FAIL: Total spending ($${total_spent}) is below the minimum threshold ($${threshold}).
    IF    not ${is_valid}    Fail    ${message}
    RETURN    ${message}

Display Total Spending Validation Message
    [Arguments]    ${message}
    Log To Console    \n${message}\n
