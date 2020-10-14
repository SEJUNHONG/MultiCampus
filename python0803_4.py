answer=0
for i in range (10001):
    for j in str(i):
        if str(j)=='8':
            answer+=1

print(answer)

# 또다른 방법 print(str(list(range(1, 10001))).count('8'))