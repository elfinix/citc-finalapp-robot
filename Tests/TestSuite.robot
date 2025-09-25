*** Settings ***
Resource        ../Resources/App.resource
Resource        ../Resources/CustomerAdd.resource
Resource        ../Resources/CustomerUpdate.resource
Resource        ../Resources/ConsoleDisplay.resource
Resource        ../Resources/InputVerification.resource
Resource        ../Resources/TableDataRetrieval.resource
Resource        ../Resources/Setup.resource

Suite Setup     Global Suite Setup
# // -------------------------------------------------- //#


*** Test Cases ***
TASK-001_2 | Add Five Customers
    [Documentation]    Add five customers using data from the API (first five users) and verify their details are correct.
    Add Customers Five Times    ${USERS}

TASK-003 | Update Multiple Customer Rows
    [Documentation]    Update five existing customers (rows 6-10) using data from the API (users 6-10)
    Update Multiple Customer Rows    ${USERS}

TASK-004 | Display Customer Information
    [Documentation]    Display all available customer information of the current page in the console.
    Go To Customers Page
    Display Available Customers Info

TASK-005 | Analyze User Spending
    [Documentation]    Analyze user spending, validate against the threshold, and display the results.
    Go To Customers Page
    Display User Spending
    ${total_spent}    Calculate Total Spending Of All Users
    Display Total Spending    ${total_spent}
    ${spending_message}    Validate Total Spending Threshold    ${total_spent}
    Display Total Spending Validation Message    ${spending_message}

# // -------------------------------------------------- //#
