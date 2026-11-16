data = input("Enter data to be stuffed: ")

def stuff(data):
    res = ""
    count = 0
    for bit in data:
        res += bit
        if bit == '1':
            count += 1
            if count == 5:
                res += '0'
                count = 0
        else:
            count = 0
    return res

def unstuff(data):
    res = ""
    count  = 0
    i = 0
    while i < len(data):
        res += data[i]
        if data[i] == '1':
            count += 1
            if count == 5:
                if i + 1 < len(data) and data[i+1] == '0':
                    i += 1
                count = 0
        else:
            count = 0
        i += 1
    return res

stuffed_data = stuff(data)
print("Stuffed data: ", stuffed_data)

unstuffed_data = unstuff(stuffed_data)
print("Unstuffed data: ", unstuffed_data)