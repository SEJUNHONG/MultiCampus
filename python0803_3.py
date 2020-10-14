gen = [0 for i in range(5031)]
sum=0
for i in range(1, 5000):
    sum+=i

maxdn=0
for i in range(1, 5000):
    dn=int(i/1000)+int(i%1000/100)+int(i%100/10)+int(i%10)+i
    if dn>maxdn:
        maxdn=dn
    gen[dn-1]=1

for i in range(5031):
    if gen[i]==1:
        sum-=i

print(sum)

'''
def myfn(n):
    y=n
    while n>0:
        y+=n%10
        n//=10
    return y

res=[myfn(n) for n in range (5000)]
myself=[n for n in range(5000) if n not in res]
print(sum(myself))
'''