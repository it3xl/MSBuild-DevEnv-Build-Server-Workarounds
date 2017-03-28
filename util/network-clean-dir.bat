SETLOCAL

@ECHO clean-network-dir.bat
@CALL %_util%\exit_if_error

SET clean_dir_path=%1
@ECHO Clean folder %clean_dir_path%
IF [%clean_dir_path%] EQU [] GOTO BrokenInputParameter


@REM Let's clear a network folder with bugs workarounds.
@ECHO Attempt #1 of 15
RD /S /Q %clean_dir_path%

@REM A lie can be in the second attempt. We will receive "there is no folder" but it there is.
IF EXIST %clean_dir_path% (
  @ECHO Attempt #2 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)

IF EXIST %clean_dir_path% (
  @ECHO Attempt #3 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #4 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #5 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #6 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #7 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #8 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #9 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #10 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #11 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #12 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #13 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #14 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)
IF EXIST %clean_dir_path% (
  @ECHO Attempt #15 of 15
  @CALL %_util%\delay-seconds.bat 1
  RD /S /Q %clean_dir_path%
)


MKDIR %clean_dir_path%


@GOTO :EOF

:BrokenInputParameter
ECHO  !#!  Interrupted. Not all input parameters have been set to call this script!
ECHO.
EXIT 333