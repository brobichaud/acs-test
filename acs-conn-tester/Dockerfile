FROM microsoft/dotnet:2.0-runtime-nanoserver-1709
#FROM microsoft/dotnet:2.0-runtime-nanoserver-sac2016

# fixes DNS issues in Windows Containers
# powershell approach
#RUN powershell Set-Service dnscache -StartupType disabled
#RUN powershell Stop-Service dnscache
#RUN powershell New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxCacheTtl -Value 0 -Type DWord
#RUN powershell New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxNegativeCacheTtl -Value 0 -Type DWord
#RUN powershell Restart-Service dnscache
# command line approach
#USER containeradministrator
#RUN cmd sc config dnscache start=disabled
#RUN cmd sc stop dnscache
#RUN cmd reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxCacheTtl /t REG_DWORD /d 0 /f
#RUN cmd reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxNegativeCacheTtl /t REG_DWORD /d 0 /f
#RUN cmd net stop dnscache
#RUN cmd net start dnscache
#USER containeruser

ARG source
WORKDIR /app
COPY ${source:-obj/Docker/publish} .
ENTRYPOINT ["dotnet", "acs-conn-test.dll"]
