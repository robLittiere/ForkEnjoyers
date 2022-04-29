//
//  UniqueRestaurantViewController.swift
//  ForkEnjoyers
//
//  Created by GREGORI Léo on 28/04/2022.
//

import UIKit

extension CATransition {
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
     //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.1 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
       }
}

class UniqueRestaurantViewController: UIViewController {

    var restaurant: Restaurant!
    var restaurants: [Restaurant]!
    var actualIndex: Int!

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var hourOpenLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var phoneNbLabel: UILabel!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var specialityLabel: UILabel!
    @IBOutlet weak var minPriceLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var favImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let buttonColor = getUIColor(hex: "#E77600")
        
        self.nameLabel.text = restaurant.name
        self.restaurantImageView.load(urlString: restaurant.image_urls["612x344"]!)
        self.ratingLabel.text = String(describing: restaurant.rating)
        self.hourOpenLabel.text = String( restaurant.hours_open)
        self.adressLabel.text = "\(restaurant.address), \(restaurant.city), \(restaurant.zipcode), \(restaurant.country)"
        moreInfoButton.backgroundColor = buttonColor
        moreInfoButton.tintColor = buttonColor
        moreInfoButton.layer.cornerRadius = moreInfoButton.frame.height / 2
        phoneNbLabel.text = "+ \(restaurant.phone)"
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.changeUniqueRestaurant(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.changeUniqueRestaurant(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        let tap = UITapGestureRecognizer(target: self, action:  #selector(self.callTo(_:)))
        self.phoneView.isUserInteractionEnabled = true
        self.phoneView.addGestureRecognizer(tap)
        self.descriptionLabel.text = restaurant.description ?? "Pas de description désolé 😬"
        self.specialityLabel.text = "Spécialité: \(restaurant.specialty)"
        self.minPriceLabel.text = "Prix minimal: \(restaurant.min_price) €"
        self.reviewsLabel.text = "\(restaurant.number_reviews) avis"
        let tapFav = UITapGestureRecognizer(target: self, action:  #selector(self.toggleFav(_:)))
        self.favImage.isUserInteractionEnabled = true
        self.favImage.addGestureRecognizer(tapFav)
        
    }
    
    func getUIColor(hex: String, alpha: Double = 1.0) -> UIColor? {
        var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cleanString.hasPrefix("#")) {
            cleanString.remove(at: cleanString.startIndex)
        }

        if ((cleanString.count) != 6) {
            return nil
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cleanString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    @IBAction func showMoreInfo(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "webrestaurantviewcontroller") as? WebRestaurantViewController {
            
            vc.restaurantLink = self.restaurant.portal
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    @objc func toggleFav(_ sender:UITapGestureRecognizer? = nil){
        if self.favImage.image == UIImage(systemName: "heart"){
            self.favImage.image = UIImage(systemName: "heart.fill")
        } else {
            self.favImage.image = UIImage(systemName: "heart")
        }
        
            
    }
    @objc func callTo(_ sender:UITapGestureRecognizer? = nil){
        self.phoneView.backgroundColor = UIColor.lightGray
      let phone = "0\(restaurant.phone.split(separator: "-")[1])"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
            self.phoneView.backgroundColor = UIColor.systemBackground
        }
      if let url = URL(string: "tel://\(phone)"),
      UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
    @objc func changeUniqueRestaurant(_ gesture:UIGestureRecognizer? = nil){
        // Change to previous or next restaurant
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case .right:
                    if self.actualIndex == 0 {
                        self.actualIndex = self.restaurants.count
                    }
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uniquerestaurantviewcontroller") as? UniqueRestaurantViewController {
                        
                        vc.restaurant = self.restaurants[self.actualIndex - 1]
                        vc.restaurants = self.restaurants
                        vc.actualIndex = self.actualIndex - 1
                        
                        let nav = self.navigationController
                        DispatchQueue.main.async { //make sure all UI updates are on the main thread.
                                nav?.view.layer.add(CATransition().segueFromLeft(), forKey: nil)
                                nav?.pushViewController(vc, animated: false)
                            }
                    }
                case .left:
                    if self.actualIndex == self.restaurants.count - 1 {
                        self.actualIndex = -1
                    }
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "uniquerestaurantviewcontroller") as? UniqueRestaurantViewController {
                        
                        vc.restaurant = self.restaurants[self.actualIndex + 1]
                        vc.restaurants = self.restaurants
                        vc.actualIndex = self.actualIndex + 1
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                default:
                    break
                }
            }
    }

}
