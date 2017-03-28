SETLOCAL

ECHO stamp_build_num.bat
CALL %_util%\exit_if_error

SET buildNum=%1
IF [%buildNum%] EQU [] GOTO BrokenInputParameter
SET accumPath=%2
IF [%accumPath%] EQU [] GOTO BrokenInputParameter


ECHO Build num: %buildNum%>%accumPath%\.build_num-%buildNum%.txt

FOR /F "delims=" %%i IN ('DIR %accumPath% /A:D /B /O:N') DO (
  ECHO Build num: %buildNum%>%accumPath%\%%i\.build_num.txt
)



@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333