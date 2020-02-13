@REM ECHO OFF

@ECHO @ %~nx0

IF [%set_manager_environment_declared%] NEQ [] EXIT /B;






SET __env_all_vs2017_root=%ProgramFiles(x86)%\Microsoft Visual Studio\2017
SET env_vs2017_install="%__env_all_vs2017_root%\Professional"
IF NOT EXIST %env_vs2017_install%  SET env_vs2017_install="%__env_all_vs2017_root%\Community"
IF NOT EXIST %env_vs2017_install%  SET env_vs2017_install="%__env_all_vs2017_root%\Enterprise"
@REM Let's fail loudly
IF NOT EXIST %env_vs2017_install%  SET "env_vs2017_install=Visual Studio 2017 install path was not found in %~nx0"

SET env_vs2017_dev_cmd="%env_vs2017_install:"=%\Common7\Tools\VsDevCmd.bat"







SET set_manager_environment_declared=1



@ECHO @ %~nx0 end