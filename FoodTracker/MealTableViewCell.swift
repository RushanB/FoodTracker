//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-04.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    @IBOutlet weak var caloriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
