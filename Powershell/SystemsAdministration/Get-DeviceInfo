$targetHostname = Read-Host "Enter the hostname you want to check on:"
$targetIP = [System.Net.Dns]::GetHostAddresses($targetHostname) | Where-Object { $_.AddressFamily -eq 'InterNetwork' } | Select-Object -First 1

if ($targetIP -eq $null) {
    Write-Host "Hostname not found or does not have an IP address."
} else {
    $computerSystemInfo = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_ComputerSystem
    $memoryInfo = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_PhysicalMemory
    $diskInfo = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_LogicalDisk | Where-Object { $_.DeviceID -eq "C:" }
    $processorInfo = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_Processor
    $operatingSystemInfo = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_OperatingSystem
    $networkAdapter = Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
    $windowsVersion = $operatingSystemInfo.Caption

    Write-host "$targetip "
    Write-Host "Device Model is: " $computerSystemInfo.Model
    Write-Host "Motherboard Model is: " $computerSystemInfo.BaseBoard.Model

    if ($computerSystemInfo.SerialNumber) {
        Write-Host "Serial Number is: " $computerSystemInfo.SerialNumber
    } else {
        Write-Host "Serial Number is: Not Available"
    }

    $ramCapacity = ($memoryInfo | Measure-Object -Property Capacity -Sum).Sum / 1GB
    Write-Host "Total RAM Capacity (GB): $ramCapacity"

    $diskCapacity = $diskInfo.Size / 1GB
    Write-Host "HDD/SSD Size (C: drive) (GB): $diskCapacity"

    $usedDiskSpace = ($diskInfo.Size - $diskInfo.FreeSpace) / 1GB
    Write-Host "Used Disk Space (C: drive) (GB): $usedDiskSpace"

    Write-Host "Processor Name is: " $processorInfo.Name
    Write-Host "Processor Description: " $processorInfo.Description

    $lastBootUpTime = [System.Management.ManagementDateTimeConverter]::ToDateTime($operatingSystemInfo.LastBootUpTime)
    $uptime = (Get-Date) - $lastBootUpTime

    if ($networkAdapter) {
        $macAddress = $networkAdapter.MACAddress
        Write-Host "MAC Address: $macAddress"
    } else {
        Write-Host "MAC Address: Not Available"
    }

    Write-Host "Windows Version is: $windowsVersion"
    Write-Host "Device has not been turned off for: $($uptime.Days) days $($uptime.Hours) hours $($uptime.Minutes) minutes"

    $currentLoggedUser = (Get-WmiObject -Namespace "root\cimv2" -ComputerName $targetIP -Class Win32_ComputerSystem).UserName
    Write-Host "Currently logged-in user: $currentLoggedUser"
}
