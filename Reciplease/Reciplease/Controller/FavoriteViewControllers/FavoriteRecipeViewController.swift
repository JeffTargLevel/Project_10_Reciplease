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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }
    
    private func displayRecipe() {
        guard let title = displayRecipeName, let image = displayRecipeImage, let detail = displayRecipeIngredients, let totalTimeAndRating = displayRecipeTotalTimeAndRating  else {return}
        
        recipeTitleLabel.text = title
        recipeImageView.image = image
        recipeDetailTextView.text = detail
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
    
    private func removeFavoriteRecipe() {
        guard let indexFavoriteRecipe = indexFavoriteRecipe else {return}
        let favoriteRecipe = FavoriteRecipe.all[indexFavoriteRecipe]
        FavoriteRecipe.remove(favoriteRecipe: favoriteRecipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DisplayFavoriteRecipeDetail" else {return}
        
        guard let viewController = segue.destination as? FavoriteRecipeDetailViewController else {return}
        
        viewController.ingredientLines = ingredientLines
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

