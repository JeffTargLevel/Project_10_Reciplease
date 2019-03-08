//
//  FavoriteRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 21/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailLabel: UILabel!
    @IBOutlet weak var totalTimeAndRatingRecipeLabel: UILabel!
    
    var ingredientLines: String?
    
    func configure(with image: Data, recipeTitle: String, recipeDetail: String, totalTimeAndRating: String, ingredientLines: String) {
        recipeImageView.image = UIImage(data: image)
        recipeTitleLabel.text = recipeTitle
        recipeDetailLabel.text = recipeDetail
        totalTimeAndRatingRecipeLabel.text = totalTimeAndRating
        self.ingredientLines = ingredientLines
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
}
