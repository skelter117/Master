# Replace '' with the username
$domainUsername = " "

$targetComputer = Read-Host "Enter the IP address or hostname of the target computer"

# Provide credentials to access the target computer
$credential = Get-Credential -Credential $domainUsername

try {
    # Get Security events remotely for unsuccessful logon attempts
    $unsuccessfulLogons = Get-WinEvent -ComputerName $targetComputer -Credential $credential -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 50 |
    Select-Object -Property TimeCreated, @{Name='Username'; Expression={$_.Properties[5].Value}}, @{Name='IPAddress'; Expression={$_.Properties[18].Value}}

    Write-Host "Last 50 Unsuccessful Logon Attempts:"
    if ($unsuccessfulLogons) {
        $unsuccessfulLogons | Format-Table -AutoSize
    } else {
        Write-Host "No unsuccessful logon attempts found."
    }

    # Get Security events remotely for successful logon attempts
    $successfulLogons = Get-WinEvent -ComputerName $targetComputer -Credential $credential -FilterHashtable @{LogName='Security'; Id=4624} -MaxEvents 100 |
    Select-Object -Property TimeCreated, @{Name='Username'; Expression={$_.Properties[5].Value}}, @{Name='IPAddress'; Expression={$_.Properties[18].Value}}

    Write-Host "`nLast 100 Successful Logon Attempts:"
    if ($successfulLogons) {
        $successfulLogons | Format-Table -AutoSize
    } else {
        Write-Host "No successful logon attempts found."
    }
} catch {
    Write-Host "Error: $_"
}
