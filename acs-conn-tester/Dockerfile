FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803

ARG source
WORKDIR /app
COPY ${source:-obj/Docker/publish} .
ENTRYPOINT ["dotnet", "acs-conn-test.dll"]
