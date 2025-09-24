*** Settings ***
Resource        ../Resources/App.resource
Resource        ../Resources/CustomerAdd.resource
Resource        ../Resources/CustomerUpdate.resource
Resource        ../Resources/ConsoleDisplay.resource
Resource        ../Resources/Setup.resource

Suite Setup     Global Suite Setup


*** Variables ***
${USERNAME}     demo
${PASSWORD}     demo

# // -------------------------------------------------- //#


*** Test Cases ***
TASK-001_2
    Add Customers Five Times

TASK-003
    Update Multiple Customer Rows

TASK-004
    Go To Customers Page
    Display Available Customers Info

# // -------------------------------------------------- //#


*** Keywords ***
Add Customers Five Times
    ${users}    Get Random Users
    Go To Customers Page
    FOR    ${user}    IN    @{users}[0:5]
        Input Customer Details    ${user}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save New Customer
        Verify Customer Is Added With Correct Details    ${user}
    END

Update Multiple Customer Rows
    ${users}    Get Random Users
    ${index}    Set Variable    0
    Go To Customers Page
    FOR    ${user}    IN    @{users}[5:10]
        Update Customer Details    ${user}    ${index}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save Updated Customer
        Verify Customer Is Updated With Correct Details    ${user}    ${index}
        ${index}    Evaluate    ${index}+1
    END
