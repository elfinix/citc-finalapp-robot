*** Settings ***
Resource    App.resource
Resource    CustomerAdd.resource
Resource    CustomerUpdate.resource
Resource    CustomerMultipleActions.resource


*** Keywords ***
Add Customers Five Times
    ${users}    Retrieve Test Data
    Go To Customers Page
    FOR    ${index}    ${user}    IN ENUMERATE    @{users}[0:5]
        Add New Customer Details    ${user}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save New Customer
        Verify Customer Is Added With Correct Details    ${user}
    END

Update Multiple Customer Rows
    ${users}    Retrieve Test Data
    Go To Customers Page
    FOR    ${index}    ${user}    IN ENUMERATE    @{USERS}[5:10]
        Update Customer Details    ${user}    ${index}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save Updated Customer
        Verify Customer Is Updated With Correct Details    ${user}    ${index}
    END

Retrieve Test Data
    ${users}    Get Random Users
    RETURN    ${users}
