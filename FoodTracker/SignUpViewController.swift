//
//  SignUpViewController.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-05.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: Properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    //MARK: CloudTracker
    let cloudTracker = CloudTrackerAPI()
    let urlString = "signup"

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        warningLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func signUpTapped(_ sender: UIButton) { //sign up should be valid
        guard let password = passwordTextField.text
            else{
                warningLabel.text = "Not a valid password."
                warningLabel.isHidden = false
                return
        }
        guard let username = usernameTextField.text
            else{
                warningLabel.text = "Not a valid username."
                warningLabel.isHidden = false
                return
        }
        guard password.characters.count > 5
            else{
                warningLabel.text = "Password must be more than 6 characters."
                warningLabel.isHidden = false
                return
        }
        self.dismiss(animated: true, completion: nil)
        
        let postData = ["username": username, "password": password]
        
        cloudTracker.postNetworkInformation(stringForJSON: postData, stringForUrl: urlString)
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func logInTapped(_ sender: UIButton) {  //log in button segues to LogIn VC
        performSegue(withIdentifier: "LogIn", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
