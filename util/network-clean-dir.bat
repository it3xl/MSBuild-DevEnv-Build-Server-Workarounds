@SETLOCAL

@ECHO %~nx0
@CALL %env_qUtil%\exit_if_error

SET clean_dir_path=%1
IF [%clean_dir_path%] EQU [] EXIT 1001
IF [%clean_dir_path%] EQU [""] EXIT 1001

@ECHO Clean folder %clean_dir_path%


CALL %env_qUtil%\network-delete-dir.bat %clean_dir_path%


MKDIR %clean_dir_path%

