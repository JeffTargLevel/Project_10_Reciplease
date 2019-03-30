//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 08/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailLabel: UILabel!
    @IBOutlet weak var totalTimeAndRatingRecipeLabel: UILabel!
    
    var recipeId: String?
    
    func configure(with image: UIImage, recipeTitle: String, recipeDetail: String, totalTimeAndRating: String, recipeId: String) {
        recipeImageView.image = image
        recipeTitleLabel.text = recipeTitle
        recipeDetailLabel.text = recipeDetail
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        self.recipeId = recipeId
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
}
