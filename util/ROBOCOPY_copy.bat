@SETLOCAL

@ECHO %~n0
@CALL %env_qUtil%\exit_if_error

SET source=%1
@ECHO source: %source%
IF [%source%] EQU [] EXIT 1001
IF [%source%] EQU [""] EXIT 1001

SET target=%2
@ECHO target: %target%
IF [%target%] EQU [] EXIT 1002
IF [%target%] EQU [""] EXIT 1002

@REM Ensures the copying process
ROBOCOPY %source% %target% /E   /Z   /PURGE   /W:1 /R:300 /TBD   /NP /FP /NS /V

@REM The Key Options
@REM 
@REM https://ss64.com/nt/robocopy.html
@REM https://technet.microsoft.com/library/cc733145(v=ws.10).aspx
@REM 
@REM Source
@REM /E : Copy Subfolders, including Empty Subfolders.
@REM 
@REM Copy options
@REM /Z : Copy files in restartable mode (survive network glitch).
@REM /MOVE : Move files and dirs (delete from source after copying).
@REM 
@REM Destination options
@REM /PURGE : Delete dest files/folders that no longer exist in source.
@REM /MIR : MIRror a directory tree - equivalent to /PURGE plus all subfolders (/E)
@REM 
@REM Retry options
@REM /W:n : Wait time between retries - default is 30 seconds.
@REM /R:n : Number of Retries on failed copies - default is 1 million.
@REM /TBD : Wait for sharenames To Be Defined (retry error 67).
@REM 
@REM Logging options
@REM /NP : No Progress - don’t display % copied.
@REM /FP : Include Full Pathname of files in the output.
@REM /NS : No Size - don’t log file sizes.
@REM /V : Produce Verbose output log, showing skipped files
@REM /NDL : No Directory List - don’t log directory names.


@REM ROBOCOPY Exit Codes
@REM https://ss64.com/nt/robocopy-exit.html
@REM https://superuser.com/questions/280425/getting-robocopy-to-return-a-proper-exit-code
@REM 
@REM 
IF %ERRORLEVEL% LEQ 4 EXIT /B 0
EXIT %ERRORLEVEL%




