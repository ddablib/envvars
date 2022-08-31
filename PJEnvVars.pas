{
 * This Source Code Form is subject to the terms of the Mozilla Public License,
 * v. 2.0. If a copy of the MPL was not distributed with this file, You can
 * obtain one at https://mozilla.org/MPL/2.0/
 *
 * Copyright (C) 1998-2022, Peter Johnson (delphidabbler.com).
 *
 * DelphiDabbler Environment Variables unit. Contains classes for interrogating,
 * modifying and enumerating the environment variables belonging to the current
 * process.
 *
 * Documented at https://delphidabbler.com/url/envvars-docs
 *
 * ACKNOWLEDGEMENTS
 *
 * Thanks to "e.e" for bug fix in v1.3.2
}


unit PJEnvVars;


// Set conditional symbols & switch off unsafe warnings where supported
{$UNDEF Supports_RTLNamespaces}
{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 24.0} // Delphi XE3 and later
    {$LEGACYIFEND ON}  // NOTE: this must come before all $IFEND directives
  {$IFEND}
  {$IF CompilerVersion >= 23.0} // Delphi XE2 ad later
    {$DEFINE Supports_RTLNamespaces}
  {$IFEND}
{$ENDIF}


interface


uses
  // Delphi
  {$IFNDEF Supports_RTLNamespaces}
  SysUtils, Classes, Types;
  {$ELSE}
  System.SysUtils, System.Classes, System.Types;
  {$ENDIF}

