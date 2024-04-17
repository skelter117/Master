#Dont have Netcat or kali? no problem!

import socket

Home = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
IpAddress = "127.0.0.1"
Port = int(input("Enter the port number to listen on: "))

Home.bind((IpAddress, Port))
Home.listen(1)

print("successfully listening on port:" + str(Port))

while True:
  try:
    ClientSocket, ClientAdress = Home.accept()
    print("Accepted connection from:", ClientAdress)
    ClientSocket.close()
  except socket.error as e:
    print("Failed to accept:", e)
