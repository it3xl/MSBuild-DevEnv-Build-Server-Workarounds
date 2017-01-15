@IF %ERRORLEVEL% NEQ 0 (
	@ECHO "ERROR: %1 Exit code: %ERRORLEVEL%"
  @REM We will use the EXIT command to inform any Build-Server with a status of execution (0 means no errors).
	EXIT /B %ERRORLEVEL%
)