type

  ///  <summary>Record encapsulating the name and value of an environment
  ///  variable.</summary>
  TPJEnvironmentVar = record
    ///  <summary>Environment variable name.</summary>
    Name: string;
    ///  <summary>Environment variable value.</summary>
    Value: string;
  end;

  ///  <summary>Dynamic array of <see cref="PJEnvVars|TPJEnvironmentVar"/>
  ///  records.</summary>
  TPJEnvironmentVarArray = array of TPJEnvironmentVar;

  ///  <summary>Type of callback method passed to the
  ///  <see cref="PJEnvVars|TPJEnvironmentVars.EnumNames"/> method, to be called
  ///  for each enumerated environment variable.</summary>
  ///  <param name="VarName">string [in] Name of the current environment
  ///  variable in the enumeration.</param>
  ///  <param name="Data">Pointer [in] User-specified value that was passed to
  ///  <see cref="PJEnvVars|TPJEnvironmentVars.EnumNames"/></param>
  ///  <remarks>Either closures or normal methods can be assigned to
  ///  <c>TPJEnvVarsEnum</c>.</remarks>
  TPJEnvVarsEnum = reference to procedure(const VarName: string; Data: Pointer);

  ///  <summary>Type of callback method passed to the
  ///  <see cref="PJEnvVars|TPJEnvironmentVars.EnumVars"/> method, to be called
  ///  for each enumerated environment variable.</summary>
  ///  <param name="EnvVar"><see cref="PJEnvVars|TPJEnvironmentVar"/> [in]
  ///  Information about the current environment variable in the enumeration.
  ///  </param>
  ///  <param name="Data">Pointer [in] User-specified value that was passed to
  ///  <see cref="PJEnvVars|TPJEnvironmentVars.EnumVars"/></param>
  ///  <remarks>Either closures or normal methods can be assigned to
  ///  <c>TPJEnvVarsEnumEx</c>.</remarks>
  TPJEnvVarsEnumEx = reference to procedure(const EnvVar: TPJEnvironmentVar;
    Data: Pointer);

  ///  <summary>Static class providing class methods for interrogating,
  ///  manipulating and modifying the environment variables available to the
  ///  current process.</summary>
  ///  <remarks>This class cannot be constructed.</remarks>
  TPJEnvironmentVars = class(TObject)
  public
    ///  <summary>Prevents construction of instances of this static class.
    ///  </summary>
    ///  <exception cref="ENoConstructException">Always raised.</exception>
    constructor Create;
    ///  <summary>Returns the number of environment variables in the current
    ///  process.</summary>
    class function Count: Integer;
    ///  <summary>Checks if an environment variable with the given name exists.
    ///  </summary>
    class function Exists(const VarName: string): Boolean;
    ///  <summary>Returns the value of the environment variable with the given
    ///  name or the empty string if the variable does not exist.</summary>
    class function GetValue(const VarName: string): string;
    ///  <summary>Sets the value of the environment variable with the given name
    ///  to the given value.</summary>
    ///  <remarks>Returns <c>0</c> on success or a Windows error code on
    ///  failure.</remarks>
    class function SetValue(const VarName, VarValue: string): Integer;
    ///  <summary>Deletes the environment variable with the given name.
    ///  </summary>
    ///  <remarks>Returns <c>0</c> on success or a Windows error code on
    ///  failure.</remarks>
    class function Delete(const VarName: string): Integer;
    ///  <summary>Creates a new custom environment block.</summary>
    ///  <param name="NewEnv">TStrings [in] List of environment variables in
    ///  <c>Name=Value</c> format to be included in the new environment block.
    ///  If <c>nil</c> then no new environment variables are included in the
    ///  block.</param>
    ///  <param name="IncludeCurrent">Boolean [in] Flag indicating whether the
    ///  environment variables from the current process are included in the new
    ///  environment block.</param>
    ///  <param name="Buffer">Pointer [in] Pointer to a memory block that
    ///  receives the new environment block. If <c>nil</c> then no block is
    ///  created. If none-<c>nil</c> the buffer must be at least <c>BufSize *
    ///  SizeOf(Char)</c> bytes.</param>
    ///  <param name="BufSize">Integer [in] The number of characters that can be
    ///  stored in the memory pointed to by <c>Buffer</c> or <c>0</c> if
    ///  <c>Buffer</c> is <c>nil</c>.</param>
    ///  <returns>Integer. The size of the environment block in characters. If
    ///  <c>Buffer</c> is <c>nil</c> this is the required size of the buffer, in
    ///  characters. Multiply this value by <c>SizeOf(Char)</c> to find the
    ///  required buffer size in bytes.</returns>
    ///  <remarks>
    ///  <para>To find the required buffer size call this method with <c>Buffer
    ///  = nil</c> and it will return the required block size, in characters.
    ///  Now allocate a buffer large enough to hold the required number of
    ///  characters and call this method again, this time passing the buffer and
    ///  its size in characters.</para>
    ///  <para>The environment blocks created by this method are suitable for
    ///  passing to processes created with the <c>CreateProcess</c> API
    ///  function. How this is done depends on whether the block is Unicode (as
    ///  created with Unicode Delphis) or ANSI (as created by non-Unicode
    ///  Delphis). To see how see
    ///  http://delphidabbler.com/articles?article=6#createenvblock</para>
    ///  </remarks>
    class function CreateBlock(const NewEnv: TStrings;
      const IncludeCurrent: Boolean; const Buffer: Pointer;
      const BufSize: Integer): Integer;
    ///  <summary>Calculates and returns the size of the current process'
    ///  environment block in characters.</summary>
    ///  <remarks>Multiply the returned size by <c>SizeOf(Char)</c> to get the
    ///  block size in bytes.</remarks>
    class function BlockSize: Integer;
    ///  <summary>Expands a string containing environment variables by replacing
    ///  each environment variable name with its value.</summary>
    ///  <param name="Str">string [in] String containing environment variables
    ///  to be expanded. Each environment variable name must be enclosed by
    ///  single <c>%</c> characters, e.g. <c>%FOO%</c>.</param>
    ///  <returns>string. The expanded string.</returns>
    class function Expand(const Str: string): string;
    ///  <summary>Gets all the environment variables available to the current
    ///  process and returns the size of the environment block.</summary>
    ///  <param name="Vars">TStrings [in] Receives all environment variables in
    ///  Name=Value format. Any previous contents are discarded. If <c>nil</c>
    ///  is passed to this parameter no environment variables are fetched.
    ///  </param>
    ///  <returns>Integer. The minimum size of a environment block that contains
    ///  all the environment variables, in characters. Multiply by
    ///  <c>SizeOf(Char)</c> to get the size in bytes.</returns>
    ///  <remarks>If you need to find the block size without fetching any
    ///  environment variables just call the method and pass nil as the
    ///  parameter.</remarks>
    class function GetAll(const Vars: TStrings): Integer; overload;
    ///  <summary>Gets all the environment variables available to the current
    ///  process.</summary>
    ///  <returns><see cref="PJEnvVars|TPJEnvironmentVarArray"/>. A dynamic
    ///  array of records containing the names and values of each environment
    ///  variable.</returns>
    class function GetAll: TPJEnvironmentVarArray; overload;
    ///  <summary>Gets the names of all environment variables available to the
    ///  current process.</summary>
    ///  <param name="Names">TStrings [in] Receives all the environment variable
    ///  names. Any existing content is discarded. Must not be nil.</param>
    class procedure GetAllNames(const Names: TStrings); overload;
    ///  <summary>Gets the names of all environment variables available to the
    ///  current process.</summary>
    ///  <returns>TStringDynArray. Dynamic array containing the environment
    ///  variable names.</returns>
    class function GetAllNames: TStringDynArray; overload;
    ///  <summary>Enumerates the names of all environment variables in the
    ///  current process.</summary>
    ///  <param name="Callback"><see cref="PJEnvVars|TPJEnvVarsEnum"/> [in]
    ///  Callback method called once for each environment variable, passing its
    ///  name and the value of the <c>Data</c> pointer as parameters.</param>
    ///  <param name="Data">Pointer [in] Data to be passed to <c>Callback</c>
    ///  method each time it is called.</param>
    class procedure EnumNames(Callback: TPJEnvVarsEnum; Data: Pointer);
    ///  <summary>Enumerates all the environment variables available to the
    ///  current process.</summary>
    ///  <param name="Callback"><see cref="PJEnvVars|TPJEnvVarsEnumEx"/> [in]
    ///  Callback method called once for each environment variable, passing a
    ///  record containing its name and value along with the the value of the
    ///  <c>Data</c> pointer as parameters.</param>
    ///  <param name="Data">Pointer [in] Data to be passed to <c>Callback</c>
    ///  method each time it is called.</param>
    class procedure EnumVars(Callback: TPJEnvVarsEnumEx; Data: Pointer);
  end;

  ///  <summary>Enumerator for all environment variables names in the current
  ///  process.</summary>
  ///  <remarks>This class may be used on its own. Instances of this type are
  ///  returned by <see cref="PJEnvVars|TPJEnvVars.GetEnumerator"/>.</remarks>
  TPJEnvVarsEnumerator = class(TObject)
  private
    ///  <summary>List of environment variable names being enumerated.</summary>
    fEnvVarNames: TStrings;
    ///  <summary>Index of current name in enumeration.</summary>
    fIndex: Integer;
  public
    ///  <summary>Constructs and initialises a new enumeration object.
    ///  </summary>
    constructor Create;
    ///  <summary>Destroys enumerator instance.</summary>
    destructor Destroy; override;
    ///  <summary>Returns name of current environment variable in enumeration.
    ///  </summary>
    function GetCurrent: string;
    ///  <summary>Moves to next environment variable name in enumeration if
    ///  present.</summary>
    ///  <returns>Boolean. <c>True</c> if there is a next item or <c>False</c>
    ///  there are no more items in the enumeration.</returns>
    function MoveNext: Boolean;
    ///  <summary>Name of current environment variable in enumeration.</summary>
    property Current: string read GetCurrent;
  end;

  ///  <summary>Exception raised by <see cref="PJEnvVars|TPJEnvVars"/> when an
  ///  error is encountered.</summary>
  EPJEnvVars = class(EOSError);


