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
    
    var recipesFound: RecipesFound?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRequest()
    }
    
    func toggleActivityIndicator(shown: Bool) {
        listRecipesTableView.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    private func updateRequest() {
        toggleActivityIndicator(shown: true)
        RecipesService.getRecipes { (success, recipesFound) in
            self.toggleActivityIndicator(shown: false)
            if success, let recipesFound = recipesFound {
                self.recipesFound = recipesFound
                RecipesService.add(recipe: recipesFound)
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
    
    private func presentAlert() {
        presentAlert(withTitle: "Error", message: "Search failed")
    }
}
