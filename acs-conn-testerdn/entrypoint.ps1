#
# This hack sets the DNS servers to the underlying nic of the container.
# The default DNS server fails with timeout errors, a known problem being worked on.
#

param(
   [string]$AppToRun="c:\app\acs-conn-testdn.exe"
)

# get the network adapter details
$adapter=Get-NetAdapter

# set DNS servers of the network adapter to known values
Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses 10.244.0.2

# run our app (yes, odd syntax)
& $AppToRun