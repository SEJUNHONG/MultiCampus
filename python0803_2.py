word=input()
pal=True
for i in range(int(len(word)/2)):
    N=int(len(word))-i-1
    if word[i]!=word[N]:
        pal=False

if pal==True:
    print("Palindrome")
else:
    print("Not Palindrome")