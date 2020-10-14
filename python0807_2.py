from selenium import webdriver
from bs4 import BeautifulSoup
import re

driver=webdriver.Chrome("C:/mychrome/chromedriver.exe")
driver.get("http://prod.danawa.com/list/?cate=112758&15main_11_02")

def get_conten(driver, i):
    html=driver.page_source
    soup=BeautifulSoup(html, "lxml")
    try:
        content=soup.select("div > div.prod_info > p > a")[i].text[11:]
        contents=re.findall("[\w]+", content)

    except:
        content=" "
    info=soup.select("li.spec_item ")[i].text.split(" / ")
    price=soup.select("p.price_sect > a > strong")[i].text
    display=soup.select("li.spec_item ")[i].text.split(" / ")[0]
    cpu=soup.select("li.spec_item ")[i].text.split(" / ")[1]
    core=soup.select("li.spec_item ")[i].text.split(" / ")[5]
    # memory=re.findall("[0-9]+[TB|GB]+", str(info))
    # print(memory)

    notebook={'num':i+1, 'name':contents[0], 'price':price, 'size':display, 'cpu':cpu, 'core':core}
    print(notebook)
    print("="*50)
for i in range(6):
    get_conten(driver, i)