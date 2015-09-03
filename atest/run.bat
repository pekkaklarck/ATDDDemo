@echo off

set ROOT=%~dp0..
set BIN=%ROOT%\bin
set SRC=%ROOT%\src
set TESTS=%ROOT%\atest\vacalc
set LIBS=%ROOT%\atest\libraries
set CLASSPATH=%BIN%\robotframework-2.9.1.jar;%BIN%;%LIBS%\swinglibrary-1.9.4.jar
java org.robotframework.RobotFramework -P "%SRC%" -P "%LIBS%" --outputdir "%ROOT%\results" --critical regression %* "%TESTS%"
