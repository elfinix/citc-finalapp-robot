# Citco FinalApp Robot Framework Test Suite

## Overview

This repository contains an automated test suite for the Citco FinalApp application, built using the Robot Framework. The test suite leverages SeleniumLibrary for browser automation and Python for backend logic, ensuring robust and scalable test automation.

---

## Project Structure

### Folder Structure

```
Library/
    DataRetrieval.py       # Python library for data retrieval and randomization
Resources/
    App.resource           # Central resource file for shared keywords and imports
    Setup.resource         # Suite setup and initialization
    CustomerAdd.resource   # Keywords for adding customers
    CustomerUpdate.resource# Keywords for updating customer details
    CustomerMultipleActions.resource # Keywords for bulk customer operations
    ConsoleDisplay.resource# Keywords for console output
    InputVerification.resource # Keywords for input validation
    TableDataRetrieval.resource # Keywords for retrieving table data
    TableDataOperations.resource # Keywords for table data operations
Tests/
    TestSuite.robot        # Main test suite file
Variables/
    login_variables.py     # Locators for login page
    page_variables.py      # Locators for application pages
Results/
    log.html               # Execution log
    report.html            # Execution report
    output.xml             # Execution output
```

---

## Key Features

-   **Dynamic Data Retrieval**: Fetches user data from an API using `DataRetrieval.py`.
-   **Modular Design**: Keywords are organized into resource files for reusability.
-   **Platform-Specific Logic**: Handles OS-specific scenarios for date parsing and other operations.
-   **Validation and Verification**: Includes robust validation steps for user data and application state.
-   **Scalable Test Cases**: Supports bulk operations like adding and updating multiple customers.

---

## Prerequisites

1. **Python**: Ensure Python 3.8+ is installed.
2. **Robot Framework**: Install Robot Framework using pip:
    ```bash
    pip install robotframework
    ```
3. **SeleniumLibrary**: Install SeleniumLibrary:
    ```bash
    pip install robotframework-seleniumlibrary
    ```
4. **Browser Drivers**: Ensure the appropriate browser driver (e.g., ChromeDriver) is installed and added to the PATH.

---

## Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/elfinix/citc-finalapp-robot.git
    ```
2. Navigate to the project directory:
    ```bash
    cd citc-finalapp-robot
    ```
3. Install dependencies:
    ```bash
    pip install requests
    ```

---

## Running Tests

1. Execute the test suite:
    ```bash
    robot -d ./Results ./Tests/TestSuite.robot
    ```
2. View the results:
    - **Log**: `Results/log.html`
    - **Report**: `Results/report.html`

---

## Key Test Cases

-   **TASK-001_2 | Add Five Customers**: Adds five customers using API data and verifies their details.
-   **TASK-003 | Update Multiple Customer Rows**: Updates details for five existing customers.
-   **TASK-004 | Display Customer Information**: Displays all customer information on the console.
-   **TASK-005 | Analyze User Spending**: Analyzes user spending and validates against a threshold.

---

## Contact

For any questions or issues, please contact the repository owner at [elfinix](https://github.com/elfinix).
