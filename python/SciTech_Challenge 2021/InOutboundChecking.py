from geopy.distance import geodesic
from CallkmbAPI import KMB_api

def CheckInOut(bus_info,bus_number,user_position,destinationlatlng,bus_direction):

    dist_user_bus_stop_list = []
    dist_destination_bus_stop_list = [] 

    for x in range(0,len(bus_info['bus_stop'])):
        dist_user_bus_stop = geodesic(user_position, bus_info['bus_position'][x]).miles 
        dist_destination_bus_stop = geodesic(destinationlatlng, bus_info['bus_position'][x]).miles 
        dist_user_bus_stop_list.append(dist_user_bus_stop)
        dist_destination_bus_stop_list.append(dist_destination_bus_stop)
    
    min_dist_user_bus_index = dist_user_bus_stop_list.index(min(dist_user_bus_stop_list))
    min_dist_destination_bus_index = dist_destination_bus_stop_list.index(min(dist_destination_bus_stop_list))
    
    print(type(bus_direction))
    print(type(min_dist_user_bus_index))
    print(type(min_dist_destination_bus_index))

    if min_dist_destination_bus_index < min_dist_user_bus_index:
        if bus_direction == "outbound":
            bus_direction = "inbound"
            bus_info = KMB_api(bus_route = bus_number,bus_direction=bus_direction)
            CheckInOut(bus_info,bus_number,user_position,destinationlatlng,bus_direction)
            
        else:
            bus_direction = "outbound"
            bus_info = KMB_api(bus_route = bus_number,bus_direction=bus_direction)
            CheckInOut(bus_info,bus_number,user_position,destinationlatlng,bus_direction)
            
    else:     
       return bus_direction, min_dist_user_bus_index, min_dist_destination_bus_index

