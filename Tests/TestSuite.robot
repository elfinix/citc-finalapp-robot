*** Settings ***
Resource        ../Resources/App.resource
Resource        ../Resources/CustomerAdd.resource
Resource        ../Resources/CustomerUpdate.resource
Resource        ../Resources/ConsoleDisplay.resource
Resource        ../Resources/InputVerification.resource
Resource        ../Resources/Setup.resource

Suite Setup     Global Suite Setup
# // -------------------------------------------------- //#


*** Test Cases ***
TASK-001_2 | Add Five Customers
    [Documentation]    Add five customers using data from the API (first five users) and verify their details are correct.
    Add Customers Five Times

TASK-003 | Update Multiple Customer Rows
    [Documentation]    Update five existing customers (rows 6-10) using data from the API (users 6-10)
    Update Multiple Customer Rows

TASK-004 | Display Customer Information
    [Documentation]    Display all available customer information of the current page in the console.
    Go To Customers Page
    Display Available Customers Info

TASK-005 | Analyze User Spending
    # 1. Display user spending
    # - Check all user's total spent amount
    # - For users with total spent > 0, display them

    Go To Customers Page
    ${user_count}    Get Element Count    ${table_row}
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

    # 2. Calculate total spending of all users
    ${total_spent}    Set Variable    0
    FOR    ${index}    IN RANGE    1    ${user_count}+1
        Get Customer Total Spent    ${index}
        ${tb_total_spent}    Get Text    ((${table_row })[${index}]//td)[5]/span
        ${amount}    Evaluate    float(${tb_total_spent.replace("$", "").replace(",", "")})
        ${total_spent}    Evaluate    ${total_spent} + ${amount}
    END
    ${total_spent_display}    Catenate    SEPARATOR=\n
    ...    =========================================
    ...    Total Customer Spending: $${total_spent}
    ...    =========================================
    Log To Console    \n${total_spent_display}\n

    # 3. Validate Total Spending
    # - if total spending < $3,500:
    #    - DISPLAY: "FAIL: Total spending ($X) is below the minimum threshold ($3,500)."
    #    - fail test execution
    # - else:
    #    - DISPLAY: "PASS: Total spending ($X) meets the minimum threshold ($3,500)."
    #    - continue test execution

    IF    ${total_spent} < 3500
        ${message}    Catenate    SEPARATOR=\n
        ...    FAIL: Total spending ($${total_spent}) is below the minimum threshold ($3,500).
        Log To Console    \n${message}\n
        Fail    ${message}
    ELSE
        ${message}    Catenate    SEPARATOR=\n
        ...    PASS: Total spending ($${total_spent}) meets the minimum threshold ($3,500).
        Log To Console    \n${message}\n
    END

# // -------------------------------------------------- //#


*** Keywords ***
Add Customers Five Times
    Go To Customers Page
    FOR    ${index}    ${user}    IN ENUMERATE    @{USERS}[0:5]
        Add New Customer Details    ${user}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save New Customer
        Verify Customer Is Added With Correct Details    ${user}
    END

Update Multiple Customer Rows
    Go To Customers Page
    FOR    ${index}    ${user}    IN ENUMERATE    @{USERS}[5:10]
        Update Customer Details    ${user}    ${index}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save Updated Customer
        Verify Customer Is Updated With Correct Details    ${user}    ${index}
    END
