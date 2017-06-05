//
//  ViewController.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-03.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    //MARK: properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var foodDescriptionTextField: UITextField!
    
    //Adding a new Meal
    var meal: Meal?
    
    
    //MARK: viewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle the text fields user input through delegate callbacks
        nameTextField.delegate = self;
        
        //set up views if editing an existing Meal
        if let meal = meal{
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
            caloriesTextField.text = String(meal.calories)
            foodDescriptionTextField.text = meal.foodDescription
        }
        
        //enable the save button only if the text field has a valid meal name
        updateSaveButtonState()
    
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //disable the save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
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
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //(modal or push), this view controller needs to be dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode{
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The ViewController is not inside a nagivation controller.")
        }
    }
    
    //this methods lets you configure a view controller before its presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //configure the destination vc only when save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? "" //nil coalescing operator
        let photo = photoImageView.image
        let rating = ratingControl.rating
        let caloriesString = caloriesTextField.text ?? "0"
            let calories = Int(caloriesString) ?? 0 //type cast calories from string to int
        let foodDescription = foodDescriptionTextField.text ?? ""
        
        //set the meal to be passed to the tablevc after the unwind segue
        meal = Meal(name: name, photo: photo, rating: rating, calories: calories, foodDescription: foodDescription)
        
    }
    
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController() //pick media from library
        imagePickerController.sourceType = .photoLibrary //photos to be picked
        
        imagePickerController.delegate = self // make sure vc is notified
        present(imagePickerController, animated: true, completion: nil) //present the view controller
    
    }
    
    
    //MARK: Warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState(){
        //disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }


}

