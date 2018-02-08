netsh interface ip set dns 30 static 10.244.0.2

cd \app
dotnet acs-conn-test.dll
