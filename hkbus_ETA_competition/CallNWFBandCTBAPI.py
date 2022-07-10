import requests

def NWFBandCTB_api(bus_route,min_dist_destination_bus_index,min_dist_user_bus_index,company='NWFB',bus_direction='outbound'):
    
    bus_route = str(bus_route)
    
    base_api_url = 'https://rt.data.gov.hk/'
    bus_route_api = 'v1/transport/citybus-nwfb/route-stop/{}/{}/{}'.format(company,bus_route,bus_direction)
    
    count = 3
    while count > 0:
        bus_route_stop = requests.get(base_api_url + bus_route_api)
        if bus_route_stop.status_code==200:
            bus_route_stop = bus_route_stop.json()

            #Store all the bus information into the dictionary
            bus_info = {'bus_stop_id':[],
                        'bus_stop':[],
                        'bus_stop_name':[],
                        'bus_stop_latitude':[],
                        'bus_stop_longitude':[],
                        'bus_position':[]
                        }
                
            for x in range(0,len(bus_route_stop['data'])):
                bus_info['bus_stop_id'].append(bus_route_stop['data'][x]['stop'])


                #Using the bus stop code to get the bus info (e.g. latlng, bus stop name)
            for x in range(0,len(bus_route_stop['data'])):
                bus_stop_api_url = '/v1/transport/citybus-nwfb/stop/{}'.format(bus_info['bus_stop_id'][x])
                bus_stop_info = requests.get(base_api_url + bus_stop_api_url)
                bus_stop_info = bus_stop_info.json()
                bus_info['bus_stop'].append(bus_stop_info['data'])


                #Store all the bus stop name and latlng into the list of the dictionary
            for x in range(0,len(bus_route_stop['data'])):
                bus_info['bus_stop_name'].append(bus_info['bus_stop'][x]['name_tc'])
                bus_info['bus_stop_latitude'].append(float(bus_info['bus_stop'][x]['lat']))
                bus_info['bus_stop_longitude'].append(float(bus_info['bus_stop'][x]['long']))
                bus_info['bus_position'].append([bus_info['bus_stop_latitude'][x],bus_info['bus_stop_longitude'][x]])
            
        
            required_bus_stop = []
            required_bus_stop_code = bus_info['bus_stop_id'][min_dist_user_bus_index]
            print(required_bus_stop_code)
            eta_url = '/v1/transport/citybus-nwfb/eta/'.format(company,required_bus_stop_code,bus_route)
            
            count2 = 3 
            while count2 > 0:
                required_bus_stop = requests.get(base_api_url + eta_url)
                print(required_bus_stop)
                if required_bus_stop.status_code == 200:
                    required_bus_stop = required_bus_stop.json()
                    eta = str(required_bus_stop['data'][1]['eta']).split('T')[-1].split('+')[0]
                    count = -1
                    count2 = -1
                    return eta
                    
                else: 
                    count2 -= 1
                    return required_bus_stop.json().message

        elif bus_route_stop.status_code == 422:
            print(bus_route_stop.json().message) # wrong in request
            count = -1
            return 'error'
            count = -1

        else:
            count -= 1 # retry for 3 times

