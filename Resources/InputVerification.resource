*** Settings ***
Resource    ../Resources/App.resource


*** Keywords ***
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
    ${input_birthday_month}    Set Variable    """${input_birthday}"""[8:10]
    ${input_birthday_day}    Set Variable    """${input_birthday}"""[5:7]
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
