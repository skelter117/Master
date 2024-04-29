$computerName = Read-Host "Enter IP address or hostname of the target computer"
$senderName = Read-Host "Enter your name"
$message = Read-Host "Enter the message"

Invoke-Command -ComputerName $computerName -ScriptBlock {
    param($senderName, $message)
    msg.exe * /SERVER:$env:COMPUTERNAME "$senderName says: $message"
} -ArgumentList $senderName, $message
