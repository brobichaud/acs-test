@echo off
rem Creates a tagged version and pushes to the private registry
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
docker login %CLOUD_REG_NAME% -u %CLOUD_REG_USER% -p %CLOUD_REG_PWD%

::push acs-conn-testdn
docker stop acs-conn-testdn
docker rm acs-conn-testdn
docker rmi acs-conn-testdn:%1
docker rmi %CLOUD_REG_NAME%/acs-conn-testdn:%1
docker tag acs-conn-testdn:latest acs-conn-testdn:%1
docker tag acs-conn-testdn:%1 %CLOUD_REG_NAME%/acs-conn-testdn:%1
docker push %CLOUD_REG_NAME%/acs-conn-testdn:%1

:end
