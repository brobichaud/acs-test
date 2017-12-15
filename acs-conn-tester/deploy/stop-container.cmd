@echo off
echo Stopping acs-conn-test container...
docker stop acs-conn-test
docker rm acs-conn-test
