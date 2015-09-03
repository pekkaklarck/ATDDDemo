*** Settings ***
Force Tags       Regression    Sprint-1
Resource         resource.robot
Test Teardown    Close Vacalc

*** Test Cases ***
Adding employee
    Given no employee "Juha" exists in the system
    When "Juha" with start date 2010-01-01 is added
    Then message "Employee 'Juha' was added successfully." is shown
    and "Juha" exists in the employee listing
    and "Juha" with start date 2010-01-01 exists in the database

Adding employee with same name
    Given employee "Juha" with start date 2010-01-01 exists in the system
    When "Juha" with start date 2010-02-02 is added
    Then message "Employee 'Juha' already exists in the system." is shown
    and "Juha" with start date 2010-01-01 exists in the database

Adding two employees
    Given no employee exists in the system
    When "Pekka" with start date 2010-01-01 is added
    and "Janne" with start date 2010-01-01 is added
    Then "Janne" exists in the employee listing
    and "Janne" with start date 2010-01-01 exists in the database

Employee list is sorted alphabetically
    Given no employee exists in the system
    When "ZZZ" with start date 2010-01-01 is added
    and "DDD" with start date 2010-01-01 is added
    and "AAA" with start date 2010-01-01 is added
    and "CCC" with start date 2010-01-01 is added
    Then "AAA, CCC, DDD, ZZZ" is the order of the list


*** Keywords ***
No employee "${name}" exists in the system
    Start Vacalc with no employees

"${name}" with start date ${date} is added
    Add employee    ${name}    ${date}

Message "${message}" is shown
    Status message should be    ${message}

"${names}" is the order of the list
    Application should have employees    ${names}

"${name}" exists in the employee listing
    Employee should be selected    ${name}

"${name}" with start date ${date} exists in the database
    Employee should exist in the database    ${name}    ${date}

No employee exists in the system
    Start Vacalc with no employees

Employee "${name}" with start date ${date} exists in the system
    Start Vacalc with no employees
    Add employee    ${name}    ${date}
