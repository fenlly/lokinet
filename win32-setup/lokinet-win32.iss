; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Lokinet"
#define MyAppVersion "0.5.2"
#define MyAppPublisher "Loki Project"
#define MyAppURL "https://loki.network"
#define MyAppExeName "lokinetui.exe"
; change this to avoid compiler errors  -despair
#ifndef DevPath
#define DevPath "D:\dev\external\llarp\"
#endif
#include <idp.iss>
#include "version.txt"

; see ../LICENSE

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{11335EAC-0385-4C78-A3AA-67731326B653}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
#ifndef RELEASE
AppVerName={#MyAppName} {#MyAppVersion}-dev
#else
AppVerName={#MyAppName} {#MyAppVersion}
#endif
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppPublisher}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile={#DevPath}LICENSE
OutputDir={#DevPath}win32-setup
OutputBaseFilename=lokinet-win32
Compression=lzma2/ultra64
SolidCompression=yes
VersionInfoVersion=0.5.2
VersionInfoCompany=Loki Project
VersionInfoDescription=LokiNET for Microsoft� Windows� NT�
#ifndef RELEASE
VersionInfoTextVersion=0.5.2-dev-{#VCSRev}
VersionInfoProductTextVersion=0.5.2-dev-{#VCSRev}
#else
VersionInfoTextVersion=0.5.2
VersionInfoProductTextVersion=0.5.2 ({#Codename})
#endif
VersionInfoProductName=LokiNET
VersionInfoProductVersion=0.5.2
InternalCompressLevel=ultra64
MinVersion=0,5.0
ArchitecturesInstallIn64BitMode=x64
VersionInfoCopyright=Copyright �2018-2019 Loki Project

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
; only one of these is installed
#ifdef SINGLE_ARCH
Source: "{#DevPath}build\lokinet.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}build\liblokinet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "{tmp}\dbghelp64.dll"; DestName: "dbghelp.dll"; DestDir: "{app}"; Flags: ignoreversion external
#else
Source: "{#DevPath}build\lokinet.exe"; DestDir: "{app}"; Flags: ignoreversion 32bit; Check: not IsWin64
Source: "{#DevPath}build\liblokinet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion 32bit; Check: not IsWin64
Source: "{tmp}\dbghelp32.dll"; DestName: "dbghelp.dll"; DestDir: "{app}"; Flags: ignoreversion external; Check: not IsWin64
Source: "{#DevPath}build64\lokinet.exe"; DestDir: "{app}"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "{#DevPath}build64\liblokinet-shared.dll"; DestDir: "{app}"; Flags: ignoreversion 64bit; Check: IsWin64
Source: "{tmp}\dbghelp64.dll"; DestDir: "{app}"; DestName: "dbghelp.dll"; Flags: ignoreversion external; Check: IsWin64
#endif
; UI has landed!
#ifndef RELEASE
Source: "{#DevPath}ui-win32\bin\debug\lokinetui.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\debug\lokinetui.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\debug\lokinetui.pdb"; DestDir: "{app}"; Flags: ignoreversion
#else
Source: "{#DevPath}ui-win32\bin\release\lokinetui.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\release\lokinetui.exe.config"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}ui-win32\bin\release\lokinetui.pdb"; DestDir: "{app}"; Flags: ignoreversion
#endif
; eh, might as well ship the 32-bit port of everything else
Source: "{#DevPath}build\testAll.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}build\lokinet-rcutil.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "{#DevPath}LICENSE"; DestDir: "{app}"; Flags: ignoreversion
; delet this after finishing setup, we only need it to extract the drivers
; and download an initial RC. The UI has its own bootstrap built-in!
Source: "lokinet-bootstrap.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "{tmp}\7z.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall external
; if nonexistent, then inet6 was already installed
Source: "{tmp}\inet6.7z"; DestDir: "{app}"; Flags: ignoreversion external deleteafterinstall skipifsourcedoesntexist; MinVersion: 0,5.0; OnlyBelowVersion: 0,5.1
; Copy the correct tuntap driver for the selected platform
Source: "{tmp}\tuntapv9.7z"; DestDir: "{app}"; Flags: ignoreversion external deleteafterinstall skipifsourcedoesntexist; OnlyBelowVersion: 0, 6.0
Source: "{tmp}\tuntapv9_n6.7z"; DestDir: "{app}"; Flags: ignoreversion external deleteafterinstall skipifsourcedoesntexist; MinVersion: 0,6.0

; NOTE: Don't use "Flags: ignoreversion" on any shared system files
Source: "regdbhelper.dll"; Flags: dontcopy

; build only if we have the 32-bit bins as well
; (i.e. *not* a Travis CI build, travis isn't expected to have these around)
#ifndef SINGLE_ARCH
Source: "C:\Windows\Fonts\iosevka-term-bold.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-bolditalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-boldoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Bold Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralight.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralightitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-extralightoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Extralight Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavy.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavyitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-heavyoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Heavy Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-italic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-light.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-lightitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-lightoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Light Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-medium.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-mediumitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-mediumoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Medium Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-oblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-regular.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thin.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thinitalic.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin Italic"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Windows\Fonts\iosevka-term-thinoblique.ttf"; DestDir: "{fonts}"; FontInstall: "Iosevka Term Thin Oblique"; Flags: onlyifdoesntexist uninsneveruninstall
#endif

[UninstallDelete]
Type: filesandordirs; Name: "{app}\tap-windows*"
Type: filesandordirs; Name: "{app}\inet6_driver"; MinVersion: 0,5.0; OnlyBelowVersion: 0,5.1
Type: filesandordirs; Name: "{userappdata}\.lokinet"

[UninstallRun]
Filename: "{app}\tap-windows-9.21.2\remove.bat"; WorkingDir: "{app}\tap-windows-9.21.2"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; RunOnceId: "RemoveTap"; MinVersion: 0,6.0
Filename: "{app}\tap-windows-9.9.2\remove.bat"; WorkingDir: "{app}\tap-windows-9.9.2"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; RunOnceId: "RemoveTap"; OnlyBelowVersion: 0,6.0

[Dirs]
Name: "{userappdata}\.lokinet"

[Code]
var 
TapInstalled: Boolean;

function reg_query_helper(): Integer;
external 'reg_query_helper@files:regdbhelper.dll cdecl setuponly';

procedure CurStepChanged(CurStep: TSetupStep);
var
  Version: TWindowsVersion;
begin
  if CurStep = ssPostInstall then
  begin
  GetWindowsVersionEx(Version);
  if Version.NTPlatform and (Version.Major = 5) and (Version.Minor = 0) and (FileExists(ExpandConstant('{tmp}\inet6.7z')) = true) then
     // I need a better message...
    MsgBox('Restart your computer, then set up IPv6 in Network Connections. [Adapter] > Properties > Install... > Protocol > Microsoft IPv6 Driver...', mbInformation, MB_OK);
  end;
end;

function IsTapInstalled(): Boolean;
begin
Result := TapInstalled;
end;

procedure InitializeWizard();
var
  Version: TWindowsVersion;
begin
  GetWindowsVersionEx(Version);
  // if we already have a generic openvpn tap driver installed, then skip all the downloading
  // lokinet is coded to enumerate all generic tap virtual adapters and use the first free device
if (reg_query_helper() = 0) then
begin
TapInstalled := false;
end
else
begin
TapInstalled := true;
end;

if (reg_query_helper() = 0) then
begin
  if Version.NTPlatform and
     (Version.Major < 6) then
  begin
    // Windows 2000, XP, .NET Svr 2003
    // these have a horribly crippled WinInet that issues TLSv1-RSA-SHA1-Triple-DES as its most secure
    // cipher suite
    idpAddFile('http://www.rvx86.net/files/tuntapv9.7z', ExpandConstant('{tmp}\tuntapv9.7z'));
  end
  else
  begin
    // current versions of windows :-)
    // (Arguably, one could pull this from any of the forks.)
    idpAddFile('https://snowlight.net/loki/win32-dist/tap-windows-9.21.2.7z', ExpandConstant('{tmp}\tuntapv9_n6.7z'));
  end;
  // Windows 2000 only, we need to install inet6 separately
  if (FileExists(ExpandConstant('{sys}\drivers\tcpip6.sys')) = false) and (Version.Major = 5) and (Version.Minor = 0) then
  begin
    idpAddFile('http://www.rvx86.net/files/inet6.7z', ExpandConstant('{tmp}\inet6.7z'));
  end;
  end;
    idpAddFile('http://www.rvx86.net/files/7z.exe', ExpandConstant('{tmp}\7z.exe'));
    idpAddFile('http://www.rvx86.net/files/dbghelp32.dll', ExpandConstant('{tmp}\dbghelp32.dll'));
    idpAddFile('http://www.rvx86.net/files/dbghelp64.dll', ExpandConstant('{tmp}\dbghelp64.dll'));
    idpDownloadAfter(wpReady);
end;

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon; OnlyBelowVersion: 0, 6.1
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: quicklaunchicon; MinVersion: 0, 6.1

[Run]
Filename: "{app}\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
; wait until either one or two of these terminates
Filename: "{tmp}\7z.exe"; Parameters: "x tuntapv9.7z"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract TUN/TAP-v9 driver"; StatusMsg: "Extracting driver..."; OnlyBelowVersion: 0, 6.0
Filename: "{tmp}\7z.exe"; Parameters: "x tuntapv9_n6.7z"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract TUN/TAP-v9 driver"; StatusMsg: "Extracting driver..."; MinVersion: 0, 6.0
Filename: "{tmp}\7z.exe"; Parameters: "x inet6.7z"; WorkingDir: "{app}"; Flags: skipifdoesntexist runascurrentuser waituntilterminated skipifdoesntexist; Description: "extract inet6 driver"; StatusMsg: "Extracting IPv6 driver..."; MinVersion: 0, 5.0; OnlyBelowVersion: 0, 5.1
Filename: "{tmp}\lokinet-bootstrap.exe"; Parameters:"https://seed.lokinet.org/bootstrap.signed {userappdata}\.lokinet\bootstrap.signed"; WorkingDir: "{app}"; Flags: runascurrentuser waituntilterminated; Description: "bootstrap dht"; StatusMsg: "Downloading initial RC..."
; then ask to install drivers
Filename: "{app}\tap-windows-9.9.2\install.bat"; WorkingDir: "{app}\tap-windows-9.9.2\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install TUN/TAP-v9 driver"; StatusMsg: "Installing driver..."; OnlyBelowVersion: 0, 6.0; Check: not IsTapInstalled
Filename: "{app}\tap-windows-9.21.2\install.bat"; WorkingDir: "{app}\tap-windows-9.21.2\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install TUN/TAP-v9 driver"; StatusMsg: "Installing driver..."; MinVersion: 0, 6.0; Check: not IsTapInstalled
; install inet6 if not present. (I'd assume netsh displays something helpful if inet6 is already set up and configured.)
; if it doesn't exist, then the inet6 driver appears to be installed
Filename: "{app}\inet6_driver\setup\hotfix.exe"; Parameters: "/m /z"; WorkingDir: "{app}\inet6_driver\setup\"; Flags: runascurrentuser waituntilterminated skipifdoesntexist; Description: "Install IPv6 driver"; StatusMsg: "Installing IPv6..."; OnlyBelowVersion: 0, 5.1;  Check: not FileExists(ExpandConstant('{sys}\drivers\tcpip6.sys'))
Filename: "{sys}\netsh.exe"; Parameters: "int ipv6 install"; Flags: runascurrentuser waituntilterminated; Description: "install ipv6 on whistler"; StatusMsg: "Installing IPv6..."; MinVersion: 0,5.1; OnlyBelowVersion: 0,6.0