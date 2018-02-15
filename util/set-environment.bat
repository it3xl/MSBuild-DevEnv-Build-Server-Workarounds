@REM 
ECHO OFF

@ECHO %~nx0

CHCP
@REM Seting UTF-8 encoding.
@REM CHCP 65001


IF [%env_defined_at%] NEQ [] EXIT;

SET env_util=%~dp0.
@REM The CALL preserves quotes for ~dp0. Prevents problems "Extra quotes inside a path" if this file invoked with a path with quotes.
SET env_util=%env_util:"=%
SET env_qUtil="%env_util%"

SET env_manager=%env_util%.
SET env_qManager="%env_manager%"

SET env_root=%env_util%.\..
SET env_qRoot="%env_root%"

WMIC OS GET LocalDateTime


REM 850
FOR /f "tokens=2 delims=:." %%x IN ('CHCP') DO SET current_CHCP=%%x
CHCP 850
FOR /F %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
CHCP %current_CHCP%

SET env_date=%DTS:~0,4%.%DTS:~4,2%.%DTS:~6,2%
SET env_time=%DTS:~8,2%.%DTS:~10,2%
SET env_time_sec=%DTS:~8,2%.%DTS:~10,2%-%DTS:~12,2%

SET env_defined_at=%env_date% %env_time_sec%

ECHO.
ECHO DTS %DTS%
ECHO env_defined_at %env_defined_at%
ECHO.