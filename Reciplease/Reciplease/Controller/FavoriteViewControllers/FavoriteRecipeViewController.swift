//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class FavoriteRecipeViewController: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    @IBOutlet weak var totalTimeAndRatingRecipeLabel: UILabel!
    
    var displayRecipeImage: UIImage?
    var displayRecipeName: String?
    var displayRecipeIngredients: String?
    var displayRecipeTotalTimeAndRating: String?
    var ingredientLines: String?
    var indexFavoriteRecipe: Int?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }
   
    // MARK: - Display recipe saved
    
    private func displayRecipe() {
        guard let title = displayRecipeName, let image = displayRecipeImage, let ingredients = displayRecipeIngredients, let totalTimeAndRating = displayRecipeTotalTimeAndRating  else {return}
        
        recipeTitleLabel.text = title
        recipeImageView.image = image
        recipeDetailTextView.text = "☞ " + ingredients.replacingOccurrences(of: ", ", with: "\n\n☞ ")
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
    
    // MARK: - Delete recipe saved
    
    private func removeFavoriteRecipe() {
        guard let indexFavoriteRecipe = indexFavoriteRecipe else {return}
        let favoriteRecipe = FavoriteRecipe.all[indexFavoriteRecipe]
        FavoriteRecipe.remove(favoriteRecipe: favoriteRecipe)
    }
    
    // MARK: - Prepare for segue for display recipe detail in FavoriteRecipeDetailViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DisplayFavoriteRecipeDetail" else {return}
        
        guard let viewController = segue.destination as? FavoriteRecipeDetailViewController else {return}
        
        viewController.ingredientLines = ingredientLines
        viewController.url = url
    }
    
    @IBAction func tapTrashFavoriteRecipeButtonItem(_ sender: Any) {
        removeFavoriteRecipe()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapDissmissButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapFavoriteRecipeDetailButton() {}
}
