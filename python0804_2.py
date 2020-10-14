import re

email=input()
res=re.match("[a-zA-Z0-9._]+[@][a-zA-Z0-9]+[.][a-zA-Z0-9]+", email)
if email==res.group():
    print("이메일 입력 완료")
else:
    print("이메일 다시 입력하세요")