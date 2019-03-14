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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        clearListIngredients()
    }
    // MARK: - Add ingredients in addIngredientsTextField and display in addedIngredientsTextView
    
    private func addIngredients() {
        guard var ingredient = addIngredientsTextField.text,
            var listIngredients = addedIngredientsTextView.text else {return}
        
        guard ingredient.count > 0 else {
            return presentAlertEnterIngredient()
        }
        
        guard !((ingredient.contains("egg") || ingredient.contains("eggs")) && SettingService.eggAllergy == "397^Egg-Free") else {
           presentAlertExcludedIngredient()
            return
        }
        
        guard !(ingredient.contains("gluten") && SettingService.glutenAllergy == "393^Gluten-Free") else {
            presentAlertExcludedIngredient()
            return
        }
        
        guard !(ingredient.contains("peanut") && SettingService.peanutAllergy == "394^Peanut-Free") else {
            presentAlertExcludedIngredient()
            return
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
    
    private func presentAlertEnterIngredient() {
        presentAlert(withTitle: "Error", message: "Enter ingredients", dissmiss: false)
    }
    
    private func presentAlertExcludedIngredient() {
        presentAlert(withTitle: "Error", message: "Excluded ingredient", dissmiss: false)
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

