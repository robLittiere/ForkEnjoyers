//
//  Restaurant.swift
//  ForkEnjoyers
//
//  Created by Robin on 27/04/2022.
//

import Foundation

struct Restaurant {
    let name: String
    let portal: String
    let gps_lat: Double
    let gps_long: Double
    let address: String
    let city: String
    let zipcode: String
    let country: String
    let phone: String
    let description: String
    let min_price: Int
    let specialty: String
    let hours_open: String
    let image_urls: [String:String]
    let rating: Int
    let number_reviews: Int
}

extension Restaurant {
    init?(json: [String: AnyObject]){
        guard   let name = json["name"] as? String,
                let portal = json["portal_url"] as? String,
                let gps_lat = json["gps_lat"] as? Double,
                let gps_long = json["gps_long"] as? Double,
                let address = json["address"] as? String,
                let city = json["city"] as? String,
                let zipcode = json["zipcode"] as? String,
                let country = json["country"] as? String,
                let phone = json["phone"] as? String,
                let description = json["description"] as? String,
                let min_price = json["min_price"] as? Int,
                let specialty = json["speciality"] as? String,
                let hours_open = json["hour_open"] as? String,
                let image_urls = json["pics_main"] as? [String:String],
                let rating = json["trip_advisor_avg_rating"] as? Int,
                let number_reviews = json["trip_advisor_review_count"] as? Int

        else {
            return nil
        }
        
        self.name = name
        self.portal = portal
        self.gps_lat = gps_lat
        self.gps_long = gps_long
        self.address = address
        self.city = city
        self.zipcode = zipcode
        self.country = country
        self.phone = phone
        self.description = description
        self.min_price = min_price
        self.specialty = specialty
        self.hours_open = hours_open
        self.image_urls = image_urls
        self.rating = rating
        self.number_reviews = number_reviews


        
    }
}

