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
    
    func configure(with image: UIImage, recipeTitle: String, recipeDetail: String, totalTime: Int, rating: Int) {
        recipeImageView.image = image
        recipeTitleLabel.text = recipeTitle
        recipeDetailLabel.text = recipeDetail
        totalTimeAndRatingRecipeLabel.text = String("\(totalTime)" + " " + "M" + "\n" + "\(rating)" + " " + "🙂")
        totalTimeAndRatingRecipeLabel.layer.cornerRadius = 20
    }
}
