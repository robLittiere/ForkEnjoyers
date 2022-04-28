//
//  DataManager.swift
//  ForkEnjoyers
//
//  Created by Robin on 27/04/2022.
//

import Foundation

class RestaurantDataManager {
    var restaurants: [Restaurant] = []
    var restauranIds: [String] = ["1235", "6861", "1114", "1339", "1348", "1354", "1361", "1373", "136", "1380"]
    
    
    
    
    func getData(restaurantId: String, completion: @escaping(Restaurant) -> Void) {
        // On lance la requète
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        let url = URL(string: "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=" + restaurantId)!
        print(url)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let data = json as? [String: AnyObject] {
                        if let dataObject = data["data"] as? [String: AnyObject]{
                            if let restaurant = Restaurant(json: dataObject){
                                completion(restaurant)
                                print(restaurant.name)
                            }
                        }
                    }
                }
            }
            
            //completion(Restaurant())
        }
        task.resume()
    }
    
    
    
    
    
}

