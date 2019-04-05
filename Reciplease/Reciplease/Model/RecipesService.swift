//
//  RecipesService.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 02/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import Alamofire

class RecipesService {
    
    static private let yummlyApiKey = YummlyApiKey()
    static var ingredient = Ingredient()
    static var recipes = [Recipe]()
    
    static func add(recipe: Recipe) {
        RecipesService.recipes.append(recipe)
    }
    
    static func removeAllRecipes() {
        RecipesService.recipes.removeAll()
    }
    
    static func getRecipes(callback: @escaping (Bool, Recipe?, Bool) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipes?\(yummlyApiKey.key)",
                          method: .get, parameters: ["q": "\(ingredient.name)", "allowedAllergy[]": "\(SettingService.eggAllergy)&allowedAllergy[]=\(SettingService.glutenAllergy)&allowedAllergy[]=\(SettingService.peanutAllergy)"])
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyRecipeApiResponse.self, from: data)
                    
                    guard let recipes = responseJSON?.matches else {return}
                    
                    let recipesTotal = recipes.count
                    var recipesFound = 0
                    
                    for (index, _) in recipes.enumerated() {
                        guard let ingredients = responseJSON?.matches[index].ingredients,
                            let recipeName = responseJSON?.matches[index].recipeName, let totalTimeInSeconds = responseJSON?.matches[index].totalTimeInSeconds,
                            let rating = responseJSON?.matches[index].rating, let id = responseJSON?.matches[index].id else {return}
                        
                        let onlyIngredients = ingredients.joined(separator: ", ")
                        let totalTimeInMinutes = totalTimeInSeconds/60
                        let totalTimeAndRating = String("\(totalTimeInMinutes)" + " " + "M" + "\n" + "\(rating)" + " " + "🙂")
                        
                        getRecipeImageId(recipeId: id) { (recipeImage) in
                            guard let recipeImage = recipeImage else {return}
                            
                            recipesFound += 1
                            
                            let recipe = Recipe(name: recipeName, ingredients: onlyIngredients, totalTimeAndRating: totalTimeAndRating, recipeImage: recipeImage, recipeId: id)
                            callback(true, recipe, recipesTotal == recipesFound)
                        }
                    }
                case .failure:
                    callback(false, nil, false)
                }
        }
    }
    
    static private func getRecipeImageId(recipeId: String, callback: @escaping (UIImage?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipe/\(recipeId)?\(yummlyApiKey.key)",
            method: .get)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyRecipeDetailApiResponse.self, from: data)
                    
                    guard let recipeImageUrl = responseJSON?.images[0].hostedLargeURL else {return}
                    
                    getRecipeImage(url: recipeImageUrl) { (recipeImage) in
                        guard let recipeImage = recipeImage else {return}
                        
                        callback(recipeImage)
                    }
                case .failure:
                    callback(nil)
                }
        }
    }
    
    static private func getRecipeImage(url: String, completionHandler: @escaping (UIImage?) -> Void) {
        Alamofire.request(url, method: .get)
            .validate()
            .responseData { (response) in
                guard let recipeImage = UIImage(data: response.data!) else {return}
                
                completionHandler(recipeImage)
        }
    }
    
    static func getRecipeDetail(recipeId: String, callback: @escaping (String?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipe/\(recipeId)?\(yummlyApiKey.key)",
            method: .get)
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyRecipeDetailApiResponse.self, from: data)
                    
                    guard let ingredientLines = responseJSON?.ingredientLines else {return}
                    
                    let onlyIngredientLines = ingredientLines.joined(separator: ",")
                    callback(onlyIngredientLines)
                    
                case .failure:
                    callback(nil)
                }
        }
    }
}

