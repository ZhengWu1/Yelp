//
//  RestaurantCell.swift
//  Yelp
//
//  Created by Zheng Wu on 4/17/15.
//  Copyright (c) 2015 Zheng Wu. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var RestaurantPicture: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var DistanceLabel: UILabel!
    
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var numReviewsLabel: UILabel!
    @IBOutlet weak var CategoriesLabel: UILabel!
    @IBOutlet weak var RatingPicture: UIImageView!
    
    var business: Business!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBusiness(inputBusiness: Business) {
        self.business = inputBusiness
        if (self.business.imageUrl != nil) {
            self.RestaurantPicture.setImageWithURL(NSURL(string: self.business.imageUrl!))
        } else {
            self.RestaurantPicture.image = UIImage()
        }
        self.nameLabel.text = self.business.name
        self.RatingPicture.setImageWithURL(NSURL(string: self.business.ratingImageUrl!))
        self.numReviewsLabel.text = NSString(format: "%ld Reviews", self.business.numReviews!)
        self.AddressLabel.text = self.business.address
        self.DistanceLabel.text = NSString(format: "%.2f mi", self.business.distance!)
        self.CategoriesLabel.text = self.business.categories
    }

}
