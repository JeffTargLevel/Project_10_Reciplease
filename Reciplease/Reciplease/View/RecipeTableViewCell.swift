//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 08/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var RecipeImageView: UIImageView!
    @IBOutlet weak var RecipeTitleLabel: UILabel!
    @IBOutlet weak var RecipeDetailLabel: UILabel!
    @IBOutlet weak var totalTimeAndRatingRecipeLabel: UILabel!
    
    func configure(with image: UIImage, recipeTitle: String, recipeDetail: String, totalTime: String, rating: String) {
        RecipeImageView.image = image
        RecipeTitleLabel.text = recipeTitle
        RecipeDetailLabel.text = recipeDetail
        totalTimeAndRatingRecipeLabel.text = totalTime + " " + "M" + "\n" + rating + " " + "🙂"
    }
}
