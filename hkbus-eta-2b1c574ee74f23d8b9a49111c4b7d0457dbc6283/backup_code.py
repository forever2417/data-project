   bus_route = re.sub("[\u4e00-\u9fff]+"," ", text).strip().upper()

local = {'大埔':[22.4505881,114.1609564],
             '九龍塘':[22.3366253,114.1743532],
             '旺角':[22.3198892,114.1712999],
             '尖沙咀':[22.2990646,114.1720295]}
for i in local:
    if i in text:
        destination = i
        break
