@SETLOCAL

ECHO %~n0
CALL %env_qUtil%\exit_if_error

SET buildNum=%1
IF [%buildNum%] EQU [] GOTO BrokenInputParameter
SET accumPath=%2
IF [%accumPath%] EQU [] GOTO BrokenInputParameter


@REM Write build number to the root file.
ECHO Build num: %buildNum%>%accumPath%\.build_num-%buildNum%.config

@REM Write build number to first level deep files.
FOR /F "delims=" %%i IN ('DIR %accumPath% /A:D /B /O:N') DO (
  ECHO Build num: %buildNum%>%accumPath%\%%i\.build_num.config
)



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333