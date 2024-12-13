 $Hostname = Read-host "Enter the server you want to get update information for "
 Get-WUHistory -ComputerName $Hostname | select -first 10 | select kb,date,title,result
