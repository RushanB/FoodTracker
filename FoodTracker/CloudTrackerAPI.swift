//
//  CloudTrackerAPI.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-05.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class CloudTrackerAPI: NSObject {
    
    //MARK: URL String
    let url = URL(string: "http://159.203.243.24:8000")!
    
    
    //MARK: Method to append URL
    func postNetworkInformation(stringForJSON:[String: String], stringForUrl:String) -> Void{
        
        
        //standard user default
        let newUserDefaults = UserDefaults.standard
        
        //gets the JSON
        guard let postJSON = try? JSONSerialization.data(withJSONObject: stringForJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
            else {
                print("could not serialize json")
                return
        }
        
        //request url with path components
        let request = NSMutableURLRequest(url: url.appendingPathComponent(stringForUrl))
        
        request.httpBody = postJSON
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            
            (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data
                else {
                    print("no data returned from server \(error?.localizedDescription)")
                    return
            }
            guard let response = response as? HTTPURLResponse
                else {
                    print("no response returned from server \(error)")
                    return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Dictionary<String,String>>
                else {
                    print("data returned is not json, or not valid")
                    return
            }
            guard response.statusCode == 200
                else {
                    // handle error
                    print("an error occurred \(json["error"])")
                    return
            }
            newUserDefaults.set(json["user"], forKey: "user")
            newUserDefaults.synchronize()
        }
        // do something with the json object
        task.resume()
        
    }
    
    func saveMeal(meal: Meal, completion: (NSError?)->(Void)){
        
    }
    
}
