@SETLOCAL

SET seconds=%1
@ECHO %~n0 / Delay %seconds% seconds.
IF [%seconds%] EQU [] GOTO BrokenInputParameter


@CHOICE /N /C y /D y /T %seconds% > NUL

@REM Will exit with 0 exit code to prevent spam to ERRORLEVEL from the CHOICE command.
@EXIT /B 0



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333