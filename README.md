## MSBuild and DevEnv build-server workarounds

This project may be useful if you have some rough & tough errors with MSBuild and DevEnv on your build-server such as Jenkins, Teamcity, CruiseControl NET, etc.

It is possible a direct call of the solution from the CMD.

### How to use

1. Download this project.
2. In your build-server replace the use of plugins/tasks for MSBuild or DevEnv on an existing Execute plugin/task to call an external program (".bat" file in our case).
  * **MSBuild_Wrapper_VS2015.bat** for MSBuild
  * **DevEnv_Wrapper_VS2015.bat** for DevEnv
3. Inside these .bat files
  * correct paths to your real MSBuild and DevEnv for Visual Studio 2015.
  * comment out some workaround invocation that you do not need.

### Notes
* If your build-server uses some weird formatting for call parameters, you should reformat them to the standard form of MSBuild or DevEnv.
* Remember, these batch files always return an exit code (EXIT %ERRORLEVEL%) to inform a build-server about result of an operation. 0 means success.

### Description of the solution

Current solution uses a command line wrapper over MSBuild or DevEnv.com.
MSBuild_Wrapper_VS2015.bat for MSBuild.
DevEnv_Wrapper_VS2015.bat for DevEnv.com.
You should use them with the same standard parameters as you may want to use for MSBuild or DevEnv.com. The parameters just will be passed directly ("%*" CMD notation).

Actually, for well-known buld-servers for its MSBuild and DevEnv plugins/tasks it is possible to modify path settings to substitute MSBuild.exe and DevEnv.com by ".bat" files from this project.
I just have no resources to test it out well enough.

### More time expensive operations
In my opinion there is only one time expensive operation.
It is the invocation of the
* MSBuild Command Prompt for VS2015
* Developer Command Prompt for VS2015

It uses from half to 3 seconds depend on your hardware / virtual environment.

### Description of a more problematic environment this came from
All was tested and solved on the next environment.

* Windows 7 x64.
* Visual Studio 2015 SP1 installed over VS 2010.
* An installer's admin account can't access the Internet.
* Windows SDK 10 can't be installed (because of a unsolved MS bug) and rolled back.

