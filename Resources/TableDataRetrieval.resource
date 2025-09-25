*** Settings ***
Resource    App.resource


*** Keywords ***
Get Customer Name
    [Arguments]    ${index}
    ${tb_name}    Get Text    ((${table_row })[${index}]//td)[2]
    IF    "\\n" in """${tb_name}"""
        ${tb_name}    Evaluate    """${tb_name}""".replace("\\n", "")[1:]
    END
    RETURN    ${tb_name}

Get Customer Last Seen
    [Arguments]    ${index}
    ${tb_last_seen}    Get Text    ((${table_row })[${index}]//td)[3]/span
    RETURN    ${tb_last_seen}

Get Customer Orders
    [Arguments]    ${index}
    ${tb_orders}    Get Text    ((${table_row })[${index}]//td)[4]/span
    RETURN    ${tb_orders}

Get Customer Total Spent
    [Arguments]    ${index}
    ${tb_total_spent}    Get Text    ((${table_row })[${index}]//td)[5]/span
    RETURN    ${tb_total_spent}

Get Customer Latest Purchase
    [Arguments]    ${index}
    ${latest_purchase_result}    Run Keyword And Ignore Error    Get Text    ((${table_row})[${index}]//td)[6]/span
    ${tb_latest_purchase}    Set Variable If
    ...    '${latest_purchase_result[0]}' == 'PASS'
    ...    ${latest_purchase_result[1]}
    ...    (None recorded)
    RETURN    ${tb_latest_purchase}

Get Customer Subscribed
    [Arguments]    ${index}
    ${tb_news}    Get Element Attribute    ((${table_row })[${index}]//td)[7]//*[name()='svg']    data-testid
    ${tb_subscribed}    Set Variable If    '${tb_news}' == 'true'    Subscribed [✅]    Not Subscribed [❌]
    RETURN    ${tb_subscribed}

Get Customer Segments
    [Arguments]    ${index}
    ${segment_count}    Get Element Count    ((${table_row })[${index}]//td)[8]/div/div
    ${segment_names}    Create List
    FOR    ${seg_index}    IN RANGE    1    ${segment_count}+1
        ${seg_name}    Get Text    ((${table_row })[${index}]//td)[8]/div/div[${seg_index}]/span
        Append To List    ${segment_names}    ${seg_name}
    END
    RETURN    ${segment_names}

Get Number Of Current Table Rows
    ${user_count}    Get Element Count    ${table_row}
    RETURN    ${user_count}
