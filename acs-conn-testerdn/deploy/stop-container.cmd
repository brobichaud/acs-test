@echo off
echo Stopping acs-conn-testdn container...
docker stop acs-conn-testdn
docker rm acs-conn-testdn
