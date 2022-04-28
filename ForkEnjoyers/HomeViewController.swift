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
    
    let locationManager = CLLocationManager()
    
    var mapService = MapService()
    
    var restaurants: [Restaurant] = []
    var restauranIds: [String] = ["1235", "6861", "1114", "1339", "1348", "1354", "1361", "1373", "136", "1380"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.RestaurantTableView.delegate = self
        self.RestaurantTableView.dataSource = self
        
        // On lance la requète
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        for restaurantId in restauranIds {
            let url = URL(string: "https://api.lafourchette.com/api?key=IPHONEPRODEDCRFV&method=restaurant_get_info&id_restaurant=" + restaurantId)!
            let task = session.dataTask(with: url) { (data, response, error) in
               if error != nil {
                   print(error!.localizedDescription)
               } else {
                   if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                       if let data = json as? [String: AnyObject] {
                           if let dataObject = data["data"] as? [String: AnyObject]{
                               if let restaurant = Restaurant(json: dataObject){
                                   self.restaurants.append(restaurant)
                               }
                           }
                       }
                   }
               }
               
               DispatchQueue.main.async {
                   self.RestaurantTableView.reloadData()
               }
            }
            task.resume()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // TODOOO
        // Configure cell for appropriate restaurant cells

        cell.textLabel?.text = self.restaurants[indexPath.row].name
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.green
        }
        else {
            cell.backgroundColor = UIColor.red
        }
        return cell
    }
    
    func moveElements(position: CGFloat) {
        self.leftrestaurantTableViewContraint.constant = position
        UIView.animate(withDuration: 0.6) {
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
    
}
