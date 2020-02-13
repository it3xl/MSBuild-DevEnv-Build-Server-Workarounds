@REM ECHO OFF

@ECHO @ %~nx0

IF [%set_manager_environment_declared%] NEQ [] EXIT /B;






SET __env_all_vs2019_root=%ProgramFiles(x86)%\Microsoft Visual Studio\2019
SET env_vs2019_install="%__env_all_vs2019_root%\Professional"
IF NOT EXIST %env_vs2019_install%  SET env_vs2019_install="%__env_all_vs2019_root%\Community"
IF NOT EXIST %env_vs2019_install%  SET env_vs2019_install="%__env_all_vs2019_root%\Enterprise"
@REM Let's fail loudly
IF NOT EXIST %env_vs2019_install%  SET "env_vs2019_install=Visual Studio 2019 install path was not found in %~nx0"

SET env_vs2019_dev_cmd="%env_vs2019_install:"=%\Common7\Tools\VsDevCmd.bat"







SET set_manager_environment_declared=1



@ECHO @ %~nx0 end