FROM microsoft/dotnet-framework:4.7.1-windowsservercore-1709
#FROM microsoft/dotnet-framework:4.7.1-windowsservercore-ltsc2016

# fixes DNS issues in Windows Containers
#USER containeradministrator
# powershell approach
#SHELL ["powershell", "-command"]
#RUN Set-Service dnscache -StartupType disabled
#RUN Stop-Service dnscache
#RUN New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxCacheTtl -Value 0 -Type DWord
#RUN New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name MaxNegativeCacheTtl -Value 0 -Type DWord
#RUN Restart-Service dnscache
# command line approach
#SHELL ["cmd", "/S"", "/C"]
#RUN sc config dnscache start=disabled
#RUN sc stop dnscache
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxCacheTtl /t REG_DWORD /d 0 /f
#RUN reg add HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters /v MaxNegativeCacheTtl /t REG_DWORD /d 0 /f
#RUN net stop dnscache
#RUN net start dnscache
#USER containeruser

WORKDIR /app
COPY ./bin/Release .
ENTRYPOINT ["acs-conn-testdn.exe"]
