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
    var mapService = MapService()
    let locationManager = CLLocationManager()
    
    var dataManager = RestaurantDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.RestaurantTableView.delegate = self
        self.RestaurantTableView.dataSource = self
        
        
        for restaurantId in dataManager.restauranIds {
            dataManager.getData(restaurantId: restaurantId) { Restaurant in
                DispatchQueue.main.async {
                    // PUT LEO CODE
                    
                    self.restaurants.append(Restaurant)
                    self.RestaurantTableView.reloadData()
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
        cell.priceTextView.text = String(restaurant.min_price) + "€"
        cell.restaurantImageView.load(urlString: restaurant.image_urls["612x344"]!)
        
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
