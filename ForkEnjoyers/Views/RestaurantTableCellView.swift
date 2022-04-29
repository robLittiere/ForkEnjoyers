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
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var MainContainerView: UIView!
    @IBOutlet weak var adressTextView: UILabel!
    @IBOutlet weak var ratingLabelView: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // ContainerView.layer.borderWidth = 3
        // ContainerView.layer.borderColor = UIColor.red.cgColor
        ContainerView.layer.masksToBounds = true
        ContainerView.layer.cornerRadius = 12.0
    
        
        MainContainerView.layer.masksToBounds = false
        MainContainerView.layer.cornerRadius = 12.0
        //restaurantImageView.innerShadow(color: UIColor.black, offSet: CGSize(width: 0.0, height: 0.0))
        restaurantImageView.addInnerShadow(height: 140.0)
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
        let bottomSpace: CGFloat = 10.0
        // let topSpace: CGFloat = 10.0
         self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: bottomSpace, right: 0))
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
