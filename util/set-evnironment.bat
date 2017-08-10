SET env_util=%~dp0.
@REM The CALL preserves quotes for ~dp0. Prevents problems "Extra quotes inside a path" if this file invoked with a path with quotes.
SET env_util=%env_util:"=%
SET env_qUtil="%env_util%"

SET env_manager=%env_util%.
SET env_qManager="%env_manager%"

SET env_root=%env_util%.\..
SET env_qRoot="%env_root%"

