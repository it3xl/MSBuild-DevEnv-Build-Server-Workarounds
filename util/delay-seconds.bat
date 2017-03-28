SETLOCAL

SET seconds=%1
@ECHO delay-seconds.bat / Delay %seconds% seconds.
IF [%seconds%] EQU [] GOTO BrokenInputParameter

@CALL %_util%\exit_if_error


@CHOICE /N /C y /D y /T %seconds% > NUL


@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333