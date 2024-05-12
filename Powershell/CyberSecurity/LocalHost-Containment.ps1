$disableAdapters = Read-Host "Do you want to disable all network adapters? (yes/no) (This will kill the current remote connection!!)"

if ($disableAdapters -eq "yes") {
    Disable-NetAdapter -Name * -Confirm:$false
    Write-Host "All network adapters have been disabled."
}

$blockOutgoing = Read-Host "Do you want to block any and all outgoing connections at the host firewall? (yes/no) (This will prevent any and all communication except for the current RDP session)"

if ($blockOutgoing -eq "yes") {
    $ManagementIP = (Get-NetTCPConnection -State Established | Where-Object {$_.LocalPort -eq 3389}).RemoteAddress

    New-NetFirewallRule -DisplayName "Allow inbound RDP from current management IP" -Direction Inbound -LocalPort 3389 -Protocol TCP -RemoteAddress $ManagementIP -Action Allow -Enabled True -Verbose

    New-NetFirewallRule -DisplayName "Allow Outgoing RDP to management IP" -Direction Outbound -LocalPort 3389 -Protocol TCP -RemotePort 3389 -Action Allow -Enabled True -Verbose

    New-NetFirewallRule -DisplayName "Block ALL Outgoing Connections" -Direction Outbound -Action Block -Profile Any -Enabled True -Verbose

    Write-Host "All outgoing connections have been blocked at the host firewall. except the current RDP session for eradication purposes."
}
