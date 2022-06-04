# Environment Variables Unit

## Description

This unit provides a static class for reading and modifying the environment variables available to the current process, along with a class that can be used to enumerate environment variable names.

The unit also contains a component and a set of routines that duplicate some of the features provided by the static class. These are now **deprecated** and are provided for backward compatibility reasons only: they should no longer be used in new code and may be removed in a future version.

More information is available on the Environment Variables Unit [Home Page](https://delphidabbler.com/software/envvars).

### Compatibility

The _Environment Variables Unit_ has been tested on all Delphi versions from 7 to XE4, excluding Delphi 2005. The unit is thought to be compilable with versions of Delphi back to version 4, but this has not been tested.

The unit is compatible with both the Windows 32- and 64-bit Delphi compilers and the VCL and FireMonkey frameworks (tested with FireMonkey 2 only).

.NET and non-Windows platforms are not supported.

## Installation

The _Environment Variables Unit_ and documentation are supplied in a zip file. Before installing you need to extract all the files from the zip file. The following files will be extracted:

* **`PJEnvVars.pas`** – The _Environment Variables Unit_. Contains all source code, including the deprecated component, but excluding the component registration code.
* `PJEnvVars.dcr` – Component palette glyph for the deprecated component.
* `PJEnvVarsDsgn.pas` – Registration code for the deprecated component.
* `README.md` – This read-me file.
* `CHANGELOG.md` – The project change log.
* `MPL-2.txt` – The Mozilla Public License v2.0.
* `Documentation.url` – Short-cut to the unit's online documentation.

In addition to the above files you will find the source code for various [demo projects](#demo-programs) in the `Demos` directory.

There are four possible ways to use the unit:

1. The simplest way is the add a copy of `PJEnvVas.pas` to your projects whenever the unit is needed.
2. To make the unit easier to re-use you can either copy it to a folder on your Delphi search path, or add the folder containing the unit to the Delphi Search path. You then simply use the unit as required without needing to add it to your project.
3. For maximum portability you can add `PJEnvVars.pas` to a Delphi package.
4. If you use Git you can add the [`ddablib/envvars`](https://github.com/ddablib/envvars) GitHub repository as a Git submodule and add it to your project. Obviously, it's safer if you fork the repo and use your copy, just in case `ddablib/envvars` ever goes away.


> **NOTE:** None of the above methods will install the deprecated component into the Delphi IDE. To do this you need to add `PJEnvVars.pas`, `PJEnvVars.dcr` and `PJEnvVarsDsgn.pas` to a design time package. If you need help doing this [see here](https://www.delphidabbler.com/url/install-comp). This is not recommended other than for reasons of backwards compatibility.

## Documentation

The _Environment Variables Unit_ has comprehensive [online documentation.](https://delphidabbler.com/url/envvars-docs)

In addition there is an article, [How to access environment variables](https://delphidabbler.com/articles/article-6), that discusses interaction with environment variables on Windows.

## Demo Programs

Two different demo programs are included in the `Demos\1` and `Demos\2` sub-directories. There are VCL and FireMonkey 2 versions of each demo.

The demo programs are documented in the [`README.md`](https://github.com/ddablib/envvars/blob/main/Demos/README.md) file in the `Demos` directory.

## Update History

A complete change log is provided in [`CHANGELOG.md`](https://github.com/ddablib/envvars/blob/main/CHANGELOG.md) that is included in the download.


## License

The _Environment Variables Unit_ is released under the terms of the [Mozilla Public License v2.0](https://www.mozilla.org/MPL/2.0/).

## Bugs and Feature Requests

Bugs can be reported or new features requested via the project's [Issue Tracker](https://github.com/ddablib/envvars/issues). A GitHub account is required.

Please check if an issue has already been created for a similar report or request. If so then please add a comment containing as much information as you can to the existing issue, or if you've nothing to add, just add a :+1: (`:+1:`) comment. If there is no suitable existing issue then please add a new issue and give as much information as possible.

## About the Author

I'm Peter Johnson – a hobbyist programmer living in Ceredigion in West Wales, UK, writing mainly in Delphi. My programs and other library code are available from: [https://delphidabbler.com/](https://delphidabbler.com/).

This document is copyright © 2008-2022, [P D Johnson](https://gravatar.com/delphidabbler).
