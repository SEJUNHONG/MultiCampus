gravity=[7, 4, 2, 0, 0, 6, 0, 7, 0]
height=[0, 0, 0, 0, 0, 0, 0, 0, 0]
max_height=0
for i in reversed(range (9)):
    h=0
    for j in reversed(range(i, 9)):
        if gravity[i]>gravity[j]:
            h+=1
        else:
            j=8
    height[i]=h

for i in range(9):
    if height[i]>max_height:
        max_height=height[i]

print(max_height)