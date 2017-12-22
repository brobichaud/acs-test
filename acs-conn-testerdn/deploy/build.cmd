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

docker stop acs-conn-testdn
docker rm acs-conn-testdn
docker rmi acs-conn-testdn:%1
docker build -t acs-conn-testdn .
docker tag acs-conn-testdn acs-conn-testdn:%1
echo Created acs-conn-testdn:%1
docker image prune -f

cd %SCRIPT_PATH%

:end
