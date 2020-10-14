import urllib.request as req
from bs4 import BeautifulSoup

url="https://ko.wikisource.org/wiki/%EC%A0%80%EC%9E%90:%EC%9C%A4%EB%8F%99%EC%A3%BC"
res=req.urlopen(url)
soup=BeautifulSoup(res, "html.parser")
pList=soup.select("#mw-content-text > div > ul > li > ul > li > a")
for p in pList:
    print(p.string)