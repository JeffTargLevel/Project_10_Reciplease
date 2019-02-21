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
    
    private var recipe: Recipe?
    
    private var displayRecipeImage: UIImage?
    private var displayRecipeTitle:String?
    private var displayRecipeDetail: String?
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
        toggleActivityIndicator(shown: true)
        RecipesService.getRecipes { (success, recipe) in
            self.toggleActivityIndicator(shown: false)
            if success, let recipe = recipe {
                self.recipe = recipe
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
        cell.configure(with: recipe.recipeImage, recipeTitle: recipe.name, recipeDetail: recipe.ingredients, totalTime: recipe.totalTime, rating: recipe.rating)
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    
        guard let indexPath = tableView.indexPathForSelectedRow,
            let currentCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {
                return 
        }
        
        displayRecipeImage = currentCell.recipeImageView.image
        displayRecipeTitle = currentCell.recipeTitleLabel.text
        displayRecipeDetail = currentCell.recipeDetailLabel.text
        displayRecipeTotalTimeAndRating = currentCell.totalTimeAndRatingRecipeLabel.text
    
    
    performSegue(withIdentifier: "DisplayRecipe", sender: self)
    
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        guard segue.identifier == "DisplayRecipe" else {
            return
        }
            
        guard let viewController = segue.destination as? RecipeDetailsViewController else {
            return
        }
            viewController.displayRecipeImage = displayRecipeImage
            
            viewController.displayRecipeTitle = displayRecipeTitle
            viewController.displayRecipeDetail = displayRecipeDetail
            viewController.displayTotalTimeAndRatingRecipe = displayRecipeTotalTimeAndRating
        
        
        print("hello")
       
    }
    
    private func removeTableView() {
        RecipesService.recipes.removeAll()
        listRecipesTableView.reloadData()
    }
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Search failed")
    }
    
    
}
