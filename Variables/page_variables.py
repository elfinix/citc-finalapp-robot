'''
Locators for Main Application Pages
'''
dashboard_hdr = '//p[text()="Dashboard"]'
nav_btn_customers = '(//p[text()="Customers"])[2]'

'''
Locators for Customers Page
'''
customers_btn_create = '//a[@aria-label="Create"]'
customers_txt_firstname = '//input[@name="first_name"]'
customers_txt_lastname = '//input[@name="last_name"]'
customers_txt_email = '//input[@name="email"]'
customers_txt_birthday = '//input[@name="birthday"]'
customers_txt_address = '//textarea[@name="address"]'
customers_txt_city = '//input[@name="city"]'
customers_txt_stateAbbr = '//input[@name="stateAbbr"]'
customers_txt_zipcode = '//input[@name="zipcode"]'
customers_txt_password = '//input[@name="password"]'
customers_txt_confirm_password = '//input[@name="confirm_password"]'

'''
Locators for Common Elements
'''
customers_btn_save = '//button[@aria-label="Save"]'
table_row = '//table//tbody//tr'
btn_refresh = '//button[@aria-label="Refresh"]'
loading_icon = '//div[span[contains(@class, "MuiCircularProgress-root")]]'