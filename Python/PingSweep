#In case you dont have Nmap installed

import ipaddress
import socket

def validate_cidr(cidr):
    try:
        network = ipaddress.IPv4Network(cidr, strict=False)
        return network
    except ValueError:
        print('Invalid input')
        exit()

def check_available_addresses(network):
    available_addresses = []
    for ip in network.hosts():
        ip_str = str(ip)
        try:
            # Attempt to connect to the IP address on port 80 (HTTP)
            with socket.create_connection((ip_str, 80), timeout=1) as connection:
                available_addresses.append(ip_str)
        except OSError:
            pass
    return available_addresses

def main():
    cidr = input('Enter an address and range in CIDR notation: ')
    network = validate_cidr(cidr)
    available_addresses = check_available_addresses(network)

    if available_addresses:
        print('Available addresses:')
        for address in available_addresses:
            print(address)
    else:
        print('No available addresses')

if __name__ == "__main__":
    main()
