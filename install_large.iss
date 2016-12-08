; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Mouse Toggle"
#define MyAppVersion "0.1"
#define MyAppPublisher "russiandesman"
#define MyAppExeName "mouse_toggle.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{33F370D1-B525-43D2-85D9-4EA71C8AA20A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=MouseToggle_LargeCursor
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: {#MyAppExeName};           DestDir: "{app}"; Flags: ignoreversion

Source: "large_left\aero_arrow_l_left.cur";    DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_busy_l_left.ani";     DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_ew_l.cur";            DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_helpsel_l_left.cur";  DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_link_l_left.cur";     DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_move_l.cur";          DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_nesw_l.cur";          DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_ns_l.cur";            DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_nwse_l.cur";          DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_pen_l_left.cur";      DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_unavail_l.cur";       DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_up_l.cur";            DestDir: "{app}\cursors_l"; Flags: ignoreversion
Source: "large_left\aero_working_l_left.ani";  DestDir: "{app}\cursors_l"; Flags: ignoreversion

Source: "large_right\aero_arrow_l.cur";        DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_busy_l.ani";         DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_ew_l.cur";           DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_helpsel_l.cur";      DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_link_l.cur";         DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_move_l.cur";         DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_nesw_l.cur";         DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_ns_l.cur";           DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_nwse_l.cur";         DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_pen_l.cur";          DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_unavail_l.cur";      DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_up_l.cur";           DestDir: "{app}\cursors_r"; Flags: ignoreversion
Source: "large_right\aero_working_l.ani";      DestDir: "{app}\cursors_r"; Flags: ignoreversion

Source: "orig_cursors.reg";                   DestDir: "{app}"; Flags: ignoreversion

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
                                                            
[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]

Root: HKCU; Subkey: "Control Panel\Cursors\Schemes"; ValueType: expandsz; ValueName: "mouse_toggle_scheme_left"; ValueData: \
"{app}\cursors_l\aero_arrow_l_left.cur, \
{app}\cursors_l\aero_helpsel_l_left.cur, \
{app}\cursors_l\aero_working_l_left.ani, \
{app}\cursors_l\aero_busy_l_left.ani, \
, \
, \
{app}\cursors_l\aero_pen_l_left.cur, \
{app}\cursors_l\aero_unavail_l.cur, \
{app}\cursors_l\aero_ns_l.cur, \
{app}\cursors_l\aero_ew_l.cur, \
{app}\cursors_l\aero_nwse_l.cur, \
{app}\cursors_l\aero_nesw_l.cur, \
{app}\cursors_l\aero_move_l.cur, \
{app}\cursors_l\aero_up_l.cur, \
{app}\cursors_l\aero_link_l_left.cur"; Flags: uninsdeletevalue

Root: HKCU; Subkey: "Control Panel\Cursors\Schemes"; ValueType: expandsz; ValueName: "mouse_toggle_scheme_right"; ValueData: \
"{app}\cursors_r\aero_arrow_l.cur, \
{app}\cursors_r\aero_helpsel_l.cur, \
{app}\cursors_r\aero_working_l.ani, \
{app}\cursors_r\aero_busy_l.ani, \
, \
, \
{app}\cursors_r\aero_pen_l.cur, \
{app}\cursors_r\aero_unavail_l.cur, \
{app}\cursors_r\aero_ns_l.cur, \
{app}\cursors_r\aero_ew_l.cur, \
{app}\cursors_r\aero_nwse_l.cur, \
{app}\cursors_r\aero_nesw_l.cur, \
{app}\cursors_r\aero_move_l.cur, \
{app}\cursors_r\aero_up_l.cur, \
{app}\cursors_r\aero_link_l.cur "; Flags: uninsdeletevalue

[Run]
Filename: "{sys}\reg.exe"; Parameters: "export ""hkcu\Control Panel\Cursors"" ""{app}\orig_cursors.reg"" /y"

[UninstallRun]
Filename: "{sys}\reg.exe"; Parameters: "import ""{app}\orig_cursors.reg"""
