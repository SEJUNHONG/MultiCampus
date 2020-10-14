from urllib.request import urlopen
from bs4 import BeautifulSoup

for j in range(1, 992, 10):
    url="https://search.naver.com/search.naver?where=kin&kin_display=10&qt=&title=0&&answer=0&grade=0&choice=0&sec=0&nso=so%3Ar%2Ca%3Aall%2Cp%3Aall&query=%ED%8C%8C%EC%9D%B4%EC%8D%AC&c_id=&c_name=&sm=tab_pge&kin_start="+str(j)
    html=urlopen(url)
    soup=BeautifulSoup(html, "html.parser")
    for i in range(10):
        print(soup.select("li > dl > dt > a")[i].text)