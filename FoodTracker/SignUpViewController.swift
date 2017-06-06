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
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        warningLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //hide the keyboard
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func signUpTapped(_ sender: UIButton) { //sign up should be valid
        guard (usernameTextField.text as String!) != nil else{
            
            self.warningLabel.isHidden = false
            return
        }
        
        guard (passwordTextField.text as String!) != nil else{
            
            self.warningLabel.isHidden = false
            return
        }
        
        guard ((passwordTextField.text!.characters.count) as Int) > 5 else {
            
            self.warningLabel.isHidden = false
            return
        }
        
        
        let postData = [
            "username": usernameTextField.text ?? "",
            "password": passwordTextField.text ?? ""
        ]
        
        let defaults = UserDefaults.standard
        let cloudTracker = CloudTrackerAPI()
        
        cloudTracker.post(data: postData as [String : AnyObject], toEndpoint: "signup", completion: {
            
            (completion:(data: Data?, error: NSError?)) in
            guard let rawJSON = try? JSONSerialization.jsonObject(with: completion.data!, options: []) as! [String:[String:String]] else {
                
                print("data returned is not json, or not valid")
                return
            }
            
            defaults.set(rawJSON["user"], forKey: "user")
            self.dismiss(animated: true, completion: nil)
        })
    }
}
