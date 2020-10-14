from selenium import webdriver
from urllib.request import urlopen
from urllib.parse import quote_plus
import time
import re
from bs4 import BeautifulSoup
import pandas as pd

driver=webdriver.Chrome("C://mychrome/chromedriver.exe")

def insta_searching(word):
    url="http://www.instagram.com/explore/tags/"+word
    return url

word="제주도맛집"
url=insta_searching(word)
driver.get(url)

## 로그인 해야 진행 됨!!!!!!!!!!!!!!!!!
first=driver.find_element_by_css_selector("div._9AhH0")
first.click()
time.sleep(2)

def get_content(driver):
    html=driver.page_source
    soup=BeautifulSoup(html, "lxml")
    try:
        content=soup.select("div.C4VMK > span")[0].text
#         print(content)
    except:
        content=" "
    tags=re.findall("#[^\s]+", content)
    date=soup.select("time._1o9PC.Nzb55")[0]['datetime'][:10]
    like=soup.select("div.Nm9Fw > button")[0].text
    place=soup.select("div.M30cS")[0].text
    
    data=[content, date, like, place, tags]
    return data

def moveNext(driver):
    right=driver.find_element_by_css_selector("a.coreSpriteRightPaginationArrow")
    right.click()
    time.sleep(2)

results=[]

for i in range(9):
    data=get_content(driver)
    results.append(data)
    moveNext(driver)

instagram=pd.DataFrame(results, columns=['content', 'date', 'like', 'place', 'tags'])
print(instagram)