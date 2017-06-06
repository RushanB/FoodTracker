//
//  CloudTrackerAPI.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-05.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class CloudTrackerAPI: NSObject {
    
    
    public func postRequest(postData : [String:String], completion: @escaping ([String:[String:String]]) -> Void) {
        guard let postJSON = try? JSONSerialization.data(withJSONObject: postData, options: []) else {
            print("could not serialize json")
            return
        }
        
        let req = NSMutableURLRequest(url: URL(string:"http://159.203.243.24:8000/signup")!)
        
        req.httpBody = postJSON
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(String(describing: err))")
                return
            }
            
            guard let resp = resp as? HTTPURLResponse else {
                print("no response returned from server \(String(describing: err))")
                return
            }
            
            guard let rawJSON = try? JSONSerialization.jsonObject(with: data, options: []) else {
                print("data returned is not json, or not valid")
                return
            }
            
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred")
                return
            }
            
            completion(rawJSON as! [String : [String : String]])
            
        }
        
        task.resume()
        
    }
    
    
    //method to post data
    func post(data: [String: AnyObject], toEndpoint: String, completion: @escaping (Data?, NSError?)->(Void)){
        
        //postJSON
        guard let postJSON = try? JSONSerialization.data(withJSONObject: data, options: []) else {
            print("could not serialize json")
            return
        }
        print(postJSON)
        let string = toEndpoint
        let req = NSMutableURLRequest(url: URL(string:"http://159.203.243.24:8000/\(string)")!)
        print("http://159.203.243.24:8000/\(string)")
        
        //request data
        req.httpBody = postJSON
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: req as URLRequest) { (data, resp, err) in
            //data
            guard let data = data else {
                print("no data returned from server \(String(describing: err))")
                return
            }
            //response
            guard let resp = resp as? HTTPURLResponse else {
                print("no response returned from server \(String(describing: err))")
                return
            }
            //check response
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred")
                return
            }
            //completion catcher
            completion(data,err as NSError?)
            
        }
        //resume task
        task.resume()
        
        
    }
    
    //method to save meal, calls post method
    func saveMeal(meal: Meal, completion: @escaping (NSError?)->(Void)){
        
        //upload the meal from the url
        let upload = meal
        let req = NSMutableURLRequest(url: URL(string:"http://159.203.243.24:8000/users/me/meals/:id/photo")!)
        guard let photo = upload.photo else{
            return
        }
        guard let data = UIImagePNGRepresentation(photo) else{
            return
        }
        //request data
        req.httpBody = data
        req.httpMethod = "POST"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        //parse data
        let task = URLSession.shared.dataTask(with: req as URLRequest) { (data, resp, err) in
            //data
            guard data != nil else {
                print("no data returned from server \(String(describing: err))")
                return
            }
            //response
            guard let resp = resp as? HTTPURLResponse else {
                print("no response returned from server \(String(describing: err))")
                return
            }//check response
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred")
                return
            }
            //completion catcher
            completion(err as NSError?)
            
        }
        //resume task
        task.resume()
    }
}