implementation


uses
  // Delphi
  {$IFNDEF Supports_RTLNamespaces}
  RTLConsts, Windows;
  {$ELSE}
  System.RTLConsts, Winapi.Windows;
  {$ENDIF}

{ TPJEnvVarsEnumerator }

constructor TPJEnvVarsEnumerator.Create;
begin
  fEnvVarNames := TStringList.Create;
  TPJEnvironmentVars.GetAllNames(fEnvVarNames);
  fIndex := -1;
end;

destructor TPJEnvVarsEnumerator.Destroy;
begin
  fEnvVarNames.Free;
  inherited;
end;

function TPJEnvVarsEnumerator.GetCurrent: string;
begin
  Result := fEnvVarNames[fIndex];
end;

function TPJEnvVarsEnumerator.MoveNext: Boolean;
begin
  Result := fIndex < Pred(fEnvVarNames.Count);
  if Result then
    Inc(fIndex);
end;

{ TPJEnvironmentVars }

class function TPJEnvironmentVars.BlockSize: Integer;
begin
  Result := GetAll(nil); // this function returns required block size
end;

class function TPJEnvironmentVars.Count: Integer;
var
  EnvList: TStringList; // list of all environment variables
begin
  EnvList := TStringList.Create;
  try
    GetAll(EnvList);
    Result := EnvList.Count;
  finally
    EnvList.Free;
  end;
