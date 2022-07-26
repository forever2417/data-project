import requests
import re
from geopy.distance import geodesic
from CallkmbAPI import KMB_api
from InOutboundChecking import CheckInOut

testcaselist = [] #in taipo

def GetETA():

    bus_testing = {'271':{'富亨總站':[22.458338, 114.172047],
                           '佐敦(西九龍站)巴士總站':[22.307190, 114.164846]},
                    '102':{'筲箕灣':[22.278665, 114.228406],
                            '荔枝角':[22.337547, 114.146349]},
                    '74D':{'大埔':[22.4466446,114.1705434],
                            '觀塘市中心':[22.3116448,114.2219789]},
                    '23':{'觀塘商貿區':[22.311748, 114.223183],
                           '觀塘商貿區':[22.311748, 114.223183]},
                    '40':{'荃灣':[22.372763, 114.111244],
                           '觀塘商貿區':[22.311748, 114.223183]}}    
 
    bus_direction="outbound"
    
    user_position = [22.325188, 114.168459]#TST

    bus_number = list(bus_testing)[0]

    destinationlatlng = bus_testing['271']['富亨總站']

    bus_info = KMB_api(bus_route= bus_number)
        
    #Find the index of the nearest bus stop of user and destination
    bus_direction,min_dist_user_bus_index,min_dist_destination_bus_index = CheckInOut(bus_info,bus_number,user_position,destinationlatlng,bus_direction)

            #Call the api to find the target bus stop

    required_user_bus_stop_id = bus_info['bus_stop_id'][min_dist_user_bus_index]
    eta_url = '/v1/transport/kmb/eta/{}/{}/1'.format(required_user_bus_stop_id,bus_number)
    
    required_bus_stop = []
    required_bus_stop = requests.get('https://data.etabus.gov.hk' + eta_url)
    required_bus_stop = required_bus_stop.json()

    #Output the suitable info
    #if len(required_bus_info['data'][0]['eta']) == 0:
    #        NWFBandCTB_api(bus_route=bus_number,bus_direction=bus_direction)


    print("ETA:", print(required_bus_stop['data'][0]['eta']))
    print("Bus number:" ,bus_number)
    print("Bus direction:",bus_direction)
    print("bus id code:", required_user_bus_stop_id)
    print("Bus stop:" ,bus_info['bus_stop'][min_dist_user_bus_index]['name_tc'])
    print("Destination bus stop:" ,bus_info['bus_stop'][-1]['name_tc'])
    print("Required_User_bus_index:",min_dist_user_bus_index)
    print("Required_Destination_bus_index:",min_dist_destination_bus_index)


def main():
    GetETA()
if __name__ == "__main__":
   main()
