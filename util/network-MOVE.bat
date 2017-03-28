SETLOCAL

@ECHO network-MOVE.bat
@CALL %_util%\exit_if_error


SET source=%1
@ECHO source: %source%
IF [%source%] EQU [] GOTO BrokenInputParameter
SET target=%2
@ECHO target: %target%
IF [%target%] EQU [] GOTO BrokenInputParameter


@REM We should to postpone because win-network bug "Access is denied. 0 dir(s) moved."

@ECHO Attempt #1 of 10
MOVE %source% %target%

IF EXIST %source% (
  @ECHO Attempt #2 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #3 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #4 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #5 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #6 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #7 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #8 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #9 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #10 of 10
  @CALL %_util%\delay-seconds.bat 3
  MOVE %source% %target%
)












@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333