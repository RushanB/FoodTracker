//
//  Meal.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-04.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//


import UIKit
import os.log


class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
//    var calories: Int
//    var foodDescription: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    struct PropertyKey{
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
//        static let calories = "calories"
//        static let foodDescription = "description"
    }
    
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
        
        if name.isEmpty || rating < 0 {
            return nil
        }
        
        //initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
//        self.calories = calories
//        self.foodDescription = foodDescription
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
//        aCoder.encode(calories, forKey: PropertyKey.calories)
//        aCoder.encode(description, forKey: PropertyKey.foodDescription)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        //the name is required, if we cannot decode a name string, init should fail
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
            else{
                os_log("Unable to decode the ame for a Meal object.", log: OSLog.default, type: .debug)
                return nil
        }
        //since photo is an optional property of Meal, just use conditional cast
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
//        let calories = aDecoder.decodeInteger(forKey: PropertyKey.calories)
//        
//        guard let foodDescription = aDecoder.decodeObject(forKey: PropertyKey.foodDescription) as? String
        
        //must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    
}
}
