@echo off&setlocal
REM
REM Wait_Port_Opened.bat <port_number> <process_name>
REM

REM Port we need to be listening
set portToWait=%1
REM Application we wait for
set appToWait=%2
REM Number of seconds to wait before checking again
set waitTime=2
REM Maximum amount of time to wait for listening port
set maxWaitTime=180

REM ---------
REM Counter to store the amount of time we wait before server start listening on port
set totalWaitTime=0

:waitPort
REM Check if EPI Phone telnet port is opened & listening
netstat -a | grep %portToWait% | grep LISTENING>NUL
REM If port is opened and listening, the ERRORLEVEL is set to 0
if %ERRORLEVEL% EQU 0 goto portOpen

REM Port not opened or not listening, telling this to user ...
echo %appToWait% port %portToWait% not opened or not listening yet
echo Will try again in %waitTime% seconds (waiting since %totalWaitTime% second(s))
echo ...
REM echo.
REM ... wait before trying again ...
sleep %waitTime%
REM ... increase wait counter ...
set /a totalWaitTime=%totalWaitTime%+%waitTime%
REM ... and check if we did not wait for too long
if %totalWaitTime% GTR %maxWaitTime% goto cannotOpen
goto waitPort

:cannotOpen
echo Port %portToWait% is still not opened after waiting for %totalWaitTime% seconds
echo =^> Hoping it is actually opened
goto end


:portOpen
REM ---------
REM Server port is opened and listening
REM ==> We can continue

REM ---------
REM Display total waiting time (only if we did wait)
if %totalWaitTime% NEQ 0 (
echo ******************
echo Waited for %totalWaitTime% seconds before being able to connect to %appToWait%
echo ******************
echo.
echo.
)

:end
endlocal