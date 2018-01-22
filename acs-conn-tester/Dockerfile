FROM microsoft/dotnet:2.0-runtime-nanoserver-1709
#FROM microsoft/dotnet:2.0-runtime-nanoserver-sac2016

# mitigates DNS issues in Windows Containers (not for production use)
# approach1
#SHELL ["cmd", "/S", "/C"]
#RUN net stop dnscache
#RUN sc config dnscache start=disabled
# approach2
#SHELL ["cmd", "/S", "/C"]
#RUN net stop dnscache
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxCacheTtl /t REG_DWORD /d 0 /f
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxNegativeCacheTtl /t REG_DWORD /d 0 /f
#RUN net start dnscache
# on 1709 clusters there is a permissions issue with above approaches
# was advised wrapping the approaches with the below commands should work, does not seem to
#USER containeradministrator
#USER containeruser

ARG source
WORKDIR /app
COPY ${source:-obj/Docker/publish} .
ENTRYPOINT ["dotnet", "acs-conn-test.dll"]
