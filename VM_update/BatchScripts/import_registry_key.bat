@echo off & setlocal
REM
REM import_registry_key.bat <host_name>
REM
REM Import PuTTY registry key for specified host
REM

REM Make sure Unix tools are in path
if not defined PathUnixTools set Path=%Path%;%~sdp0..\Tools\Unix

REM Check command-line parameters
if [%1X] EQU [X] goto badParam
goto JustDoIt

:badParam
call Logs import_registry_key.bat - ERROR - Host name not specified. Doing nothing
goto end

:JustDoIt
call Logs ---------------------------------------------------------------------------------
call Logs  %~nx0 host_name=%1
call Logs ---------------------------------------------------------------------------------

REM Do whatever we have to do
pushd "%~sdp0"

set regKeyFile=.\registry_files\%1.reg

if exist "%regKeyFile%" (
	call Logs Making sure host key is known.
	reg import "%regKeyFile%">nul 2>&1
) else (
	call Logs File "%regKeyFile%" does not exist. Assuming host key is already known
)

popd

:end
endlocal