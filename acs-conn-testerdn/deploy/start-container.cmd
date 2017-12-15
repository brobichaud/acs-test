@echo off
rem Starts a container with a specified version
set VERS_TO_START=%1
if /I "%VERS_TO_START%"=="" set VERS_TO_START=latest
echo Starting acs-conn-testdn:%VERS_TO_START% container...
docker run -d --name acs-conn-testdn acs-conn-testdn:%VERS_TO_START%

:end
