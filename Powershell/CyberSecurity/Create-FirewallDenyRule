$displayname = Read-Host "Enter the display name for this new rule: "
$Port = Read-Host "Enter the port you want to block: "
$IP = Read-Host "Enter the IP you want to block: "
try {
    New-NetFirewallRule -DisplayName "$displayname" -Direction Inbound -Protocol TCP -LocalPort $Port -RemoteAddress $IP -Action Block
} catch {
    Write-Host $_.Exception.Message
}
