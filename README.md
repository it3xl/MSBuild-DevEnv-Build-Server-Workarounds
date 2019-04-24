## MSBuild and DevEnv build-server workarounds

This project may be useful if you have some rough & tough errors with MSBuild and DevEnv on your build-server such as Jenkins, Teamcity, CruiseControl NET, etc.

#### Tested and used on: Jenkins, Teamcity, CruiseControl NET.

Also you can use a direct CMD-call of batch-files from this repo.

**Update:** Visual Studio 2017 support was added.

### How to use

1. Download this project.
2. In your build-server replace any use of build tasks for MSBuild or DevEnv for an existing Execute build task that invokes an external program (".bat" file in our case).
3. Replace paths to MSBuild and DevEnv.com on paths to project's batch files
  * **MSBuild_Wrapper_VS2015.bat** for MSBuild
  * **DevEnv_Wrapper_VS2015.bat** for DevEnv
4. Inside these .bat files
  * rarely it requires to correct paths to your MSBuild or DevEnv Command Prompt for Visual Studio (look at the top of the .bat files).
  * uncomment workarounds invocations that you need. You may uncomment them all. This was tested.

### Notes
* If your build-server uses some weird formatting for call parameters, you should reformat them to the standard form of MSBuild or DevEnv.
* Remember, these batch files always return an exit code (EXIT %ERRORLEVEL%) to inform a build-server about result of an operation. 0 means success.
* There are other troubles that fortunately covered by StackOverflow through Google.

### Description of the solution

Current solution uses a command line wrapper over MSBuild or DevEnv.com.
* MSBuild_Wrapper_VS2015.bat for MSBuild.
* DevEnv_Wrapper_VS2015.bat for DevEnv.com.

You should use them with the same standard parameters as you may want to use for MSBuild or DevEnv.com. The parameters just will be passed directly ("%*" CMD notation).

Actually, for well-known build-servers for its MSBuild and DevEnv build tasks it is possible to modify path settings to substitute MSBuild.exe and DevEnv.com by the ".bat" files from this project.

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
* Visual Studio 2015 SP1 and VS 2017 installed over VS 2010.
* An installer's admin account can't access the Internet.
* Windows SDK 10 can't be installed (because of an unsolved MS bug) and rolled back.



