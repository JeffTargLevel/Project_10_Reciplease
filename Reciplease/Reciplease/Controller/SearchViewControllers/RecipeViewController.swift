//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var addFavoriteButtonItem: UIBarButtonItem!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTextView: UITextView!
    @IBOutlet weak var recipeTotalTimeAndRatingLabel: UILabel!
    @IBOutlet weak var favoriteRecipeDetailButton: UIButton!
    
    var displayRecipeImage: UIImage?
    var displayRecipeName: String?
    var displayRecipeIngredients: String?
    var displayRecipeTotalTimeAndRating: String?
    var ingredientLines: String?
    
    private var isNotAlreadyAfavorite: Bool {
        for (_, recipe) in FavoriteRecipe.all.enumerated() {
            guard recipe.name != displayRecipeName else {
                return false
            }
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        displayRecipe()
        toogleAddFavoriteButtonItem()
    }
    
    private func toogleAddFavoriteButtonItem() {
        guard isNotAlreadyAfavorite else {
            addFavoriteButtonItem.isEnabled = false
            return
        }
        addFavoriteButtonItem.isEnabled = true
    }
    
    private func displayRecipe() {
        guard let name = displayRecipeName, let image = displayRecipeImage, let ingredients = displayRecipeIngredients, let totalTimeAndRating = displayRecipeTotalTimeAndRating else {return}
        
        recipeNameLabel.text = name
        recipeImageView.image = image
        recipeIngredientsTextView.text = "- " + ingredients.replacingOccurrences(of: ",", with: "\n\n- ")
        recipeTotalTimeAndRatingLabel.text = totalTimeAndRating
        recipeTotalTimeAndRatingLabel.layer.cornerRadius = 20
    }
    
    private func addFavoriteRecipe() {
        guard let name = recipeNameLabel.text, let image = recipeImageView.image, let ingredients = recipeIngredientsTextView.text, let totalTimeAndRating = recipeTotalTimeAndRatingLabel.text, let ingredientLines = ingredientLines else {return}
        
        guard isNotAlreadyAfavorite else {return}
        
        FavoriteRecipe.saveFavoriteRecipe(name: name, ingredients: ingredients, totalTimeAndRating: totalTimeAndRating, image: image, ingredientLines: ingredientLines)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DisplayRecipeDetail" else {return}
        
        guard let viewController = segue.destination as? RecipeDetailViewController else {return}
        
        viewController.ingredientLines = ingredientLines
    }
    
    @IBAction func tapAddFavoriteButtonItem(_ sender: Any) {
        addFavoriteRecipe()
        toogleAddFavoriteButtonItem()
    }
    
    @IBAction func tapFavoriteRecipeDetailButton() {}
}
