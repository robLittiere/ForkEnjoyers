//
//  MapServices.swift
//  ForkEnjoyers
//
//  Created by GREGORI Léo on 28/04/2022.
//

import Foundation
import UIKit
import MapKit

class MapService {
    let locationManager = CLLocationManager()
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
          
      }
    }
    
    func alertNoGPS() {
        let dialogMessage = UIAlertController(title: "Attention", message: "Vous n'avez pas authoriser la localisation", preferredStyle: .alert)
         
         // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("User know that localisation is not allowed")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
         // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse: mapView.showsUserLocation = true
        case .denied: alertNoGPS()
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
          mapView.showsUserLocation = true
        case .restricted: alertNoGPS()
        case .authorizedAlways: mapView.showsUserLocation = true
      }
    }
    
    func fetchStadiumsOnMap(_ restaurants: [Restaurant]) {
        for restaurant in restaurants {
            let annotations = MKPointAnnotation()
            annotations.title = restaurant.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
              restaurant.gps_lat, longitude: restaurant.gps_long)
            mapView.addAnnotation(annotations)
      }
    }
    
    func zoomInRegion(_ restaurants: [Restaurant]) {
        var maxLat: CLLocationDegrees = restaurants[0].gps_lat
        var maxLong: CLLocationDegrees = restaurants[0].gps_long
        var minLat: CLLocationDegrees = restaurants[0].gps_lat
        var minLong: CLLocationDegrees = restaurants[0].gps_long
        
        for restaurant in restaurants {
            if (restaurant.gps_lat < minLat) {
                    minLat = restaurant.gps_lat
                }

                if (restaurant.gps_long < minLong) {
                    minLong = restaurant.gps_long
                }

                if (restaurant.gps_lat > maxLat) {
                    maxLat = restaurant.gps_lat
                }

                if (restaurant.gps_long > maxLong) {
                    maxLong = restaurant.gps_long
                }
        }
        let distance = CLLocation(latitude: maxLat, longitude: maxLong).distance(from: CLLocation(latitude: minLat, longitude: minLong))*1.1
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(((maxLat + minLat) * 0.5), ((maxLong + minLong) * 0.5)), latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
    }

}


