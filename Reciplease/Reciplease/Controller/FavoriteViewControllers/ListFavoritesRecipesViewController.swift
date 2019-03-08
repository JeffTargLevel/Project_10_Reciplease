//
//  ListFavoritesRecipesViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class ListFavoritesRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listFavoritesRecipesTableView: UITableView!
    @IBOutlet weak var noFavoritesRecipesLabel: UILabel!
    
    private var recipeImage: UIImage?
    private var recipeName:String?
    private var recipeIngredients: String?
    private var recipeTotalTimeAndRating: String?
    private var ingredientLines: String?
    private var indexFavoriteRecipe: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listFavoritesRecipesTableView.reloadData()
        displayNoFavoritesRecipes()
    }
    
    private func displayNoFavoritesRecipes() {
        guard FavoriteRecipe.all.count > 0 else {
            noFavoritesRecipesLabel.isHidden = false
            return
        }
        noFavoritesRecipesLabel.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteRecipe.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteRecipeCell", for: indexPath) as? FavoriteRecipeTableViewCell else {
            return UITableViewCell()
        }
        let favoriteRecipe = FavoriteRecipe.all[indexPath.row]
        guard let image = favoriteRecipe.image, let recipeTitle = favoriteRecipe.name, let recipeDetail = favoriteRecipe.ingredients, let totalTimeAndRating = favoriteRecipe.totalTimeAndRating, let ingredientLines = favoriteRecipe.ingredientLines else {
            return UITableViewCell()
        }
        
        cell.configure(with: image, recipeTitle: recipeTitle, recipeDetail: recipeDetail, totalTimeAndRating: totalTimeAndRating, ingredientLines: ingredientLines)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let favoriteRecipe = FavoriteRecipe.all[indexPath.row]
        FavoriteRecipe.remove(favoriteRecipe: favoriteRecipe)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    private func configureCurrentCell() {
        guard let indexPath = listFavoritesRecipesTableView.indexPathForSelectedRow,
            let currentCell = listFavoritesRecipesTableView.cellForRow(at: indexPath) as? FavoriteRecipeTableViewCell else {return}
        
        recipeImage = currentCell.recipeImageView.image
        recipeName = currentCell.recipeTitleLabel.text
        recipeIngredients = currentCell.recipeDetailLabel.text
        recipeTotalTimeAndRating = currentCell.totalTimeAndRatingRecipeLabel.text
        ingredientLines = currentCell.ingredientLines
        indexFavoriteRecipe = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        configureCurrentCell()
        guard segue.identifier == "DisplayFavoriteRecipe" else {return}
        
        guard let viewController = segue.destination as? FavoriteRecipeViewController else {return}
        
        viewController.displayRecipeImage = recipeImage
        viewController.displayRecipeName = recipeName
        viewController.displayRecipeIngredients = recipeIngredients
        viewController.displayRecipeTotalTimeAndRating = recipeTotalTimeAndRating
        viewController.ingredientLines = ingredientLines
        viewController.indexFavoriteRecipe = indexFavoriteRecipe
    }
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Search failed")
    }
}
