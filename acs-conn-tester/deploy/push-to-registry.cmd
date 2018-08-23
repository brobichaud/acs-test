@echo off
rem Creates a tagged version and pushes to the private registry
:: Handle command line arguments
if /I "%1"=="-?" goto help
if /I "%1"=="/?" goto help
if /I "%1"=="" goto help
if /I "%CLOUD_REG_PWD%"=="" goto missingpwd
goto begin

:help
echo.
echo You must specify an image tag version
echo.
goto end

:missingpwd
echo.
echo ERROR: You must set the environment variable CLOUD_REG_PWD to be your registry password
echo.
goto end

:begin
set CLOUD_REG_NAME=discovercloud
docker login %CLOUD_REG_NAME%.azurecr.io -u %CLOUD_REG_NAME% -p %CLOUD_REG_PWD%

::push acs-conn-test
docker stop acs-conn-test
docker rm acs-conn-test
docker rmi acs-conn-test:%1
docker rmi %CLOUD_REG_NAME%.azurecr.io/acs-conn-test:%1
docker tag acs-conn-test:latest acs-conn-test:%1
docker tag acs-conn-test:%1 %CLOUD_REG_NAME%.azurecr.io/acs-conn-test:%1
docker push %CLOUD_REG_NAME%.azurecr.io/acs-conn-test:%1

:end
