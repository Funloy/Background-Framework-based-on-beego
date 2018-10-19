@echo off 
 net session >nul 2>&1
if not "%errorLevel%" == "0" (
  echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
  echo UAC.ShellExecute "%~s0", "%*", "", "runas", 1 >> "%temp%\getadmin.vbs"
  "%temp%\getadmin.vbs"
  exit /b 2
)
set mongobin=%~dp0
 
::在mongodb文件夹下建立data,log文件夹
md  %mongobin%data
md  %mongobin%log

cd %mongobin%bin
set path==%path%;%mongobin%bin
 
mongod --install  --serviceName maiyajiadb  --serviceDisplayName maiyajiadb --dbpath "%mongobin%data" --logpath "%mongobin%log\MongoDB.log" 
 
net start maiyajiadb
 
@echo Install finish!
pause