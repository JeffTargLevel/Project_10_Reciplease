//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 26/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoriteRecipe: NSManagedObject {
    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else {
            return[]
        }
        return favoritesRecipes
    }
    
    static func saveFavoriteRecipe(name: String, ingredients: String, totalTimeAndRating: String, image: UIImage, ingredientLines: String) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.name = name
        favoriteRecipe.ingredients = ingredients
        favoriteRecipe.totalTimeAndRating = totalTimeAndRating
        favoriteRecipe.image = image.pngData()
        favoriteRecipe.ingredientLines = ingredientLines
        try? AppDelegate.viewContext.save()
        
    }
    
    static func remove(favoriteRecipe: FavoriteRecipe) {
        AppDelegate.viewContext.delete(favoriteRecipe)
        try? AppDelegate.viewContext.save()
    }
}
