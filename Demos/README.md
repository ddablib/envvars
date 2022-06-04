# Environment Variables Unit - Demo Programs

## Introduction

Two demo projects are distributed with the _Environment Variables Unit_. Each demo is available in both VCL and FireMonkey 2 versions.

The VCL versions require Delphi 7 or later, while the FireMonkey 2 versions require Delphi XE3 or later.

Each demo project includes the _PJEnvVars_ unit explicitly so there is no need to install it before using the demos.

## Demo 1

Demo #1 can be found in the `Demos\1` directory, with the VCL and FireMonkey 2 versions being in the `VCL` and `FMX` sub-directories respectively.

Both versions present a similar interface. They demonstrate every method of the _TPJEnvironmentVars_ static class and show how to use the _TPJEnvVarsEnumerator_ enumerator class.

When run the program displays a set of controls on the left and an empty list box on the right of its window. The following buttons exercise the methods of _TPJEnvironmentVars_.

### Method buttons

* _GetValue()_

  Gets the value of the environment variable whose name is in the _Name_ edit box and displays it in the _Value_ edit box. If the name is blank, or doesn't exist, or exists but has no value, the _Value_ edit box is cleared.

* _SetValue()_

  Sets the value of the environment variable named in the _Name_ edit box to the value entered in the _Value_ edit box. If the environment variable doesn't exist it is created. If it does exist its value is updated. If the _Value_ edit box is empty the environment variables value is cleared, but the variable still exists. If the _Name_ edit box is empty an error message is displayed.

* _Delete()_

  Deletes the environment variable named in the _Name_ edit box from the environment block. If the environment variable didn't already exist nothing happens. If the _Name_ edit box is empty an error message is displayed.

* _Expand()_

  Expands the string value entered in the _Name_ edit box and displays the result in the _Value_ edit box. The entered string can contain any text. Environment variable names enclosed between two `%` characters are replaced with their values. Other text and invalid variable names are left unchanged.

* _Exists()_

  Displays a dialogue box informing if the environment variable named in the _Name_ edit control exists in the environment block. Blank names are always treated as non-existent, even if there are actually some unnamed values in the environment block.

* _Count()_

  Displays a dialogue box that shows of the number of environment variables in the current environment block.

* _BlockSize()_

  Displays a dialogue box that shows the size of the current environment block _in characters_.

* _GetAllNames(TStrings)_

  Gets the names of all environment variables in the current environment block in _TStrings_ format. The code behind the button updates the list box's Items property directly in the method call.

* _GetAllNames: array_

  Gets the names of all environment variables in the current environment block and returns them as a dynamic string array. The underlying code iterates the array and displays each name, enclosed between `[` and `]` characters, in the list box.

* _EnumNames() method_

  Calls the _EnumNames_ method, passing a form method as the callback. The callback method adds each enumerated environment variable name to the list box, with the name enclosed between `[` and `]` characters.

* _EnumNames() closure_

  Calls the _EnumNames_ method, passing an anonymous method (or closure) as the callback. This anonymous method adds each enumerated environment variable name to the list box, with each name enclosed between `<` and `>` characters.

  **Note:** this button is disabled when the demo is compiled with a version of Delphi that does not support anonymous methods.

* _GetAll(TStrings)_

  Gets the names and values of all environment variables in the current environment block in _TStrings_ format. The code behind the button updates the list box's Items property directly in the method call and displays the environment variables exactly as they are stored in the environment block.

* _GetAll: array_

  Gets the names and values of all environment variables in the current environment block and returns them as a dynamic array of _TPJEnvironmentVar_ records. The underlying code iterates this array and displays each environment variable's name and value in the list box. Variable names are enclosed by `[` and `]` and are followed by the associated value enclosed in double quotes.

* _EnumVars() method_

  Calls the _EnumVars_ method, passing a form method as the callback. The callback method adds each enumerated environment variable name and value to the list box, with names enclosed between `[` and `]` characters and values enclosed by double quotes.

* _EnumVars() closure_

  Calls the _EnumVars_ method, passing an anonymous method (or closure) as the callback. This anonymous method adds the name and value of each enumerated environment variable to the list box, with each name enclosed between `<` and `>` characters and values enclosed by double quotes.

  **Note:** this button is disabled when the demo is compiled with a version of Delphi that does not support anonymous methods.

* _CreateBlock()_

  Creates a new environment block containing the three environment variables listed below the button, and displays it in the list box. If the _Include current environment in new block_ check box is ticked then the environment variables in the current block are included in the new block.

Finally, the _Enumerate names using TPJEnvVarsEnumerator_ button demonstrates the use of the _TPJEnvVarsEnumerator_ class. Clicking it creates a _TPJEnvVarsEnumerator_ instance and uses it to enumerate the names of all the environment variable in the current block. Each name is enclosed between `[` and `]` characters and added to the list box.

### Demo 1 compilation notes

How the projects are compiled depends on the version of Delphi in use, as follows:

* _Delphi 7_

  Open and compile `Demos\1\VCL\VCLDemo1.dpr`.

* _Delphi 2005 and 2006_

  Open and compile `Demos\1\VCL\VCLDemo1.bdsproj`.

* _Delphi 2007_

  Rename `Demos\1\VCL\VCLDemo1.dproj.2007` as `Demos\1\VCL\VCLDemo1.dproj`, overwriting the original version. Now open and compile the renamed project.

* _Delphi 2009 to XE_

  Open and compile `Demos\1\VCL\VCLDemo1.dproj`.

* _Delphi XE2_

  Open `Demos\1\VCL\VCLDemo1.dproj`. This project can be built as either a 32- or 64-bit Windows application, but it only defines a 32-bit Windows target by default. So, to compile as a 32-bit application simply build the project as opened. To compile as a 64-bit application you must manually add a Windows 64-bit target to the project and re-build it.

