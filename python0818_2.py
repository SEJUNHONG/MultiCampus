from selenium import webdriver
from bs4 import BeautifulSoup
import re
import numpy as np
import time

driver=webdriver.Chrome("C:/mychrome/chromedriver.exe")
url="https://m.kma.go.kr/m/index.jsp"
driver.get(url)
joonggi="#tab-midterm"
driver.find_element_by_css_selector(joonggi).click()
html=driver.page_source
soup=BeautifulSoup(html, "html.parser")
time.sleep(2)

per=[]
a=[]
ki=soup.select("li > div > p")
for i in range(len(ki)):
    per.append(ki[i].text)
per

for i in range(1, int(len(per)/2)):
    a.append(per[2*i])

rain_int=[]
for i in range(12):
    rain_int.append(int(a[i][0:2]))
                    
print(np.mean(rain_int) , "%")