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
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailTextView: UITextView!
    @IBOutlet weak var totalTimeAndRatingRecipeLabel: UILabel!
    
    private var displayRecipeImage: UIImage?
    private var displayRecipeTitle: String?
    private var displayRecipeDetail: String?
    private var displayTotalTimeAndRatingRecipe: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }
    
    private func displayRecipe() {
        guard let title = displayRecipeTitle, let image = displayRecipeImage, let detail = displayRecipeDetail, let totalTimeAndRating = displayTotalTimeAndRatingRecipe  else {
            return
        }
        recipeTitleLabel.text = title
        recipeImageView.image = image
        recipeDetailTextView.text = detail
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
}


