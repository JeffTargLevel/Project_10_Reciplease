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
    
    // MARK: - Enabled addFavoriteButton if the recipe is not in favorites
    
    private func toogleAddFavoriteButtonItem() {
        guard isNotAlreadyAfavorite else {
           return addFavoriteButtonItem.isEnabled = false
        }
        addFavoriteButtonItem.isEnabled = true
    }
    
    // MARK: - Display recipe
    
    private func displayRecipe() {
        guard let name = displayRecipeName, let image = displayRecipeImage, let ingredients = displayRecipeIngredients, let totalTimeAndRating = displayRecipeTotalTimeAndRating else {return}
        
        recipeNameLabel.text = name
        recipeImageView.image = image
        recipeIngredientsTextView.text = "☞ " + ingredients.replacingOccurrences(of: ", ", with: "\n\n☞ ")
        recipeTotalTimeAndRatingLabel.text = totalTimeAndRating
        recipeTotalTimeAndRatingLabel.layer.cornerRadius = 20
    }
    
    // MARK: - Add and save recipe in favorite if it isn't already
    
    private func addFavoriteRecipe() {
        guard let name = recipeNameLabel.text, let image = recipeImageView.image, var ingredients = recipeIngredientsTextView.text, let totalTimeAndRating = recipeTotalTimeAndRatingLabel.text, let ingredientLines = ingredientLines else {return}
        
        guard isNotAlreadyAfavorite else {return}
        ingredients = recipeIngredientsTextView.text.replacingOccurrences(of: "\n\n☞ ", with: ", ").replacingOccurrences(of: "☞ ", with: "")
        FavoriteRecipe.saveFavoriteRecipe(name: name, ingredients: ingredients, totalTimeAndRating: totalTimeAndRating, image: image, ingredientLines: ingredientLines)
    }
    
    // MARK: Prepare for segue for display recipe detail in RecipeDetailViewController
    
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
