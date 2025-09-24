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
