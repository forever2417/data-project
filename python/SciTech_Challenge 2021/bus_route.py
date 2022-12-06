import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame
import requests
from bs4 import BeautifulSoup


# bus_links = {
#     '23': 'https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B423%E7%B7%9A',
#     '40': 'https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B440%E7%B7%9A',
#     '74A': 'https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B474A%E7%B7%9A',
#     '102': 'https://hkbus.fandom.com/wiki/%E9%81%8E%E6%B5%B7%E9%9A%A7%E5%B7%B4102%E7%B7%9A',
#     '271B': 'https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B4271B%E7%B7%9A'
# }
bus_links = [['23','https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B423%E7%B7%9A'],
        ['40','https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B440%E7%B7%9A'],
        ['74A','https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B474A%E7%B7%9A'],
        ['102','https://hkbus.fandom.com/wiki/%E9%81%8E%E6%B5%B7%E9%9A%A7%E5%B7%B4102%E7%B7%9A'],
        ['271B','https://hkbus.fandom.com/wiki/%E4%B9%9D%E5%B7%B4271B%E7%B7%9A']
        ]

def get_tables(link):
    req = requests.get(link)
    soup = BeautifulSoup(req.content,'html.parser')
    title = soup.title.text.split(' |')[0]
    table_list = soup.find_all('table',class_='wikitable')

    tables = []

    for table in table_list:

        table_arr = []
        for tr in table.find_all('tr'):
            tr_list = []
            for th in tr.find_all('th'):
                a= th.text.strip()
                tr_list.append(a)

            table_arr.append(tr_list)
        try:
            if table_arr[1][0]=='序號':
                tables.append(table)
        except:
            pass

    return tables


def get_bus_routes(htmls,name):
    a= 0

    for html in htmls:
        
        tableDfs = pd.read_html(str(html))
        bus = get_bus_tableDfs(tableDfs,name)
        if a == 0:
            bus.to_csv('./data/csv/bus_' +name+ '_inboud' + '.csv', encoding='utf-8', index=False,header = False)
            a=1
        else:
            bus.to_csv('./data/csv/bus_' +name+ '_outboud' + '.csv', encoding='utf-8', index=False,header = False)
            a=0
        

def get_bus_tableDfs(tableDfs,name):
    bus_tableDfs = []
    for tabledf in tableDfs:
        table = tabledf.to_numpy()

        if (table[0][0] == '1' or (table[0][0] == (float(1)))):
            bus=tabledf.iloc[:, 1:-1].fillna('Na')
    
    return bus


# def transform_bus_tables(bus_tableDfs):
#     transformed_bus_tables = []

#     for tableDf in bus_tableDfs:
#         col_len = len(tableDf.columns)
#         table = tableDf.to_numpy()
#         transformed_table = np.delete(table, [0, col_len - 1], 1)
#         df = pd.DataFrame(transformed_table)
#         transformed_bus_tables.append(df)

#     return transformed_bus_tables


def main():
    for n in range(0,len(bus_links)):
        current_bus =bus_links[n][0]

        bus_table = get_tables(bus_links[n][1])
    
        get_bus_routes(bus_table,current_bus)



if __name__ == '__main__':
    main()



