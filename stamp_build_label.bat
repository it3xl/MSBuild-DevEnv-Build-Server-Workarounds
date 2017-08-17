@SETLOCAL

ECHO %~n0
CALL %env_qUtil%\exit_if_error

SET buildLabel=%1
IF [%buildLabel%] EQU [] GOTO BrokenInputParameter
SET q_accumPath=%2
IF [%q_accumPath%] EQU [] GOTO BrokenInputParameter
IF [%q_accumPath%] EQU [""] GOTO BrokenInputParameter


@REM Write build number to the root file.
@REM ECHO Build num: %buildLabel%>%q_accumPath%\.build_num-%buildLabel%.config
ECHO Build num: %buildLabel%>%q_accumPath%\.build_num.config

@REM Write build number to first level deep files.
FOR /F "delims=" %%i IN ('DIR %q_accumPath% /A:D /B /O:N') DO (
  ECHO Build num: %buildLabel%>%q_accumPath%\%%i\.build_num.config
)



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 1000