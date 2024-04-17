Invoke-WebRequest -Uri "https://live.sysinternals.com/Tools/SysinternalsSuite.zip" -OutFile "$env:TEMP\SysinternalsSuite.zip"
Expand-Archive -Path "$env:TEMP\SysinternalsSuite.zip" -DestinationPath "$env:USERPROFILE\Desktop\SysInternalsSuite"
Remove-Item -Path "$env:TEMP\SysinternalsSuite.zip" -Force
