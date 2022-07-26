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
    

def read1Page(link):

    req = s.get(link)

    soup = BeautifulSoup(req.content,'html.parser')
    title = soup.title.text.split(' |')[0]


    table_list = soup.find_all('table',class_='wikitable')

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
                try:
                    test = td.get('rowspan')
                    if test != None:
                        # print(test)
                        # pass
                        b = b+test
                

                except:
                    pass
                if b == "":
                    b="NA"
                tr_list.append(b)
                # print(b)

            # print(tr_list)
            table_arr.append(tr_list)
            # print(table_arr[0][1])
        try:
            if table_arr[1][0]=='序號':
                tables.append(table_arr[2:])
        except:
            pass

    # print(tables)
    return tables

def changeRecord(bustables):
    print(1)
    print(bustables)
    transformed = []
    for i in range(0,len(bustables)):
        yList = []
        for y in range(0,len(bustables[i])):
            xlist = []
            for x in range(0,len(bustables[i][y])):
                if bustables[i][y][x][-1].isnumeric() & (bustables[i][y][x].isnumeric()!=True):
                    number = int(bustables[i][y][x][-1])
                    text = bustables[i][y][x][:-1]
                    print(text)

                    # print(bustables[i][y][x])
                    # print(number)




    

    




changeRecord(read1Page(link1))