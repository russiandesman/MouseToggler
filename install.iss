#define MyAppName "Mouse Toggle"
#define MyAppVersion "0.2"
#define MyAppPublisher "russiandesman"
#define MyAppExeName "mouse_toggle.exe"
#define Sch "Control Panel\Cursors\Schemes"

[Setup]
AppId={{e1ae9280-7962-4172-8c6c-b4bf751aa9e2}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=MouseToggle_setup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: {#MyAppExeName};           DestDir: "{app}"; Flags: ignoreversion
Source: "cursors\*";               DestDir: "{app}\cursors"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{commonprograms}\{#MyAppName} normal"; Filename: "{app}\{#MyAppExeName}"; Parameters: "n"
Name: "{commonprograms}\{#MyAppName} large";  Filename: "{app}\{#MyAppExeName}"; Parameters: "l"
Name: "{commonprograms}\{#MyAppName} XL";     Filename: "{app}\{#MyAppExeName}"; Parameters: "xl"
Name: "{commondesktop}\{#MyAppName} normal"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "n"
Name: "{commondesktop}\{#MyAppName} large";  Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "l"
Name: "{commondesktop}\{#MyAppName} XL";     Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; Parameters: "xl"

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
Filename: "{sys}\reg.exe"; Parameters: "import ""{app}\orig_cursors.reg"""

[UninstallDelete]
Type: files; Name: "{app}\orig_cursors.reg"

[Code]
function CursorScheme(Kind: String): String;
var
    template, tmp: String;
const
    template =
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

begin
    tmp := StringReplace(template, '{app}', ExpandConstant('{app}'), [rfReplaceAll]);
    Result := StringReplace(tmp, '{kind}', Kind, [rfReplaceAll]);
end;
