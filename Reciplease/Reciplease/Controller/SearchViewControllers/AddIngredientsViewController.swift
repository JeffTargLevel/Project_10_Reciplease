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
    
    private func addIngredients() {
        guard let ingredient = addIngredientsTextField.text,
            var listIngredients = addedIngredientsTextView.text else {
                return
        }
        guard ingredient.count > 0 else {
            return presentAlert()
        }
        listIngredients += "- " + ingredient + "\n"
        addedIngredientsTextView.text = listIngredients
        addIngredientsTextField.text = ""
    }
    
    private func clearListIngredients() {
        addIngredientsTextField.text = ""
        addedIngredientsTextView.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Enter ingredient")
    }
    
    @IBAction func tapAddIngredientsButton(_ sender: Any) {
        addIngredients()
    }
    
    @IBAction func tapClearListIngredientsButton(_ sender: Any) {
        clearListIngredients()
    }
    
    @IBAction func tapSearchForRecipesButton(_ sender: Any) {
    }
}
