while ($true) {
    $User = Read-Host "Enter the username you would like to find password reset for (or type 'exit' to quit)"
    
    if ($User -eq 'exit') {
        break
    }

    try {
        $UserInfo = Get-ADUser $User -Properties * | Select-Object PasswordLastSet
        
        if ($UserInfo) {
            Write-Host "$User's password was last set on: $($UserInfo.PasswordLastSet)"
        } else {
            Write-Host "User '$User' not found."
        }
    } catch {
        Write-Host "An error occurred: $_"
    }
}
