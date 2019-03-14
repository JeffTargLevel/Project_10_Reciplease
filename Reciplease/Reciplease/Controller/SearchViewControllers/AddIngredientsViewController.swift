//
//  AddIngredientsViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 31/01/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class AddIngredientsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addIngredientsTextField: UITextField!
    @IBOutlet weak var addedIngredientsTextView: UITextView!
    @IBOutlet weak var searchForRecipesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showSearchRecipesButton()
    }
    
    // MARK: - Add ingredients in addIngredientsTextField and display in addedIngredientsTextView
    
    private func addIngredients() {
        guard var ingredient = addIngredientsTextField.text,
            var listIngredients = addedIngredientsTextView.text else {return}
        
        guard ingredient.count > 0 else {
            return presentAlert()
        }
        ingredient = ingredient.replacingOccurrences(of: ",", with: "+")
        RecipesService.ingredient.name += ingredient
        ingredient = ingredient.replacingOccurrences(of: "+", with: "\n\n☞ ")
        listIngredients += "☞ " + ingredient + "\n\n"
        addedIngredientsTextView.text = listIngredients
        addIngredientsTextField.text = ""
        showSearchRecipesButton()
    }
    
    // MARK: - Clear any add ingredients
    
    private func clearListIngredients() {
        addIngredientsTextField.text = ""
        addedIngredientsTextView.text = ""
        RecipesService.ingredient.name = ""
        showSearchRecipesButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Show or hidden showSearchRecipeButton
    
    private func showSearchRecipesButton() {
        guard addedIngredientsTextView.text.count > 0 else {
            return searchForRecipesButton.isHidden = true
        }
        searchForRecipesButton.isHidden = false
    }
    
    // MARK: - Alert controller with extension
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Enter ingredients", dissmiss: false)
    }
    
    @IBAction func tapAddIngredientsButton(_ sender: Any) {
        addIngredients()
    }
    
    @IBAction func tapClearListIngredientsButton(_ sender: Any) {
        clearListIngredients()
    }
    
    @IBAction func tapSearchForRecipesButton(_ sender: Any) {}
    
    @IBAction func unwindAddIngredients(segue: UIStoryboardSegue) {}
}

