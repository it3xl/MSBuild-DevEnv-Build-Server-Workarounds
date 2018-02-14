@SETLOCAL

@REM 
ECHO OFF


@ECHO %~nx0
@CALL %env_qUtil%\exit_if_error

SET del_dir_path=%1
IF [%del_dir_path%] EQU [] EXIT 1001
IF [%del_dir_path%] EQU [""] EXIT 1001

@ECHO delete foder %del_dir_path%

IF NOT EXIST %del_dir_path% (
  @ECHO no such a folder %del_dir_path%
  EXIT /B 0
)

@REM Let's delete a network folder with bugs workarounds.
@ECHO Attempt #1 of 15
RD /S /Q %del_dir_path%

@REM A lie can be in the second attempt. We will receive "there is no folder" but it there's.
IF EXIST %del_dir_path% (
  @ECHO Attempt #2 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)

IF EXIST %del_dir_path% (
  @ECHO Attempt #3 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #4 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #5 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #6 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #7 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #8 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #9 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #10 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #11 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #12 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #13 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #14 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)
IF EXIST %del_dir_path% (
  @ECHO Attempt #15 of 15
  @CALL %env_qUtil%\delay-seconds.bat 1
  RD /S /Q %del_dir_path%
)


IF EXIST %del_dir_path% (
  @ECHO Cannot delete the folder %del_dir_path%
  EXIT 222
)



