//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeIngredientsTextView: UITextView!
    @IBOutlet weak var recipeTotalTimeAndRatingLabel: UILabel!
    @IBOutlet weak var dissmissButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var displayRecipeImage: UIImage?
    var displayRecipeName: String?
    var displayRecipeIngredients: String?
    var displayRecipeTotalTimeAndRating: String?
    
    private var isNotAlreadyAfavorite: Bool {
        for (_, recipe) in RecipesService.favoritesRecipes.enumerated() {
            guard recipe.name != displayRecipeName else {
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
        toogleFavoriteButton()
    }
    
    private func toogleFavoriteButton() {
        guard isNotAlreadyAfavorite else {
            favoriteButton.isSelected = true
            return
        }
        favoriteButton.isSelected = false
    }
    
    private func transformCircleButton(_ button: UIButton) {
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    private func displayRecipe() {
        guard let name = displayRecipeName, let image = displayRecipeImage, let ingredients = displayRecipeIngredients, let totalTimeAndRating = displayRecipeTotalTimeAndRating  else {
            return
        }
        recipeNameLabel.text = name
        recipeImageView.image = image
        recipeIngredientsTextView.text = "- " + ingredients.replacingOccurrences(of: ",", with: "\n\n- ")
        recipeTotalTimeAndRatingLabel.text = totalTimeAndRating
        recipeTotalTimeAndRatingLabel.layer.cornerRadius = 20
        transformCircleButton(dissmissButton)
        transformCircleButton(favoriteButton)
    }
    
    private func saveFavoriteRecipe() {
        guard let name = recipeNameLabel.text, let image = recipeImageView.image, var ingredients = recipeIngredientsTextView.text, let totalTimeAndRating = recipeTotalTimeAndRatingLabel.text else {
            return
        }
        ingredients = recipeIngredientsTextView.text.replacingOccurrences(of: "\n\n- ", with: ",").replacingOccurrences(of: "- ", with: "")
        let favoriteRecipe = Recipe(name: name, ingredients: ingredients, totalTimeAndRating: totalTimeAndRating, recipeImage: image)
        guard isNotAlreadyAfavorite else {
            return
        }
        RecipesService.addFavorite(recipe: favoriteRecipe)
    }
    
    private func removeFavoriteRecipe() {
        guard !isNotAlreadyAfavorite else {
            return
        }
    }
    
    @IBAction func tapFavoriteButton() {
        saveFavoriteRecipe()
        toogleFavoriteButton()
    }
}
