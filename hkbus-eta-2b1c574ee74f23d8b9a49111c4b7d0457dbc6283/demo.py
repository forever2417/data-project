import requests
import re
from geopy.distance import geodesic
from CallkmbAPI import KMB_api
from CallNWFBandCTBAPI import NWFBandCTB_api

testcaselist = [22.298247, 114.172040] #in taipo

def GetETA():

    # destination test
    bus_testing = {'271':{'富亨總站':[22.458338, 114.172047],
                           '佐敦(西九龍站)巴士總站':[22.307190, 114.164846]},
                    '102':{'筲箕灣':[22.278665, 114.228406],
                            '荔枝角':[22.337547, 114.146349]},
                    '74D':{'大埔':[22.4466446,114.1705434],
                            '觀塘市中心':[22.3116448,114.2219789]},
                    '23':{'觀塘商貿區':[22.311748, 114.223183],
                           '觀塘商貿區':[22.311748, 114.223183]},
                    '40':{'荃灣':[22.372763, 114.111244],
                           '觀塘商貿區':[22.311748, 114.223183]},
                    '101':{'石塘咀':[22.285579, 114.135321], 
                           '牛頭角':[22.319426, 114.215372]}}    
 
    direction="outbound"

    #Testing part 而家係大埔
    
    # user_position = [22.334966, 114.200988]
    #22.284457, 114.136735 ok
    #22.321965, 114.179289 ok
    #22.326635, 114.167899 ok
    #22.327388, 114.188751 ok
    #22.334966, 114.200988 ok

    # Test case 271, inbound to 富亨總站
    # user_position = [22.454590, 114.174297] # Tai Po, near outbound bus stop, ok
    # user_position = [22.453172, 114.172237] # Tai Po, between 2 bus stop, ok
    # user_position = [22.451725, 114.167551] # Tai Po, near bus stop, test from tai po to tai po, ok
    # user_position = [22.302193, 114.164057] # TST, near bus stop, test normal case, ok
    # user_position = [22.298778, 114.171923] # TST, near outbound bus stop, ok
    # user_position = [22.296636, 114.171238] # TST, between 2 bus stop, ok
    user_position = [22.281846, 114.168277] # Admiraty,  outside bus route, should response out out service

    
    required_bus_stop = []
    dist_user_bus_stop_list = []
    dist_destination_bus_stop_list = [] 
    
    try:
        # bus_number = list(bus_testing)[-1]    
        bus_number = '271'                                  #bus number

        destinationlatlng = bus_testing['271']['富亨總站']    #destination

        bus_info = KMB_api(bus_route= bus_number)

        for x in range(0,len(bus_info['bus_stop'])):
            dist_user_bus_stop = geodesic(user_position, bus_info['bus_position'][x]).miles 
            dist_destination_bus_stop = geodesic(destinationlatlng, bus_info['bus_position'][x]).miles 
            dist_user_bus_stop_list.append(dist_user_bus_stop)
            dist_destination_bus_stop_list.append(dist_destination_bus_stop)
            
        #Find the index of the nearest bus stop of user and destination
        min_dist_user_bus_index = dist_user_bus_stop_list.index(min(dist_user_bus_stop_list))
        min_dist_destination_bus_index = dist_destination_bus_stop_list.index(min(dist_destination_bus_stop_list))
        required_user_bus_stop_id = bus_info['bus_stop_id'][min_dist_user_bus_index]
        eta_url = '/v1/transport/kmb/eta/' + required_user_bus_stop_id + '/' + bus_number + '/' + '1'
        
        print("min_dist_user_bus_index",min_dist_user_bus_index)
        print("min_dist_destination_bus_index:",min_dist_destination_bus_index)
        if min_dist_destination_bus_index < min_dist_user_bus_index:
            
            direction = "inbound"
            bus_info = KMB_api(bus_route = bus_number,bus_direction=direction)
            # print(bus_info)
            
            required_bus_stop = []
            dist_user_bus_stop_list = []
            dist_destination_bus_stop_list = [] 

            for x in range(0,len(bus_info['bus_stop'])):
                dist_user_bus_stop = geodesic(user_position, bus_info['bus_position'][x]).miles 
                dist_destination_bus_stop = geodesic(destinationlatlng, bus_info['bus_position'][x]).miles 
                dist_user_bus_stop_list.append(dist_user_bus_stop)
                dist_destination_bus_stop_list.append(dist_destination_bus_stop)
        
                #Call the api to find the target bus stop
            min_dist_user_bus_index = dist_user_bus_stop_list.index(min(dist_user_bus_stop_list))
            min_dist_destination_bus_index = dist_destination_bus_stop_list.index(min(dist_destination_bus_stop_list))
            required_user_bus_stop_id = bus_info['bus_stop_id'][min_dist_user_bus_index]
            eta_url = '/v1/transport/kmb/eta/' + required_user_bus_stop_id + '/' + bus_number + '/' + '1'
        
        try:
            required_bus_stop = requests.get('https://data.etabus.gov.hk' + eta_url)
            required_bus_stop = required_bus_stop.json()
            bus_eta = required_bus_stop['data'][0]['eta'].split('T')[-1].split('+')[0]
            print("KMB_ETA:", bus_eta)

        except:
            try:
                print(1)
                bus_eta = NWFBandCTB_api(bus_route = bus_number, min_dist_destination_bus_index=min_dist_destination_bus_index, min_dist_user_bus_index=min_dist_user_bus_index, bus_direction=direction)
                print("NWFB_ETA:", bus_eta)
            except:
                try:
                    print(2)
                    bus_eta = NWFBandCTB_api(bus_route = bus_number, min_dist_destination_bus_index=min_dist_destination_bus_index, min_dist_user_bus_index=min_dist_user_bus_index, bus_direction=direction, company='CTB')
                    print("CTB_ETA:",bus_eta)
                except:
                    print("ETA: No Service")

        print("Bus number:" ,bus_number)
        print("Bus direction:",direction)
        print("bus id code:", required_user_bus_stop_id)
        print("Current Bus stop:" ,bus_info['bus_stop'][min_dist_user_bus_index]['name_tc'])
        print("Destination Bus stop:" ,bus_info['bus_stop'][-1]['name_tc'])
        print("Required_User_bus_index:",min_dist_user_bus_index)
        print("Required_Destination_bus_index:",min_dist_destination_bus_index)

    except:
        print('This bus is not on service')


def main():
    GetETA()

if __name__ == "__main__":
   main()
