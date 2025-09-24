*** Settings ***
Library     SeleniumLibrary
Resource    App.resource


*** Keywords ***
Go To Customers Page
    Click Element    ${nav_btn_customers}
    Wait Until Element Is Visible    //table//tbody//tr

Input Customer Details
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

Verify Customer Name
    [Arguments]    ${user}
    ${input_first_name}    Get Element Attribute    ${customers_txt_firstname}    value
    ${input_last_name}    Get Element Attribute    ${customers_txt_lastname}    value
    ${input_name}    Set Variable    ${input_first_name} ${input_last_name}
    Should Be Equal As Strings    ${input_name}    ${user["formatted_name"]}

Verify Customer Email
    [Arguments]    ${user}
    ${input_email}    Get Element Attribute    ${customers_txt_email}    value
    Should Be Equal As Strings    ${input_email}    ${user["email"]}

Verify Customer Details
    [Arguments]    ${user}
    ${input_birthday}    Get Element Attribute    ${customers_txt_birthday}    value
    ${input_birthday_month}    Set Variable    """${input_birthday}"""[5:7]
    ${input_birthday_day}    Set Variable    """${input_birthday}"""[8:10]
    ${input_birthday_year}    Set Variable    """${input_birthday}"""[0:4]
    ${input_birthday}    Evaluate    f"{${input_birthday_month}}{${input_birthday_day}}{${input_birthday_year}}"

    ${input_address}    Get Element Attribute    ${customers_txt_address}    value
    ${input_city}    Get Element Attribute    ${customers_txt_city}    value
    ${input_stateAbbr}    Get Element Attribute    ${customers_txt_stateAbbr}    value
    ${input_zipcode}    Get Element Attribute    ${customers_txt_zipcode}    value
    ${input_password}    Get Element Attribute    ${customers_txt_password}    value
    ${input_confirm_password}    Get Element Attribute    ${customers_txt_confirm_password}    value

    Should Be Equal As Strings    ${input_birthday}    ${user["birthday"]}
    Should Be Equal As Strings    ${input_address}    ${user["address"]["street"]} ${user["address"]["suite"]}
    Should Be Equal As Strings    ${input_city}    ${user["address"]["city"]}
    Should Be Equal As Strings    ${input_stateAbbr}    ${user["address"]["stateAbbr"]}
    Should Be Equal As Strings    ${input_zipcode}    ${user["address"]["zipcode"]}
    Should Be Equal As Strings    ${input_password}    ${user["password"]}
    Should Be Equal As Strings    ${input_confirm_password}    ${user["password"]}

Save New Customer
    Click Button    ${customers_btn_save}
    Wait Until Page Contains    Customer created

Verify Customer Is Added With Correct Details
    [Arguments]    ${user}
    Go To Customers Page
    Refresh Current Page

    ${fetched_name}    Get Text    ((${table_row })[1]//td)[2]
    IF    "\\n" in """${fetched_name}"""
        ${fetched_name}    Evaluate    """${fetched_name}""".replace("\\n", "")[1:]
    END
    Should Be Equal As Strings    ${user["formatted_name"]}    ${fetched_name}

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
