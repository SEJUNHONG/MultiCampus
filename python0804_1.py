s=[9, 5, 2, 7, 3, 20, 100, 95]

min_s=999999
for i in range(len(s)):
    for j in range(i+1, len(s)):
        if abs(s[i]-s[j]) < min_s:
            min_s=abs(s[i]-s[j])
            a=s[i]
            b=s[j]
print(a, b)