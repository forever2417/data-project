from typing import Text
from bs4 import BeautifulSoup
import csv
import requests
from datetime import datetime
import time 

currentTime = datetime.now()
format_currentTime = currentTime.strftime("%Y-%m-%d %H:%M:%S")
link1 = "https://hkbus.fandom.com/wiki/%E9%81%8E%E6%B5%B7%E9%9A%A7%E5%B7%B4101%E7%B7%9A"
link2 = "https://hkbus.fandom.com/wiki/%E5%88%86%E9%A1%9E:%E5%9C%B0%E5%8D%80"
first_part = "https://hkbus.fandom.com/wiki/"

s = requests.Session()

def read1Page(link):

    req = s.get(link)

    soup = BeautifulSoup(req.content,'html.parser')
    title = soup.title.text.split(' |')[0]


    table_list = soup.find_all('table')

    tables = []
    # print(len(table_list))
    for table in table_list:
        # print(table)
        table_arr = []
        # time.sleep(5)
        for tr in table.find_all('tr'):
            # print(tr)
            # time.sleep(5)
            tr_list = []
            for th in tr.find_all('th'):
                a= th.text.strip()
                # print(a)
                tr_list.append(a)
                # print(td)
                # time.sleep(5)
            for td in tr.find_all('td'):
                b = td.text.strip()
                tr_list.append(b)
                # print(b)

            # print(tr_list)
            table_arr.append(tr_list)
            # print(table_arr[0][1])
        try:
            if table_arr[1][0]=='序號':
                tables.append(table_arr)
        except:
            pass

    flatten_list = []
    for i in range(0,len(tables)):
        for n in range(0,len(tables[i])):
            for m in range(0,len(tables[i][n])):
                if tables[i][n][m] != "":
                    flatten_list.append(tables[i][n][m])
    print(flatten_list)
    # print(len(tables))
    return flatten_list, title

    

    
def get_list():
    print('hi')
    district_list = []
    req = s.get(link2)
    soup = BeautifulSoup(req.content,'html.parser')

    content = soup.find('div',class_='category-page__members')
    wrapper = soup.find_all('div',class_='category-page__members-wrapper')
    links = content.find_all('a')
    
    for link in links:
        
        text = link.text
        if ('分類' not in text)&('區'in text):
            # print(text)
            url = link.get('href')
            district_list.append(text)
    # print(district_list)
    time.sleep(10)
    return district_list

def get_district(lst):
    districts = []
    # for last in lst:
    # print(first_part+lst[0])
    req = s.get(first_part+lst[0])
    soup = BeautifulSoup(req.content,'html.parser')

    content = soup.find('div',class_='main-container')
    table_list = soup.find_all('table')

    tables = []
    # print(len(table_list))
    for table in table_list:
        # print(table)
        table_arr = []
        # time.sleep(5)
        for tr in table.find_all('tr'):
            # print(tr)
            # time.sleep(5)
            tr_list = []
            for th in tr.find_all('th'):
                a= th.text.strip()
                # print(a)
                # time.sleep(5)
                tr_list.append(a)
                # print(td)
                # time.sleep(5)
            for td in tr.find_all('td'):
                b = td.text.strip()
                tr_list.append(b)
                # print(b)

            # print(tr_list)
            # time.sleep(5)
            table_arr.append(tr_list)
            # print(table_arr[0][1])
        try:
            if table_arr[1][0]=='分區':
                tables.append(table_arr)
        except:
            pass
    for i in range(0,len(table_arr)):
        if len(table_arr[i])>1:
            tables.append(table_arr[i])
    flat_list = [item for sublist in tables for item in sublist]

    new_list = []
    for i in range(0,len(flat_list)):
        b = flat_list[i].strip().replace("•",",").replace(" ","")
        new_list.append(b)
        new_list.append('觀塘市中心')

    print(new_list)
    time.sleep(4)
    # print(tables[0])
    print(len(new_list))
    return new_list
    

def get_bus_route(districts):
    list_of_bus = ""


    bus_stations, title = read1Page(link1)



    all = []
    for i in range(0,len(bus_stations)):
        area= bus_stations[i]
        # for n in range(0,len(area)):
        for o in range(0,len(districts)):
                if area in districts[o]:
                    all.append(area)

    new = set(all)
    all = list(new)
    # print(all)
    bus_route = []
    bus_route.append(title)
    bus_route.append(all)
    print(bus_route)





def main():
    print(datetime.now())
    print('1asda')
    # read1Page(link1)
    district_list = get_district(get_list())
    get_bus_route(district_list)

if __name__ == '__main__':
    main()
