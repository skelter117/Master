function Get-TopProcesses {
    $processStats = @{}
    $processes = Get-Process
    foreach ($p in $processes) {
        $processStats[$p.Id] = [PSCustomObject]@{
            ProcessName = $p.ProcessName
            CPUStart    = $p.CPU
        }
    }
    return $processStats
}

$prevCPUStats = Get-TopProcesses
$firstCycle = $true

while ($true) {
    cls

    Write-Host ("{0,-8} {1,-8} {2,-12} {3,-12} {4,-40} {5}" -f "PID", "CPU(%)", "Mem(MB)", "CPU Time", "Command", "Name")
    Write-Host ("-" * 100)

    $currentCPUStats = Get-TopProcesses
    $processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 25

    $processInfo = @()
    foreach ($proc in $processes) {
        if ($prevCPUStats.ContainsKey($proc.Id)) {
            $prevStat = $prevCPUStats[$proc.Id]
            $currentStat = $currentCPUStats[$proc.Id]
            $cpuTimeDelta = $currentStat.CPUStart - $prevStat.CPUStart

            $cpuPercent = [math]::Round(($cpuTimeDelta / 1), 2)
            $cpuPercent = if ($cpuPercent -gt 100) { 100 } else { $cpuPercent }

            $mem = [math]::Round(($proc.WorkingSet64 / 1MB), 1)
            $cpuTime = [math]::Round($proc.CPU, 2)

            $commandLine = try { 
                $proc.Path 
            } catch {
                "N/A"
            }

            $processInfo += [PSCustomObject]@{
                PID        = $proc.Id
                CPUPercent = $cpuPercent
                Mem        = $mem
                CPUTime    = $cpuTime
                Command    = $commandLine
                Name       = $proc.ProcessName
            }
        }
    }

    $processInfo | Sort-Object CPUPercent -Descending | ForEach-Object {
        Write-Host ("{0,-8} {1,-8} {2,-12} {3,-12} {4,-40} | {5}" -f $_.PID, "$($_.CPUPercent)%", $_.Mem, $_.CPUTime, $_.Command, $_.Name)
    }

    $prevCPUStats = $currentCPUStats

    if ($firstCycle) {
        Start-Sleep -Seconds 6
        $firstCycle = $false
    } else {
        Start-Sleep -Seconds 8
    }
}
