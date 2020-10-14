import re

url=input()
res=re.match("(http://www.|https://www.)[a-zA-Z0-9._]+[.][a-zA-Z0-9]+(/[a-zA-Z0-9]+)+[a-zA-Z0-9]+[.].+$",url)
if res!=None:
    print("도메인 주소 입력 완료")
else:
    print("도메인 주소 다시 입력하세요")