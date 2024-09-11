Get-Nettcpconnection
function Block-IPPort {
    param (
        [string]$IpAddress,
        [int]$Port
    )

    $ruleName = "Block_IP_$IpAddress_Port_$Port"

    $existingRule = Get-NetFirewallRule -DisplayName $ruleName

    if ($existingRule -eq $null) {
        New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Protocol TCP -LocalPort $Port -RemoteAddress $IpAddress -Action Block
        Write-Host "Firewall rule created to block IP $IpAddress on port $Port."
    } else {
        Write-Host "Firewall rule already exists to block IP $IpAddress on port $Port."
    }
}

do {
    $connections = Get-NetTCPConnection

    $ipOrPort = Read-Host "Enter IP address or port number: Alternatively, press enter to pull all PID-Service associations"

    $matchingConnections = $connections | Where-Object { $_.LocalAddress -contains $ipOrPort -or $_.RemoteAddress -contains $ipOrPort -or $_.LocalPort -eq $ipOrPort -or $_.RemotePort -eq $ipOrPort }

    if ($matchingConnections) {
        foreach ($connection in $matchingConnections) {
            $processId = $connection.OwningProcess
            $service = (Get-WmiObject Win32_Service | Where-Object { $_.ProcessId -eq $processId }).DisplayName
            Write-Host "Process ID: $processId, Service: $service"

            $maliciousService = $service
            $maliciousProcessId = $processId
        }
    } else {
        Write-Host "No matching connections found."
    }

    $continue = Read-Host "Do you want to check another port number or IP address? (yes/no)"
} while ($continue -eq "yes")

if ($maliciousService -ne "" -and $maliciousProcessId -ne "") {
    $malicious = Read-Host "Do you believe the process ($maliciousProcessId) running $maliciousService is malicious and want to stop it? (yes/no)"

    if ($malicious -eq "yes") {
        $killProcess = Read-Host "Do you want to kill the process? (yes/no)"
        if ($killProcess -eq "yes") {
            Stop-Process -Id $maliciousProcessId
            Write-Host "Process $maliciousProcessId stopped."
        }
    }

    $denyIpPort = Read-Host "Do you want to deny the IP and port? (yes/no)"
    if ($denyIpPort -eq "yes") {
        Block-IPPort -IpAddress $ipOrPort -Port $portOrPort
    }
}
