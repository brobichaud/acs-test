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
echo Deleting acs-conn-test container images...
echo.
rem NOTE this does NOT delete the images in the private registry, only the local copies/tags
docker rmi %CLOUD_REG_NAME%/acs-conn-test:%1
docker rmi acs-conn-test:%1

:end