* _Delphi XE3 and later_

  To compile the VCL version of the project open `Demos\1\VCL\VCLDemo1.dproj`. This project can be built as either a 32- or 64-bit Windows application, but it only defines a 32-bit Windows target by default. So, to compile as a 32-bit application, simply build the project as opened. To compile as a 64-bit application you must manually add a Windows 64-bit target to the project and re-build it.

  To compile the FireMonkey 2 project open `Demos\1\FMX\FMXDemo1.dproj`. This project comes with Windows 32-bit and 64-bit targets pre-defined, with the 64-bit target as the default. Select the required target and (re)build the project.

## Demo 2

Demo #2 can be found in the `Demos\2` directory, with the VCL and FireMonkey 2 versions being in the `VCL` and `FMX` sub-directories respectively.

Both versions demonstrate how to create child processes with custom environment blocks that have been created by using the _TPJEnvironmentVars.CreateBlock_ method.

Each version of the demo consists of a project group containing two projects. The first, `Parent.dpr` compiles into a program, `Parent.exe`, that lets the user specify some custom environment variables that can be passed to a child process. More than one child process can be started. The second project is `Child.dpr` which compiles into `Child.exe` that implements the child processes that are started from `Parent.exe`. All the child process does is to display its environment block in its main window.

To use the demo programs, proceed as follows:

1. Open either _VCLDemo2_ or _FMXDemo2_ project groups, using whichever file extension suits your compiler.

2. Compile both the `Parent.dpr` and `Child.dpr` projects.

3. Run `Parent.exe`

4. Edit, or add to, the suggested environment variable names listed in the large multi-line edit control. Enter each new environment variable in `Name=Value` format, one per line. If you enter duplicate values for the same environment variable then the value listed last is used.

5. Tick the _Include current environment block_ check box if you want to pass the current environment block, as well as the custom environment variables, to the child process. If this is done, and if there is a name clash between any variable in the current block and any of the new variables you entered in the edit control, the inherited value will be discarded and the new value from the edit control will be used.

6. Click the large button to start a child process.

7. Review the environment variables displayed by the child process.

8. Repeat from step 4 as required.

    > **Warning:** Some child processes require that certain environment variables are set to enable them to operate properly. Therefore, if you are not passing the current environment block to the child process, you may occasionally see unexpected behaviour.
    >
    > An example of this is in the FireMonkey 2 version of the project. The child application seems to require that the `SystemRoot` environment variable is set correctly. Failure to pass this environment variable to the child process can result in the process displaying a console window instead of its GUI. For this reason `SystemRoot` is displayed in the multi-line edit control as one of the suggested environment variables in the FireMonkey version.

### Demo 2 compilation notes

How the projects are compiled depends on the version of Delphi in use, as follows:

* _Delphi 7_

  Open the `Demos\2\VCL\VCLDemo2.bpg` project group and build both projects.

* _Delphi 2005 and 2006_

  Open the `Demos\2\VCL\VCLDemo2.bdsgroup` project group and build both projects.

* _Delphi 2007_

  Rename `Demos\2\VCL\Parent.dproj.2007` as `Demos\2\VCL\Parent.dproj` and `Demos\2\VCL\Child.dproj.2007` as `Demos\2\VCL\Child.dproj`, overwriting the original versions. Now open the `Demos\2\VCL\VCLDemo2.groupproj` project group and build both projects.

* _Delphi 2009 to XE_

  Open the `Demos\2\VCL\VCLDemo2.groupproj` project group and build both projects.

* _Delphi XE2_

  Open the `Demos\2\VCL\VCLDemo2.groupproj` project group. The _Parent_ and _Child_ projects can be built as either 32- or 64-bit Windows applications, but each defines only a 32-bit Windows target by default. So, to compile both projects as 32-bit applications, simply build all the projects as opened. To compile either or both as a 64-bit applications you must manually add a Windows 64-bit target to one or both projects and re-build the affected project(s).

* _Delphi XE3 and later_

  To compile the VCL version of the project open the `Demos\2\VCL\VCLDemo2.groupproj` project group. The _Parent_ and _Child_ projects can be built as either 32- or 64-bit Windows applications, but each defines only a 32-bit Windows target by default. So, to compile both projects as 32-bit applications, simply build all the projects as opened. To compile either or both as a 64-bit applications you must manually add a Windows 64-bit target to one or both projects and re-build the affected project(s).

    To compile the FireMonkey 2 project open the `Demos\2\FMX\FMXDemo2.groupproj` project group. Both the _Parent_ and _Child_ projects come with 32-bit and 64-bit targets pre-defined, with the 64-bit target as the default in both cases. Select the required target for each project and (re)build the affected project(s).

  **Note:** In both the VCL or FireMonkey 2 versions of this demo you will get a compile error if the projects have different targets and you attempt to build the whole project group at once. To get round this problem just build each project separately.

## Deprecated Code

There are no demos for the deprecated _TPJEnvVars_ component and public routines contained in the unit. Therefore _TPJEnvVars_ does not need to be installed to use the demos.

For the time being some demo code still exists in the `EnvVarsDemo` directory of the _Delphi Doodlings_ Subversion repository on Assembla. You can see a list of the demo files at [https://bit.ly/1mM1jLt](https://bit.ly/1mM1jLt). Subversion  users can also checkout the files using the same URL. Please note this code is no longer maintained or supported.

Please [create an issue](https://github.com/ddablib/envvars/issues) if you have found a bug, or you want to suggest any updates.

This document is copyright © 2022, [P D Johnson](https://gravatar.com/delphidabbler).
