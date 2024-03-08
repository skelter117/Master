# Replace ' ' with the your username
$domainUsername = " "  
$credential = Get-Credential -Credential $domainUsername

$unsuccessfulLogons = Get-WinEvent -Credential $credential -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 30 |
    Select-Object -Property TimeCreated, @{Name='Username'; Expression={$_.Properties[5].Value}}, @{Name='IPAddress'; Expression={$_.Properties[19].Value}}

Write-Host "Last 30 Unsuccessful Logon Attempts:"
if ($unsuccessfulLogons) {
    $unsuccessfulLogons | Format-Table -AutoSize
} else {
    Write-Host "No unsuccessful logon attempts found."
}

$successfulLogons = Get-WinEvent -Credential $credential -FilterHashtable @{LogName='Security'; Id=4624} -MaxEvents 30 |
    Select-Object -Property TimeCreated, @{Name='Username'; Expression={$_.Properties[5].Value}}, @{Name='IPAddress'; Expression={$_.Properties[18].Value}}

Write-Host "`nLast 30 Successful Logon Attempts:"
if ($successfulLogons) {
    $successfulLogons | Format-Table -AutoSize
} else {
    Write-Host "No successful logon attempts found."
}