end;

constructor TPJEnvironmentVars.Create;
begin
  raise ENoConstructException.CreateFmt(sNoConstruct, [ClassName]);
end;

class function TPJEnvironmentVars.CreateBlock(const NewEnv: TStrings;
  const IncludeCurrent: Boolean; const Buffer: Pointer;
  const BufSize: Integer): Integer;
var
  EnvVars: TStringList;
  EnvName: string;
  EnvValue: string;
  EnvNameIdx: Integer;
  Idx: Integer;
  PBuf: PChar;
begin
  EnvVars := TStringList.Create;
  try
    // Include copy of current environment block if required: current block is
    // assumed not to have duplicates.
    if IncludeCurrent then
      GetAll(EnvVars);
    // Include any additional environment variables in NewEnv. If there any
    // duplicate names in NewEnv only the entry with the greatest index is used.
    // If the current environment block is included and an environment variable
    // in NewEnv has the same name as one in the current block, then the value
    // from NewEnv is used.
    if Assigned(NewEnv) then
    begin
      for Idx := 0 to Pred(NewEnv.Count) do
      begin
        if AnsiPos('=', NewEnv[Idx]) = 0 then
          Continue; // not a valid environment variable - skip it
        EnvValue := NewEnv.ValueFromIndex[Idx];
        EnvName := NewEnv.Names[Idx];
        EnvNameIdx := EnvVars.IndexOfName(EnvName);
        if EnvNameIdx >= 0 then
          // environment variable with this name already exists: overwrite value
          EnvVars.ValueFromIndex[EnvNameIdx] := EnvValue
        else
          // environment variable with this name doesn't exist: add it
          EnvVars.Add(EnvName + '=' + EnvValue);
      end;
    end;
    // Calculate size of new environment block: block consists of #0 separated
    // list of environment variables terminated by #0#0, e.g.
    // Foo=Lorem#0Bar=Ipsum#0Raboof=Dolore#0#0
    Result := 0;
    for Idx := 0 to Pred(EnvVars.Count) do
      Inc(Result, Length(EnvVars[Idx]) + 1);  // +1 allows for #0 separator
    Inc(Result);  // allow for terminating #0
    // Check if provided buffer is large enough and create block in it if so
    if (Buffer <> nil) and (BufSize >= Result) then
    begin
      // new environment blocks are always sorted
      EnvVars.Sorted := True;
      // do the copying
      PBuf := Buffer;
      for Idx := 0 to Pred(EnvVars.Count) do
      begin
        StrPCopy(PBuf, EnvVars[Idx]);   // includes terminating #0
        Inc(PBuf, Length(EnvVars[Idx]) + 1);
      end;
      // terminate block with additional #0
      PBuf^ := #0;
    end;
  finally
    EnvVars.Free;
  end;
end;

class function TPJEnvironmentVars.Delete(const VarName: string): Integer;
begin
  if SetEnvironmentVariable(PChar(VarName), nil) then
    Result := 0
  else
    Result := GetLastError;
end;

class procedure TPJEnvironmentVars.EnumNames(Callback: TPJEnvVarsEnum;
  Data: Pointer);
var
  Idx: Integer;
  EnvList: TStringList;
begin
  Assert(Assigned(Callback));
  EnvList := TStringList.Create;
  try
    GetAll(EnvList);
    for Idx := 0 to Pred(EnvList.Count) do
      Callback(EnvList.Names[Idx], Data);
  finally
    EnvList.Free;
  end;
end;

class procedure TPJEnvironmentVars.EnumVars(Callback: TPJEnvVarsEnumEx;
  Data: Pointer);
var
  Idx: Integer;
  AllEnvVars: TPJEnvironmentVarArray;
