//
//  LogInViewController.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-05.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: CloudTracker
    let cloudTracker = CloudTrackerAPI()
    let urlString = "login"
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func logInTapped(_ sender: UIButton) {
        guard let password = passwordTextField.text
            else{
                return
        }
        guard let username = usernameTextField.text
            else{
                return
        }
        guard password.characters.count > 5
            else{
                return
        }
        let postData = ["username": username, "password": password]
        
        cloudTracker.postNetworkInformation(stringForJSON: postData, stringForUrl: urlString)
        
        performSegue(withIdentifier: "showMeals", sender: self)
    }

}
