*** Settings ***
Force Tags       Sprint-1    Regression
Resource         resource.robot
Test Template    Validate valid name


*** Variables ***
${DATE}          2010-04-01


*** Test Cases ***
Valid name
    Hans Martin Schulz
    Hans-Martin Schulz
    Hans Schulz jr.
    Hans Schulz III.

Non-ASCII names
    Dikmen Çankığır
    Yrjö Hämäläinen

Empty name is not allowed
    [Template]    Validate name
    ${EMPTY}    No name given.


*** Keywords ***
Validate valid name
    [Arguments]    ${name}
    Validate name    ${name}    Employee '${name}' was added successfully.
    Employee should exist in the database    ${name}    ${DATE}

Validate name
    [Arguments]    ${name}    ${message}
    Start Vacalc with no employees
    Add employee    ${name}    ${DATE}
    Status message should be    ${message}
    [Teardown]    Close Vacalc
