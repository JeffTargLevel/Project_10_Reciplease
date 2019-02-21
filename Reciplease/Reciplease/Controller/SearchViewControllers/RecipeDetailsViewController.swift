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
    @IBOutlet weak var dissmissButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var displayRecipeImage: UIImage?
    var displayRecipeTitle: String?
    var displayRecipeDetail: String?
    var displayTotalTimeAndRatingRecipe: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRecipe()
    }
    
    private func transformCircleButton(_ button: UIButton) {
        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
    }
    
    private func displayRecipe() {
        guard let title = displayRecipeTitle, let image = displayRecipeImage, let detail = displayRecipeDetail, let totalTimeAndRating = displayTotalTimeAndRatingRecipe  else {
            return
        }
        recipeTitleLabel.text = title
        recipeImageView.image = image
        recipeDetailTextView.text = "- " + detail.replacingOccurrences(of: ",", with: "\n\n- ")
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
        transformCircleButton(dissmissButton)
        transformCircleButton(favoriteButton)
    }
    
    @IBAction func dissmiss() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}


