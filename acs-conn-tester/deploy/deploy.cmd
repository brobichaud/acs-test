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
echo Deploying acs-conn-test...
SimpleReplace 0 acs-conn-test:1.0 acs-conn-test:%1 acs-conn-test-dep.yaml temp-deploy-conn.yaml
kubectl apply -f temp-deploy-conn.yaml --record
del /q temp-deploy-conn.yaml
echo.
kubectl rollout status deployment/dev-acs-conn-test

:end
