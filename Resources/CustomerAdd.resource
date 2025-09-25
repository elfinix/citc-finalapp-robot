*** Settings ***
Resource    App.resource
Resource    InputVerification.resource


*** Keywords ***
Add New Customer Details
    [Arguments]    ${user}
    Click Element    ${customers_btn_create}
    Wait Until Element Is Visible    ${customers_txt_firstname}
    Input Text    ${customers_txt_firstname}    ${user["formatted_name"].split(" ")[0]}
    Input Text    ${customers_txt_lastname}    ${user["formatted_name"].split(" ")[1]}
    Input Text    ${customers_txt_email}    ${user["email"]}
    Input Text    ${customers_txt_birthday}    ${user["birthday"]}
    Input Text    ${customers_txt_address}    ${user["address"]["street"]} ${user["address"]["suite"]}
    Input Text    ${customers_txt_city}    ${user["address"]["city"]}
    Input Text    ${customers_txt_stateAbbr}    ${user["address"]["stateAbbr"]}
    Input Text    ${customers_txt_zipcode}    ${user["address"]["zipcode"]}
    Input Text    ${customers_txt_password}    ${user["password"]}
    Input Text    ${customers_txt_confirm_password}    ${user["password"]}

Save New Customer
    Click Button    ${customers_btn_save}
    Wait Until Page Contains    Customer created

Verify Customer Is Added
    [Arguments]    ${user}
    Go To Customers Page
    Refresh Current Page
    Page Should Contain Element
    ...    ${table_row}[1]/td[2]/a/div[contains(text(), '${user["formatted_name"].split(" ")[0]}')]

View Newest Customer Details
    Click Element    ${table_row}[1]/td[2]
    Wait Until Element Is Visible    ${customers_txt_firstname}

Verify Customer Is Added With Correct Details
    [Arguments]    ${user}
    Go To Customers Page
    Refresh Current Page

    ${fetched_name}    Get Text    ((${table_row })[1]//td)[2]
    IF    "\\n" in """${fetched_name}"""
        ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n", "")[1:]
    END
    Should Be Equal As Strings    ${user["formatted_name"]}    ${fetched_name}
