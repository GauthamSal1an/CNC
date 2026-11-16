div = [1, 0, 0, 1]

bits = str(input("Enter message: "))
data = [int(bit) for bit in bits]
n = len(bits)
m = len(div)

cdata = data.copy()

if n < m:
    print("Invalid")
else:
    for i in range(m - 1):
        cdata.append(0)
    for i in range(n):
        if cdata[i] == 1:
            for j in range(m):
                cdata[i + j] ^= div[j]
    for i in range(n, n + m - 1):
        data.append(cdata[i])

error = int(input("Enter 0 if u want to introduce error and 1 if u dont want to:"))
if (error == 1):
    print("No error introduced")
else:
    pos = int(input("Enter pos where u want to introduce error: "))
    if (0 <= pos < len(data)):
        data[pos] ^= 1
        print("Error introduced")
    else:
        print("Invalid position")

for i in range(n):
    if data[i] == 1:
        for j in range(m):
            data[i + j] ^= div[j]

remainder = data[-(len(div) - 1):]
if any(remainder):
    print("Error detected.")
else:
    print("no error")