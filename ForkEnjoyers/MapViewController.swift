//
//  MapViewController.swift
//  ForkEnjoyers
//
//  Created by GREGORI Léo on 27/04/2022.
//

import UIKit
import MapKit

struct Stadium {
  var name: String
  var lattitude: CLLocationDegrees
  var longtitude: CLLocationDegrees
}

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    let stadiums = [Stadium(name: "CCI Paris Ile-de-France", lattitude: 48.87426776603793 , longtitude: 2.3013969966173344), Stadium(name: "CCI Cergy", lattitude: 49.03972490902984, longtitude: 2.0779792408024824), Stadium(name: "Beauvais", lattitude: 49.43851837253539, longtitude: 2.077741006315074)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        checkLocationServices()
        fetchStadiumsOnMap(stadiums)
        zoomInRegion(stadiums)
    }
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
    
    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
      for stadium in stadiums {
        let annotations = MKPointAnnotation()
        annotations.title = stadium.name
        annotations.coordinate = CLLocationCoordinate2D(latitude:
          stadium.lattitude, longitude: stadium.longtitude)
        mapView.addAnnotation(annotations)
      }
    }
    
    func zoomInRegion(_ stadiums: [Stadium]) {
        var maxLat: CLLocationDegrees = stadiums[0].lattitude
        var maxLong: CLLocationDegrees = stadiums[0].longtitude
        var minLat: CLLocationDegrees = stadiums[0].lattitude
        var minLong: CLLocationDegrees = stadiums[0].longtitude
        
        for stadium in stadiums {
            if (stadium.lattitude < minLat) {
                    minLat = stadium.lattitude
                }

                if (stadium.longtitude < minLong) {
                    minLong = stadium.longtitude
                }

                if (stadium.lattitude > maxLat) {
                    maxLat = stadium.lattitude
                }

                if (stadium.longtitude > maxLong) {
                    maxLong = stadium.longtitude
                }
        }
        let distance = CLLocation(latitude: maxLat, longitude: maxLong).distance(from: CLLocation(latitude: minLat, longitude: minLong))*1.1
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(((maxLat + minLat) * 0.5), ((maxLong + minLong) * 0.5)), latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
    }
}