begin
  Assert(Assigned(Callback));
  AllEnvVars := GetAll;
  for Idx := Low(AllEnvVars) to High(AllEnvVars) do
    Callback(AllEnvVars[Idx], Data);
end;

class function TPJEnvironmentVars.Exists(const VarName: string): Boolean;
begin
  Result := GetEnvironmentVariable(PChar(VarName), nil, 0) > 0;
end;

class function TPJEnvironmentVars.Expand(const Str: string): string;
var
  BufSize: Integer;
begin
  // Get required buffer size (including terminal #0)
  BufSize := ExpandEnvironmentStrings(PChar(Str), nil, 0);
  if BufSize > 1 then
  begin
    SetLength(Result, BufSize - 1); // space for terminal #0 automatically added
    ExpandEnvironmentStrings(PChar(Str), PChar(Result), BufSize);
  end
  else
    Result := ''; // tried to expand an empty string
end;

class function TPJEnvironmentVars.GetAll: TPJEnvironmentVarArray;
var
  AllEnvVars: TStringList;
  Idx: Integer;
  EnvVar: TPJEnvironmentVar;
begin
  AllEnvVars := TStringList.Create;
  try
    GetAll(AllEnvVars);
    SetLength(Result, AllEnvVars.Count);
    for Idx := 0 to Pred(AllEnvVars.Count) do
    begin
      EnvVar.Name := AllEnvVars.Names[Idx];
      EnvVar.Value := AllEnvVars.ValueFromIndex[Idx];
      Result[Idx] := EnvVar;
    end;
  finally
    AllEnvVars.Free;
  end;
end;

class function TPJEnvironmentVars.GetAll(const Vars: TStrings): Integer;
var
  PEnvVars: PChar;    // pointer to start of environment block
  PEnvEntry: PChar;   // pointer to an environment string in block
begin
  // Clear any list
  if Assigned(Vars) then
    Vars.Clear;
  // Get reference to environment block for this process
  PEnvVars := GetEnvironmentStrings;
  if PEnvVars <> nil then
  begin
    // We have a block: extract strings from it
    // Env strings are #0 terminated and list ends an additional #0, e.g.:
    // Foo=Lorem#0Bar=Ipsum#0Raboof=Dolore#0#0
    PEnvEntry := PEnvVars;
    try
      while PEnvEntry^ <> #0 do
      begin
        if Assigned(Vars) then
          Vars.Add(PEnvEntry);
        Inc(PEnvEntry, StrLen(PEnvEntry) + 1);  // +1 to skip terminating #0
      end;
      // Calculate length of block
      Result := (PEnvEntry - PEnvVars) + 1;     // + 1 to allow for final #0
    finally
      FreeEnvironmentStrings(PEnvVars);
    end;
  end
  else
    // No block => zero length
    Result := 0;
end;

class procedure TPJEnvironmentVars.GetAllNames(const Names: TStrings);
var
  AllEnvVars: TStrings;
  Idx: Integer;
begin
  Assert(Assigned(Names));
  Names.Clear;
  AllEnvVars := TStringList.Create;
  try
    GetAll(AllEnvVars);
    for Idx := 0 to Pred(AllEnvVars.Count) do
      Names.Add(AllEnvVars.Names[Idx]);
  finally
    AllEnvVars.Free;
  end;
end;

class function TPJEnvironmentVars.GetAllNames: TStringDynArray;
var
  Names: TStrings;
  Idx: Integer;
begin
  Names := TStringList.Create;
  try
    GetAllNames(Names);
    SetLength(Result, Names.Count);
    for Idx := 0 to Pred(Names.Count) do
      Result[Idx] := Names[Idx];
  finally
    Names.Free;
  end;
end;

class function TPJEnvironmentVars.GetValue(const VarName: string): string;
var
  BufSize: Integer;
begin
  // Get required buffer size (including terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 1 then
  begin
    // Env var exists and is non-empty: read value into result string
    SetLength(Result, BufSize - 1); // space for terminal #0 automatically added
    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    Result := '';
end;

class function TPJEnvironmentVars.SetValue(const VarName, VarValue: string):
  Integer;
begin
  if SetEnvironmentVariable(PChar(VarName), PChar(VarValue)) then
    Result := 0
  else
    Result := GetLastError;
end;

end.

