*** Settings ***
Resource    App.resource


*** Keywords ***
Update Customer Details
    [Arguments]    ${user}    ${index}
    Click Element    //table//tbody//tr[${6+${index}}]//td[2]
    Wait Until Element Is Visible    ${customers_txt_firstname}

    Press Keys    ${customers_txt_firstname}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_firstname}    ${user["formatted_name"].split(" ")[0]}

    Press Keys    ${customers_txt_lastname}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_lastname}    ${user["formatted_name"].split(" ")[1]}

    Press Keys    ${customers_txt_email}    CTRL+a    BACKSPACE
    Press Keys    ${customers_txt_email}    TAB    BACKSPACE
    Input Text    ${customers_txt_email}    ${user["email"]}

    Press Keys    ${customers_txt_birthday}    BACKSPACE    TAB    BACKSPACE    TAB    BACKSPACE
    Input Text    ${customers_txt_birthday}    ${user["birthday"]}

    Press Keys    ${customers_txt_address}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_address}    ${user["address"]["street"]} ${user["address"]["suite"]}

    Press Keys    ${customers_txt_city}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_city}    ${user["address"]["city"]}

    Press Keys    ${customers_txt_stateAbbr}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_stateAbbr}    ${user["address"]["stateAbbr"]}

    Press Keys    ${customers_txt_zipcode}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_zipcode}    ${user["address"]["zipcode"]}

    Press Keys    ${customers_txt_password}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_password}    ${user["password"]}

    Press Keys    ${customers_txt_confirm_password}    CTRL+a    BACKSPACE
    Input Text    ${customers_txt_confirm_password}    ${user["password"]}

Save Updated Customer
    Click Button    ${customers_btn_save}
    Wait Until Page Contains    Customer updated

Verify Customer Is Updated With Correct Details
    [Arguments]    ${user}    ${index}
    Go To Customers Page
    Refresh Current Page

    ${fetched_name}    Get Text    ((${table_row})[${6+${index}}]//td)[2]
    IF    "\\n" in """${fetched_name}"""
        ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n", "")[1:]
    END
    Should Be Equal As Strings    ${user["formatted_name"]}    ${fetched_name}
