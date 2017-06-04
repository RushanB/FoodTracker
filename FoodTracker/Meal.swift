//
//  Meal.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-04.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class Meal{
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //Mark: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        //name must not be empty
        guard !name.isEmpty else{
            return nil
        }
        
        //rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5)else{
            return nil
        }
        
        //initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
