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
    static var ingredient = Ingredient()
    static  var recipes = [Recipe]()
    
    static func add(recipe: Recipe) {
        RecipesService.recipes.append(recipe)
    }
    
    static func removeAllRecipes() {
        RecipesService.recipes.removeAll()
    }
    
    static func getRecipes(callback: @escaping (Bool, Recipe?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipes?_app_id=c6c31355&_app_key=aee377896e644dc57412080e345bfc7e",
                          method: .get, parameters: ["q": "\(ingredient.name)", "allowedAllergy[]": "\(SettingService.eggAllergy)&allowedAllergy[]=\(SettingService.glutenAllergy)&allowedAllergy[]=\(SettingService.peanutAllergy)"])
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyRecipeApiResponse.self, from: data)
                    
                    guard let recipes = responseJSON?.matches else {return}
                    
                    for (index, _) in recipes.enumerated() {
                        guard let ingredients = responseJSON?.matches[index].ingredients,
                            let recipeName = responseJSON?.matches[index].recipeName, let totalTimeInSeconds = responseJSON?.matches[index].totalTimeInSeconds,
                            let rating = responseJSON?.matches[index].rating, let id = responseJSON?.matches[index].id else {return}
                        
                        let onlyIngredients = ingredients.joined(separator: ", ")
                        let totalTimeInMinutes = totalTimeInSeconds/60
                        let totalTimeAndRating = String("\(totalTimeInMinutes)" + " " + "M" + "\n" + "\(rating)" + " " + "🙂")
                        
                        getRecipeDetail(recipeId: id) { (ingredientLines, recipeImage) in
                            guard let ingredientLines = ingredientLines, let recipeImage = recipeImage  else {return}
                            
                            let recipe = Recipe(name: recipeName, ingredients: onlyIngredients, totalTimeAndRating: totalTimeAndRating, recipeImage: recipeImage, ingredientLines: ingredientLines)
                            callback(true, recipe)
                        }
                    }
                    
                case .failure:
                    callback(false, nil)
                }
        }
    }
    
    static private func getRecipeDetail(recipeId: String, callback: @escaping (String?, UIImage?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipe/\(recipeId)?_app_id=c6c31355&_app_key=aee377896e644dc57412080e345bfc7e",
            method: .get)
            
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyRecipeDetailApiResponse.self, from: data)
                    
                    guard let ingredientLines = responseJSON?.ingredientLines, let recipeImageUrl = responseJSON?.images[0].hostedLargeURL else {return}
                    
                    getRecipeImage(url: recipeImageUrl) { (recipeImage) in
                        guard let recipeImage = recipeImage else {return}
                        
                        let onlyIngredientLines = ingredientLines.joined(separator: ",")
                        
                        callback(onlyIngredientLines, recipeImage)
                    }
                case .failure:
                    callback(nil, nil)
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
}


