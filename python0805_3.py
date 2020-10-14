import urllib.request as req
from bs4 import BeautifulSoup
import re

url="https://stackoverflow.com/questions/tagged/python"
res=req.urlopen(url)
soup=BeautifulSoup(res, "html.parser")
pList=soup.find_all(href=re.compile("^/questions/63259"))
for i in pList:
    print(i.string)