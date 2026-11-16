import socket, re

localIP = "127.0.0.1"
localPort = 21000
bufferSize = 1024

UDPServerSocket = socket.socket(family=socket.AF_INET, type=socket.SOCK_DGRAM)

UDPServerSocket.bind((localIP, localPort))

print("UDP Server up and listening...")

while(True):
    bytesAddressPair = UDPServerSocket.recvfrom(bufferSize)
    expression = bytesAddressPair[0].decode()
    client_address = bytesAddressPair[1]

    num1, num2 = re.split('\+|-|\*|/|%', expression.replace(' ', ''))
    num1 = float(num1)
    num2 = float(num2)

    result = 0

    if '+' in expression:
        result = num1 + num2
    elif '-' in expression:
        result = num1 - num2
    elif '*' in expression:
        result = num1 * num2
    elif '/' in expression:
        if num2 == 0:
            result = 'Division by zero.'
        else:
            result = num1 / num2
    elif '%' in expression:
        result = num1 % num2
    else:
        result = 'Invalid expression.'

    print("Equation from client ", client_address, ":", expression)
    print("Result to client:", result)

    UDPServerSocket.sendto(str(result).encode(), client_address)

UDPServerSocket.close()