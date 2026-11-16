import socket

server_address = ('127.0.0.1', 20001)

client_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_STREAM)

client_socket.connect(server_address)

file_name = str(input("Enter file name:"))

client_socket.send(file_name.encode())

file_contents = client_socket.recv(1024).decode()

if file_contents == b'File not found':
    print("File not found in the error")
else:
    print(file_contents)