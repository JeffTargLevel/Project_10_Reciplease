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
    static var ingredients = Ingredients()
    static  var recipes = [Recipe]()
    
    static func add(recipe: Recipe) {
        RecipesService.recipes.append(recipe)
    }
    
    static func removeAllRecipes() {
        RecipesService.recipes.removeAll()
    }
    
    static func getRecipes(callback: @escaping (Bool, Recipe?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipes?_app_id=c6c31355&_app_key=aee377896e644dc57412080e345bfc7e&requirePictures=true",
                          method: .get, parameters: ["q": "\(ingredients.name)"])
            .validate(statusCode: 200..<300)
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    
                    let responseJSON = try? JSONDecoder().decode(YummlyApiResponse.self, from: data)
                    
                    guard let recipes = responseJSON?.matches else {return}
                    
                    for (index, _) in recipes.enumerated() {
                        guard let recipeImageUrl = responseJSON?.matches[index].imageUrlsBySize.the90, let ingredients = responseJSON?.matches[index].ingredients,
                            let recipeName = responseJSON?.matches[index].recipeName, let totalTimeInSeconds = responseJSON?.matches[index].totalTimeInSeconds,
                            let rating = responseJSON?.matches[index].rating else {return}
                        
                        let onlyIngredients = ingredients.joined(separator: ",")
                        let totalTimeInMinutes = totalTimeInSeconds/60
                        let totalTimeAndRating = String("\(totalTimeInMinutes)" + " " + "M" + "\n" + "\(rating)" + " " + "🙂")
                        
                        getRecipeImage(url: recipeImageUrl) { (recipeImage) in
                            guard let recipeImage = recipeImage else {return}
                            
                            let recipe = Recipe(name: recipeName, ingredients: onlyIngredients, totalTimeAndRating: totalTimeAndRating, recipeImage: recipeImage)
                                callback(true, recipe)
                            }
                    }
                case .failure:
                    callback(false, nil)
                }
        }
    }
    
    static private func getRecipeImage(url: String, completionHandler: @escaping ((UIImage?) -> Void)) {
        Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                guard let recipeImage = UIImage(data: responseData.data!) else {return}
                
             completionHandler(recipeImage)
            })
    }
}
