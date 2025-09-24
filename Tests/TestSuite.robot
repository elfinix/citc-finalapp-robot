*** Settings ***
Resource        ../Resources/App.resource
Resource        ../Resources/CustomerPage.resource

Suite Setup     Launch Browser    ${login_txt_username}


*** Variables ***
${BROWSER}      Chrome
${API_URL}      http://jsonplaceholder.typicode.com/users    ## simplify
${BASE_URL}     https://marmelab.com/react-admin-demo

${USERNAME}     demo
${PASSWORD}     demo

# // -------------------------------------------------- //#


*** Test Cases ***
TASK-001_2
    Login User
    Add Customers Five Times

TASK-003
    Update Customer Rows

# // -------------------------------------------------- //#


*** Keywords ***
Launch Browser
    [Arguments]    ${element_to_wait}
    Open Browser
    ...    ${BASE_URL}
    ...    ${BROWSER}
    # ...    options=add_argument("--start-maximized")
    ...    options=add_argument("--start-maximized");add_experimental_option("detach",True)

    Wait Until Keyword Succeeds    5x    .5s    Wait Until Element Is Visible    ${element_to_wait}

Login User
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}
    Input Text    ${login_txt_username}    ${username}
    Input Text    ${login_txt_password}    ${password}
    Click Button    ${login_btn_submit}
    Wait Until Element Is Visible    ${dashboard_hdr}    error=Dashboard header is not visible

Add Customers Five Times
    ${users}    Get Random Users
    FOR    ${user}    IN    @{users}[0:5]
        Go To Customers Page
        Input Customer Details    ${user}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save New Customer
        Verify Customer Is Added With Correct Details    ${user}
    END

Update Customer Rows
    ${users}    Get Random Users
    ${index}    Set Variable    0
    FOR    ${user}    IN    @{users}[5:10]
        Go To Customers Page
        Update Customer Details    ${user}    ${index}
        Verify Customer Name    ${user}
        Verify Customer Email    ${user}
        Verify Customer Details    ${user}
        Save Updated Customer
        Verify Customer Is Updated With Correct Details    ${user}    ${index}
        ${index}    Evaluate    ${index}+1
    END
