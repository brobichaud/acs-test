#FROM microsoft/dotnet-framework:4.7.1-windowsservercore-1709
FROM microsoft/dotnet-framework:4.7.1-windowsservercore-ltsc2016

# mitigation of DNS issues in Windows Containers
# approach2 works with Server 1607 but is not recommended in production environments
SHELL ["cmd", "/S", "/C"]
RUN net stop dnscache
RUN sc config dnscache start=disabled

WORKDIR /app
COPY ./bin/Release .
ENTRYPOINT ["acs-conn-testdn.exe"]



# mitigation of DNS issues in Windows Containers
# approach1 works with Server 1607 and is the recommended approach
#SHELL ["cmd", "/S", "/C"]
#RUN net stop dnscache
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxCacheTtl /t REG_DWORD /d 0 /f
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxNegativeCacheTtl /t REG_DWORD /d 0 /f
#RUN net start dnscache

# approach2 works with Server 1607 but is not recommended in production environments
#SHELL ["cmd", "/S", "/C"]
#RUN net stop dnscache
#RUN sc config dnscache start=disabled

# approach3 works with Server 1709 (servercore containers only, not nanoserver)
# powershell script to change DNS servers in container to one of the k8s DNS pods
#ENTRYPOINT ["powershell.exe", "c:\\app\\entrypoint.ps1 -AppToRun c:\\app\\acs-conn-testdn.exe"]
