//
//  UniqueRestaurantViewController.swift
//  ForkEnjoyers
//
//  Created by GREGORI Léo on 28/04/2022.
//

import UIKit

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
        self.phoneView.addGestureRecognizer(tap)
        self.descriptionLabel.text = restaurant.description ?? "Pas de description désolé 😬"
        self.specialityLabel.text = "Spécialité: \(restaurant.specialty)"
        self.minPriceLabel.text = "Prix minimal: \(restaurant.min_price) €"
        self.reviewsLabel.text = "\(restaurant.number_reviews) avis"
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
                    print("Swiped right")
                case .left:
                    print("Swiped left")
                default:
                    break
                }
            }
    }

}
