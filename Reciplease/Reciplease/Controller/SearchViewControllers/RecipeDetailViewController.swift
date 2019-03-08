//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var recipeDetailTextView: UITextView!
    
    var ingredientLines: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayIngredientLines()
    }
    
    // MARK: - Display recipe detail
    
    private func displayIngredientLines() {
        guard let ingredientLines = ingredientLines else {return}
        
        recipeDetailTextView.text = "- " + ingredientLines.replacingOccurrences(of: ",", with: "\n\n- ")
    }
    
    @IBAction func tapDissmissButton() {
        dismiss(animated: true, completion: nil)
    }
}

