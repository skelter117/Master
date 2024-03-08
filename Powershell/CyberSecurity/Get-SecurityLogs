$target = Read-Host -Prompt "Enter the hostname or IP address of the target"

$credentials = Get-Credential

# Get Security events remotely
try {
    $events = Get-WinEvent -LogName Security -ComputerName $target -Credential $credentials -MaxEvents 30 -ErrorAction Stop
    $events
} catch {
    Write-Host "Error: $_"
}
