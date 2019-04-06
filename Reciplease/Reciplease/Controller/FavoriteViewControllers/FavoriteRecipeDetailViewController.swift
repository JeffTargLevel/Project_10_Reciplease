//
//  FavoriteRecipeDetailViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/03/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class FavoriteRecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteRecipeDetailTextView: UITextView!
    
    var ingredientLines: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayIngredientLines()
    }
    
    // MARK: - Display recipe detail
    
    private func displayIngredientLines() {
        guard let ingredientLines = ingredientLines else {return}
        
        favoriteRecipeDetailTextView.text = "☞ " + ingredientLines.replacingOccurrences(of: ",", with: "\n\n☞ ")
    }
    
    // MARK: - Share favorite recipe
    
    private func shareRecipe() {
        let message = "My favorite recipe"
        
        if let link = url {
            
            let objectsToShare = [message,link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapDissmissButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapShareFavoriteRecipeButton() {
        shareRecipe()
    }
}

