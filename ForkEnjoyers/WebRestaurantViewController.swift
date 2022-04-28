//
//  WebRestaurantViewController.swift
//  ForkEnjoyers
//
//  Created by GREGORI Léo on 28/04/2022.
//

import UIKit
import WebKit

class WebRestaurantViewController: UIViewController {

    @IBOutlet weak var restaurantWebView: WKWebView!
    
    var restaurantLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reloadWebView(text: self.restaurantLink)
    }
    
    func reloadWebView(text: String) {
        let url = URL(string: text)!
        let request = URLRequest(url: url)
        self.restaurantWebView?.load(request)
    }

}
