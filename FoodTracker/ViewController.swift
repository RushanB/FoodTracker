//
//  ViewController.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-03.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    //MARK: properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    
    
    //MARK: viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self;
    
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        
    }
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //ndiss the picker if user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //use original image
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //set photoimageview to display selectedimage
        photoImageView.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController() //pick media from library
        imagePickerController.sourceType = .photoLibrary //photos to be picked
        
        imagePickerController.delegate = self // make sure vc is notified
        present(imagePickerController, animated: true, completion: nil) //present the view controller
        
        
    }
    
    
    //MARK: warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

