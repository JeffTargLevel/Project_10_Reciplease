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
    
    private var recipeImage: UIImage?
    private var recipeName: String?
    private var recipeIngredients: String?
    private var recipeTotalTimeAndRating: String?
    private var recipeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listRecipesTableView.reloadData()
    }
    
    // MARK: - TableView for recipes found
    
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
        cell.configure(with: recipe.recipeImage, recipeTitle: recipe.name, recipeDetail: recipe.ingredients, totalTimeAndRating: recipe.totalTimeAndRating, recipeId: recipe.recipeId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - Configure cell and prepare for segue at recipeViewController
    
    private func configureCurrentCell() {
        guard let indexPath = listRecipesTableView.indexPathForSelectedRow, let currentCell = listRecipesTableView.cellForRow(at: indexPath) as? RecipeTableViewCell else {return}
        
        recipeImage = currentCell.recipeImageView.image
        recipeName = currentCell.recipeTitleLabel.text
        recipeIngredients = currentCell.recipeDetailLabel.text
        recipeTotalTimeAndRating = currentCell.totalTimeAndRatingRecipeLabel.text
        recipeId = currentCell.recipeId
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        configureCurrentCell()
        
        guard segue.identifier == "DisplayRecipe" else {return}
        
        guard let viewController = segue.destination as? RecipeViewController else {return}
        
        viewController.displayRecipeImage = recipeImage
        viewController.displayRecipeName = recipeName
        viewController.displayRecipeIngredients = recipeIngredients
        viewController.displayRecipeTotalTimeAndRating = recipeTotalTimeAndRating
        viewController.recipeId = recipeId
    }
}
