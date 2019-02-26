//
//  ListRecipesViewController.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 01/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import UIKit

class ListRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var listRecipesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var displayRecipeImage: UIImage?
    private var displayRecipeName:String?
    private var displayRecipeIngredients: String?
    private var displayRecipeTotalTimeAndRating: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRequest()
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        listRecipesTableView.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func updateRequest() {
        RecipesService.removeAllRecipes()
        toggleActivityIndicator(shown: true)
        RecipesService.getRecipes { (success, recipe) in
            self.toggleActivityIndicator(shown: false)
            if success, let recipe = recipe {
                RecipesService.add(recipe: recipe)
                self.listRecipesTableView.reloadData()
            } else {
                self.presentAlert()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipesService.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = RecipesService.recipes[indexPath.row]
        cell.configure(with: recipe.recipeImage, recipeTitle: recipe.name, recipeDetail: recipe.ingredients, totalTimeAndRating: recipe.totalTimeAndRating)
        return cell
    }
    
    private func configureCurrentCell() {
        guard let indexPath = listRecipesTableView.indexPathForSelectedRow, let currentCell = listRecipesTableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
            return
        }
        displayRecipeImage = currentCell.recipeImageView.image
        displayRecipeName = currentCell.recipeTitleLabel.text
        displayRecipeIngredients = currentCell.recipeDetailLabel.text
        displayRecipeTotalTimeAndRating = currentCell.totalTimeAndRatingRecipeLabel.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        configureCurrentCell()
    
        guard segue.identifier == "DisplayRecipe" else {
            return
        }
            
        guard let viewController = segue.destination as? RecipeDetailsViewController else {
            return
        }
            viewController.displayRecipeImage = displayRecipeImage
            viewController.displayRecipeName = displayRecipeName
            viewController.displayRecipeIngredients = displayRecipeIngredients
            viewController.displayRecipeTotalTimeAndRating = displayRecipeTotalTimeAndRating
    }
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Search failed")
    }
    
    
}
