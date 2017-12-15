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
echo Building...
call build.cmd %1
echo Pushing...
call push-to-registry.cmd %1
echo Deploying...
call deploy.cmd %1

:end
