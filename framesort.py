import random

def bubblesort(frames):
    for i in range(0, len(frames)):
        for j in range(0, len(frames)-i-1):
            if (frames[j] > frames[j+1]):
                frames[j], frames[j+1] = frames[j+1], frames[j]
    return

message = str(input("Enter message: "))

frames = []

i = 0
while (i < len(message)):
    frames.append(message[i: i+3])
    i += 3

en_frames = list(enumerate(frames, start=1))

for i in range(0, len(en_frames)):
    pos = random.randint(0, len(en_frames) - 1)
    en_frames[i], en_frames[pos] = en_frames[pos], en_frames[i]

bubblesort(en_frames)

print("".join(x[1] for x in en_frames))