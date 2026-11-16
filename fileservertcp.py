import socket, os

server_address = ('127.0.0.1', 20001)

server_socket = socket.socket(family=socket.AF_INET, type=socket.SOCK_STREAM)

server_socket.bind(server_address)

server_socket.listen(1)

print("Server listening for incoming connections....")

while True:
    client_socket, client_address = server_socket.accept()
    print("Accepted connection from client: ", client_address)

    file_name = client_socket.recv(1024).decode()

    print("Recieved file name = ", file_name)

    if os.path.exists(file_name):
        file = open(file_name, 'rb')
        file_contents = file.read()
        client_socket.send(file_contents)
    else:
        client_socket.send(b'File not found')

    client_socket.close()