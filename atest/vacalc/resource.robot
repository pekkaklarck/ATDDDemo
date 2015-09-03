*** Settings ***
Library        SwingLibrary
Library        OperatingSystem
Library        VacalcLibrary

*** Variables ***
${DATABASE}    ${CURDIR}${/}test_db.txt
${TITLE}       Vacation Calculator

*** Keywords ***
Start Vacalc
    Set Environment Variable    VACALC_DB    ${DATABASE}
    Start Application    org.robotframework.vacalc.VacalcRunner
    Select Window    ${TITLE}

Close Vacalc
    Close Window    ${TITLE}

Start Vacalc with No Employees
    Clear Database
    Start Vacalc

Clear Database
    Remove File    ${DATABASE}

Add Employee
    [Arguments]    ${name}    ${date}
    Push Button    new_employee_button
    Type Into Text Field    name_input    ${name}
    Type Into Text Field    start_input    ${date}
    Push Button    save_button

Status Message Should Be
    [Arguments]    ${message}
    Label Text Should Be    status_label    ${message}

Employee Should Be Selected
    [Arguments]    ${name}
    ${selected item} =    Get Selected Value From List    employee_list
    Should Be Equal    ${name}    ${selected item}

Employee Should Exist In The Database
    [Arguments]    ${name}    ${date}
    ${db} =    Get File    ${DATABASE}    UTF-8
    Should Contain    ${db}    ${name},${date}
