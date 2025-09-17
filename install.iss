#define MyAppName "Mouse Toggle"

#ifndef MyAppVersion
#define MyAppVersion "MISSED_VERSION"
#endif

#define MyAppPublisher "russiandesman"
#define MyAppExeName "mouse_toggle.exe"
#define Sch "Control Panel\Cursors\Schemes"

[Setup]
AppId={{e1ae9280-7962-4172-8c6c-b4bf751aa9e2}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={userlocalappdata}\Programs\{#MyAppName} {#MyAppVersion}
DisableProgramGroupPage=yes
;OutputDir=.
OutputBaseFilename=MouseToggle_setup_{#MyAppVersion}
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: {#MyAppExeName};           DestDir: "{app}"; Flags: ignoreversion
Source: "cursors\*";               DestDir: "{app}\cursors"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\{#MyAppName} normal"; Filename: "{app}\{#MyAppExeName}"; Parameters: "n"
Name: "{autoprograms}\{#MyAppName} large";  Filename: "{app}\{#MyAppExeName}"; Parameters: "l"
Name: "{autoprograms}\{#MyAppName} XL";     Filename: "{app}\{#MyAppExeName}"; Parameters: "xl"
Name: "{autodesktop}\{#MyAppName} normal"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "n"
Name: "{autodesktop}\{#MyAppName} large";  Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "l"
Name: "{autodesktop}\{#MyAppName} XL";     Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "xl"

[Registry]
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_left_n";   ValueData: "{code:CursorScheme|normal_left}"
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_right_n";  ValueData: "{code:CursorScheme|normal_right}"
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_left_l";   ValueData: "{code:CursorScheme|large_left}"
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_right_l";  ValueData: "{code:CursorScheme|large_right}"
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_left_xl";  ValueData: "{code:CursorScheme|extra_large_left}"
Root: HKCU; Subkey: "{#Sch}"; ValueType: expandsz; Flags: uninsdeletevalue; \
    ValueName: "mouse_toggle_scheme_right_xl"; ValueData: "{code:CursorScheme|extra_large_right}"

[Run]
Filename: "{sys}\reg.exe"; Parameters: "export ""hkcu\Control Panel\Cursors"" ""{app}\orig_cursors.reg"" /y"

[UninstallRun]
Filename: "{sys}\reg.exe"; Parameters: "import ""{app}\orig_cursors.reg"""; RunOnceId: "DelRegistryBackup"


[UninstallDelete]
Type: files; Name: "{app}\orig_cursors.reg"

[Code]
function CursorScheme(Kind: String): String;
var
    cursor_scheme: String;
begin
    cursor_scheme :=
        '{app}\cursors\{kind}\arrow.cur, ' +
        '{app}\cursors\{kind}\helpsel.cur, ' +
        '{app}\cursors\{kind}\working.ani, ' +
        '{app}\cursors\{kind}\busy.ani, ' +
        ', ' +
        ', ' +
        '{app}\cursors\{kind}\pen.cur, ' +
        '{app}\cursors\{kind}\unavail.cur, ' +
        '{app}\cursors\{kind}\ns.cur, ' +
        '{app}\cursors\{kind}\ew.cur, ' +
        '{app}\cursors\{kind}\nwse.cur, ' +
        '{app}\cursors\{kind}\nesw.cur, ' +
        '{app}\cursors\{kind}\move.cur, ' +
        '{app}\cursors\{kind}\up.cur, ' +
        '{app}\cursors\{kind}\link.cur ';

    StringChangeEx(cursor_scheme, '{app}', ExpandConstant('{app}'), False);
    StringChangeEx(cursor_scheme, '{kind}', Kind, False);
    Result := cursor_scheme;
end;
