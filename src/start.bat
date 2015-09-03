@echo off

set ROOT=%~dp0..
set SRC=%ROOT%\src
set BIN=%ROOT%\bin
set RF=%BIN%\robotframework-2.9.1.jar
java -cp "%RF%;%BIN%" -Dpython.path="%SRC%" org.robotframework.vacalc.VacalcRunner
