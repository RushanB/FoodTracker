//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Rushan on 2017-06-04.
//  Copyright © 2017 RushanBenazir. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    
    var rating = 0{
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButtons()
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton){
//        print("Button pressed 👍")
        guard let index = ratingButtons.index(of: button)else{
            fatalError("The Button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        //calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating{ //if selected star represents current rating
            rating = 0  //reset rating to 0
        }else{
            rating = selectedRating  //set rating to te selected star
        }
        
    }
    
    
    //MARK: Private Methods
    private func setupButtons(){
        
        //clear any existing buttons
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //loads button images
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
        
        for index in 0..<starCount{
            
            let button = UIButton()  //create button
            
            //set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            
            //add contraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //set the accessibility label
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            //button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            
            addArrangedSubview(button) //adds the button to the stack
            ratingButtons.append(button) //add the new button to the ratting button array
            
        }
        
        updateButtonSelectionStates()
    }
    
    
    private func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerated(){
            //if index of a button is less than the rating, that button should be selected
            button.isSelected = index < rating
            
            //set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1{
                hintString = "Tap to reset the rating to zero."
            }else{
                hintString = nil
            }
            
            //calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
            //assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    
    
}
