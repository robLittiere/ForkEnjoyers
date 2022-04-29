//
//  HomeViewController.swift
//  ForkEnjoyers
//
//  Created by Robin on 27/04/2022.
//

import UIKit
import MapKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var RestaurantTableView: UITableView!
    @IBOutlet weak var toggleListPlan: UISegmentedControl!
    @IBOutlet weak var leftrestaurantTableViewContraint: NSLayoutConstraint!
    
    var restaurants:[Restaurant] = []
    let locationManager = CLLocationManager()
    
    var dataManager = RestaurantDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkLocationServices()
       
        self.RestaurantTableView.delegate = self
        self.RestaurantTableView.dataSource = self
        
        
        for restaurantId in dataManager.restauranIds {
            dataManager.getData(restaurantId: restaurantId) { Restaurant in
                DispatchQueue.main.async {
            
                    self.restaurants.append(Restaurant)
                    self.RestaurantTableView.reloadData()
                    
                    // Pin and resize Map
                    self.fetchRestaurantsOnMap(Restaurant)
                    self.zoomInRegion(self.restaurants)
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RestaurantTableCellView

        // TODOOO
        // Configure cell for appropriate restaurant cells
        
        let restaurant = self.restaurants[indexPath.row]
        cell.restaurantNameView.text = restaurant.name
        cell.adressTextView.text = restaurant.address + ", " + restaurant.city
        cell.ratingLabelView.text = String(describing: restaurant.rating)
        cell.priceTextView.text = String(restaurant.min_price) + " €"
        cell.restaurantImageView.load(urlString: restaurant.image_urls["612x344"]!)
        cell.specialtyTextView.text = "Food specialty : " + restaurant.specialty
        cell.clipsToBounds = true
        tableView.separatorStyle = .none

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;//Choose your custom row height
    }
    
    
    
    
    
    
    // MAPPING
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uniquerestaurantviewcontroller") as? UniqueRestaurantViewController {
            
            vc.restaurant = self.restaurants[indexPath.row]
            print(indexPath.row)
            
            vc.restaurants = self.restaurants
            vc.actualIndex = indexPath.row
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func moveElements(position: CGFloat) {
        self.leftrestaurantTableViewContraint.constant = position
        UIView.animate(withDuration: 0.15) {
            self.view.layoutIfNeeded()
        }
    }
    @IBAction func ChangeValueToggle(_ sender: Any) {
        switch self.toggleListPlan.selectedSegmentIndex {
            case 0:
            moveElements(position: 0)
            case 1:
            moveElements(position: -self.RestaurantTableView.frame.width)
        default:
            print("nothing")
        }
        
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
    
    func fetchRestaurantsOnMap(_ restaurant: Restaurant) {
        let annotations = MKPointAnnotation()
        annotations.title = restaurant.name
        annotations.coordinate = CLLocationCoordinate2D(latitude:
          restaurant.gps_lat, longitude: restaurant.gps_long)
        mapView.addAnnotation(annotations)
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
        self.mapView.setRegion(region, animated: true)
    }
    
}
