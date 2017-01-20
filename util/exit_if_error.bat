@IF %ERRORLEVEL% NEQ 0 (
	@ECHO Exit because CMD has an error code at ERRORLEVEL variable: %ERRORLEVEL%.
  @REM We will use the EXIT command to inform any Build-Server with a status of execution (0 means no errors).
	EXIT %ERRORLEVEL%
)
