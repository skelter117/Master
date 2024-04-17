#Mitigation response script to ping flood attack. Blocks icmp and attacker machine

$attackerIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -ne "Loopback Pseudo-Interface 1"}).IPAddress

New-NetFirewallRule -DisplayName "Block PingFlood from Attacker" -Direction Inbound -Protocol ICMPv4 -RemoteAddress $attackerIP -Action Block
