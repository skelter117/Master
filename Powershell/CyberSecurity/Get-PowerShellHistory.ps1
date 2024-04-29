$users = Get-ChildItem -Path 'C:\Users' | Where-Object { $_.PSIsContainer -and $_.Name -ne 'Default' -and $_.Name -ne 'Public' } | Select-Object -ExpandProperty Name

foreach ($user in $users) {
    $history = Get-Content "C:\Users\$user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -ErrorAction SilentlyContinue
    
    Write-Host "User: $user"
    
    if ($history) {
        Write-Host "Command History:"
        $history
    } else {
        Write-Host "No command history found for $user."
    }
    
    Write-Host "---------------------"
}
