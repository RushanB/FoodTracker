////: Playground - noun: a place where people can play
//
//import UIKit
//import PlaygroundSupport
//
//PlaygroundPage.current.needsIndefiniteExecution = true
//
//
//
//func fetchObjects(){
//    let session = URLSession.shared
//    let url = URL(string: "http://159.203.243.24:8000/users/me/meals/")
//    var request = URLRequest(url: url!)
//    
//    request.setValue("_wd8VJrmC8QlcpF4jk4LtgRUHZ-h_t64hOeCSwSd7t8", forHTTPHeaderField: "token")
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//  
//
//    let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//        
//        guard let data = data else{
//            print(error = )
//            return
//        }
//      
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 {
//        
//            return
//        }
//
//        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String,Any] else {
//            print(#line, "json problems")
//            return
//        }
//        
//        print (data ?? "it's nil")
//        
//        
//    }
//    task.resume()
//    
//}
//fetchObjects()
//
// call the function
