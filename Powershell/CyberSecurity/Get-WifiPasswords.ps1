#Print out wifi passwords stored on local computer
netsh wlan show profiles | ForEach-Object { if ($_ -like "*ll User Profile*") { $ssid = $_.Split(":")[1].Trim(); netsh wlan show profile name="$ssid" key=clear | ForEach-Object { if ($_ -like "*Key Content*") { "$ssid : " + $_.Split(":")[1].Trim() } } } }
