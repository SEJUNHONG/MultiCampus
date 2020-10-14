import urllib.request as req
from bs4 import BeautifulSoup

for i in range(1, 6):
    url="https://movie.daum.net/moviedb/grade?movieId=127897&type=netizen&page=%d" % i
    res=req.urlopen(url)
    soup=BeautifulSoup(res, "html.parser")
    pList=soup.select("#mArticle > div.detail_movie.detail_rating > div.movie_detail > div.main_detail > ul > li > div > p.desc_review")
    for p in pList:
        print(p.text)