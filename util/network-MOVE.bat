@SETLOCAL

@ECHO %~n0
@CALL %env_qUtil%\exit_if_error

@REM This method is much faster than ROBOCOPY!

SET source=%1
@ECHO source: %source%
IF [%source%] EQU [] GOTO BrokenInputParameter
SET target=%2
@ECHO target: %target%
IF [%target%] EQU [] GOTO BrokenInputParameter


@REM We should postpone because win-network bug "Access is denied. 0 dir(s) moved."

@ECHO Attempt #1 of 20
MOVE /Y %source% %target%

IF EXIST %source% (
  @ECHO Attempt #2 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #3 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #4 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #5 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #6 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #7 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #8 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #9 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #10 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #11 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #12 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #13 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #14 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #15 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #16 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #17 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #18 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #19 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)
IF EXIST %source% (
  @ECHO Attempt #20 of 20
  @CALL %env_qUtil%\delay-seconds.bat 3
  MOVE /Y %source% %target%
)



IF EXIST %source% (
  @ECHO Cannot move the folder %source%
  EXIT 223
)









@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333