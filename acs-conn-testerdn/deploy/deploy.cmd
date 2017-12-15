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
echo Deploying acs-conn-testdn...
SimpleReplace 0 acs-conn-testdn:1.0 acs-conn-testdn:%1 acs-conn-test-dep.yaml temp-deploy-conn.yaml
SimpleReplace 0 DOCKER_REG_NAME %DOCKER_REG_NAME% temp-deploy-conn.yaml temp-deploy-conn.yaml
kubectl apply -f temp-deploy-conn.yaml --record
del /q temp-deploy-conn.yaml
echo.
kubectl rollout status deployment/dev-acs-conn-testdn

:end
