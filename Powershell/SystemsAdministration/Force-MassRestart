#AI written script to force restart all devices. previous script had errors with function not imported. NOT TESTED

function Get-IPAddressInRange {
    param (
        [string]$Network
    )

    $subnet, $cidr = $Network.Split("/")

    $subnetMask = -bnot ([System.Convert]::ToInt32(('1' * $cidr + '0' * (32 - $cidr)), 2))
    $maskBytes = [System.BitConverter]::GetBytes($subnetMask)
    $subnetBytes = $maskBytes | ForEach-Object { $_ }

    $ipBytes = [System.Net.IPAddress]::Parse($subnet).GetAddressBytes()
    $networkBytes = $ipBytes | ForEach-Object -Begin { $i = 0 } -Process { $_ -band $subnetBytes[$i++] }

    $networkAddress = [System.Net.IPAddress]::Parse($networkBytes)
    $ipAddresses = @()

    for ($i = 1; $i -lt [math]::Pow(2, (32 - $cidr)) - 1; $i++) {
        $hostAddress = [System.Net.IPAddress]::Parse([System.BitConverter]::GetBytes([System.BitConverter]::ToInt32($networkBytes, 0) + $i))
        $ipAddresses += $hostAddress.ToString()
    }

    return $ipAddresses
}

$subnet = Read-Host "Enter the network in CIDR that you want to restart: "
$ipAddresses = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true -and $_.IPAddress -ne $null } | ForEach-Object { $_.IPAddress }

$subnetIPs = Get-IPAddressInRange -Network $subnet

$confirmRestart = Read-Host "The subnet you have chosen to restart is $subnet. Would you like to force restart all of these devices? (yes/no):"

if ($confirmRestart -eq "yes") {
    foreach ($ip in $ipAddresses) {
        if ((Test-Connection -ComputerName $ip -Count 1 -Quiet) -and ($subnetIPs -contains $ip)) {
            Restart-Computer -ComputerName $ip -Force
        }
    }
} elseif ($confirmRestart -eq "no") {
    Write-Host "Exiting without restarting devices."
} else {
    Write-Host "Invalid input. Exiting without restarting devices."
}
