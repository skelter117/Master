$target = Read-Host "Enter the IP or Hostname"
$securityLog = Get-WinEvent -LogName Security -MaxEvents 10 -FilterXPath "*[System[(Level=2 or Level=3)]]" -ComputerName $target
$systemLog = Get-WinEvent -LogName System -MaxEvents 10 -FilterXPath "*[System[(Level=2 or Level=3)]]" -ComputerName $target
$applicationLog = Get-WinEvent -LogName Application -MaxEvents 10 -FilterXPath "*[System[(Level=2 or Level=3)]]" -ComputerName $target
$setupLog = Get-WinEvent -LogName Setup -MaxEvents 10 -FilterXPath "*[System[(Level=2 or Level=3)]]" -ComputerName $target

function Format-Event($event) {
    $event | Select-Object Id, TimeCreated, Message
}

Write-Host "Security:"
$securityLog | ForEach-Object { Format-Event $_ } | Format-Table -AutoSize
Write-Host "System:"
$systemLog | ForEach-Object { Format-Event $_ } | Format-Table -AutoSize
Write-Host "Application:"
$applicationLog | ForEach-Object { Format-Event $_ } | Format-Table -AutoSize
Write-Host "Setup:"
$setupLog | ForEach-Object { Format-Event $_ } | Format-Table -AutoSize
