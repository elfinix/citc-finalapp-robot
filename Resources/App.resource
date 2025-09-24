*** Settings ***
Library         SeleniumLibrary
Library         Collections
Library         ../Library/DataRetrieval.py
Variables       ../Variables/login_variables.py
Variables       ../Variables/page_variables.py


*** Keywords ***
Refresh Current Page
    Click Button    ${btn_refresh}
    Wait Until Element Is Visible    ${loading_icon}
    Wait Until Element Is Not Visible    ${loading_icon}

Go To Customers Page
    Click Element    ${nav_btn_customers}
    Wait Until Element Is Visible    ${table_row}
