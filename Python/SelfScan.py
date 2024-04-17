import os
import sys
import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)


Host = socket.gethostbyname(socket.gethostname())
print("Host IP Address is: ", Host)

Ports = {20, 21, 22, 23, 25, 49, 53, 67, 68, 69, 80, 110, 111, 115, 119, 123, 135, 139, 143, 389, 443, 445, 514, 993, 995, 1723, 3306, 3389, 8080}

def PortScanner(Ports):
    for Port in Ports:
        if s.connect_ex((Host, Port)):
            print("Port {} is closed".format(Port))
        else:
            print("Port {} is open".format(Port))

PortScanner(Ports)
