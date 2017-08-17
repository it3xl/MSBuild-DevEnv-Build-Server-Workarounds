@SETLOCAL

@ECHO %~n0

SET seconds=%1
IF [%seconds%] EQU [] EXIT 1001

@ECHO %~n0 / Delay %seconds% seconds.


@CHOICE /N /C y /D y /T %seconds% > NUL

@REM Will exit with 0 exit code to prevent spam to ERRORLEVEL from the CHOICE command.
@EXIT /B 0


