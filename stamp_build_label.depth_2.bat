@SETLOCAL

ECHO %~nx0
CALL %q_env_cmd_util%\exit_if_error

SET buildLabel=%1
IF [%buildLabel%] EQU [] GOTO BrokenInputParameter

SET accumPath=%2
SET accumPath=%accumPath:"=%
IF ["%accumPath%"] EQU [] GOTO BrokenInputParameter


@REM Write build number to the root file.
@REM ECHO Build num: %buildLabel%>"%accumPath%\.build_num-%buildLabel%.config"
ECHO Build num: %buildLabel%>"%accumPath%\.build_num.config"

@REM Write build number to first level deep files.
FOR /F "delims=" %%i IN ('DIR "%accumPath%" /A:D /B /O:N') DO (
  ECHO Build num: %buildLabel%>"%accumPath%\%%i\.build_num.config"
  
  FOR /F "delims=" %%y IN ('DIR "%accumPath%\%%i" /A:D /B /O:N') DO (
    ECHO Build num: %buildLabel%>"%accumPath%\%%i\%%y\.build_num.config"
  )
)



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 1000