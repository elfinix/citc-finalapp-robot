*** Settings ***
Resource    ../Resources/App.resource


*** Variables ***
${BROWSER}      Chrome
${API_URL}      http://jsonplaceholder.typicode.com/users
${BASE_URL}     https://marmelab.com/react-admin-demo

${USERNAME}     demo
${PASSWORD}     demo


*** Keywords ***
Global Suite Setup
    Launch Browser    ${login_txt_username}
    Login User

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
