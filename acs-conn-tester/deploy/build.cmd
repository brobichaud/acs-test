@echo off
:: Handle command line arguments
if /I "%1"=="-?" goto help
if /I "%1"=="/?" goto help
if /I "%1"=="" goto help
goto begin

:help
echo.
echo You must specify an image tag version
echo.
goto end

:begin
set SCRIPT_PATH=%~dp0
cd ..\..
msbuild acs-conn-test.sln "/p:Configuration=Release;Platform=Any CPU" /t:Rebuild /consoleloggerparameters:verbosity=minimal

docker rmi acs-conn-test:%1
docker tag acs-conn-test:latest acs-conn-test:%1
echo Created acs-conn-test:%1
docker image prune -f

cd %SCRIPT_PATH%

:end
