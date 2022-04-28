//
//  RestaurantTableCellView.swift
//  ForkEnjoyers
//
//  Created by Robin on 27/04/2022.
//

import UIKit

class RestaurantTableCellView: UITableViewCell {
    
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantNameView: UILabel!
    @IBOutlet weak var specialtyTextView: UILabel!
    @IBOutlet weak var priceTextView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
