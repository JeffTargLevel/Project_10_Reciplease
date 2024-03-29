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
    
    var displayRecipeImage: UIImage?
    var displayRecipeName: String?
    var displayRecipeIngredients: String?
    var displayRecipeTotalTimeAndRating: String?
    var recipeId: String?
    var ingredientLines: String?
    var url: String?
    
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
        updateRecipeDetailRequest()
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
    
    // MARK: - Update request for recipe detail
    
    private func updateRecipeDetailRequest() {
        guard let recipeId = recipeId else {return}
        
        RecipesService.getRecipeDetailAndUrl(recipeId: recipeId) { (ingredientLines, url) in
            guard let ingredientLines = ingredientLines, let url = url else {
                self.presentAlertForSearchFailed()
                return
            }
            self.ingredientLines = ingredientLines
            self.url = url
        }
    }
    // MARK: - Add and save recipe in favorite if it isn't already
    
    private func addFavoriteRecipe() {
        guard let name = recipeNameLabel.text, let image = recipeImageView.image, var ingredients = recipeIngredientsTextView.text, let totalTimeAndRating = recipeTotalTimeAndRatingLabel.text, let ingredientLines = ingredientLines, let url = url else {return}
        
        guard isNotAlreadyAfavorite else {return}
        ingredients = recipeIngredientsTextView.text.replacingOccurrences(of: "\n\n☞ ", with: ", ").replacingOccurrences(of: "☞ ", with: "")
        FavoriteRecipe.saveFavoriteRecipe(name: name, ingredients: ingredients, totalTimeAndRating: totalTimeAndRating, image: image, ingredientLines: ingredientLines, url: url)
    }
    
    // MARK: Prepare for segue for display recipe detail in RecipeDetailViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DisplayRecipeDetail" else {return}
        
        guard let viewController = segue.destination as? RecipeDetailViewController else {return}
        
        viewController.ingredientLines = ingredientLines
    }
    
    // MARK: - Alert controller with extension
    
    private func presentAlertForSearchFailed() {
        presentAlert(withTitle: "Error", message: "Search failed", dissmiss: false)
    }
    
    private func presentAlertRecipeAdded() {
        presentAlert(withTitle: "Cool !", message: "Recipe added in favorite", dissmiss: false)
    }
    
    @IBAction func tapAddFavoriteButtonItem(_ sender: Any) {
        addFavoriteRecipe()
        toogleAddFavoriteButtonItem()
        presentAlertRecipeAdded()
    }
    
    @IBAction func tapRecipeDetailButton() {}
}
