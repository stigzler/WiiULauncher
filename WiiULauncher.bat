@echo off
REM WiiULauncher (Down n Dirty)
REM by stigzler 
REM e.g:
REM "C:\Arcade\Systems\Nintendo WiiU\Launchers\WiiULauncher.bat" "C:\Arcade\Systems\Nintendo WiiU\Emulators\Cemu\cemu_1.7.2\cemu.exe" "X:\Nintendo WiiU\Shortcuts\Star Fox Zero.lnk"
Set CemuExe=%1
Set ShortcutFile=%2
Set InitDir=%cd%

echo ShortcutFile: [%ShortcutFile%]
for %%E in (%ShortcutFile%) do set Shortcut=%%~nxE
echo Shortcut: [%Shortcut%]

REM Generate Shortcut Target:
cd /d %~dp0
echo set WshShell = WScript.CreateObject("WScript.Shell")>DecodeShortCut.vbs
echo set Lnk = WshShell.CreateShortcut(WScript.Arguments.Unnamed(0))>>DecodeShortCut.vbs
echo wscript.Echo Lnk.TargetPath>>DecodeShortCut.vbs
set vbscript=cscript //nologo DecodeShortCut.vbs
For /f "delims=" %%T in ( ' %vbscript% %ShortcutFile% ' ) do set target=%%T
del DecodeShortCut.vbs
Echo Target:[%target%]

REM Now Launch Game:
cd /d %~dp1
call %CemuExe% -f -g "%target%"

REM Reset to original Dir:
cd /d "%InitDir%"