@echo off
git clone https://github.com/Microsoft/vcpkg.git vcpkg
cd vcpkg
mkdir downloads
copy nul downloads\AlwaysAllowDownloads
powershell.exe -NoProfile -ExecutionPolicy Bypass "& {& 'scripts\bootstrap.ps1'}"
vcpkg integrate install
vcpkg install boost:x64-windows

cd "%APPVEYOR_BUILD_FOLDER%"