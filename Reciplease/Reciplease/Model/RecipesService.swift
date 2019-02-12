//
//  RecipesService.swift
//  Reciplease
//
//  Created by Jean-François Santolaria on 02/02/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RecipesService {
    static var ingredients = Ingredients()
    static  var recipes = [Recipe]()
    
    static func add(recipe: Recipe) {
        RecipesService.recipes.append(recipe)
    }
    
    static func getRecipes(callback: @escaping (Bool, RecipesFound?) -> Void) {
        Alamofire.request("http://api.yummly.com/v1/api/recipes?_app_id=c6c31355&_app_key=aee377896e644dc57412080e345bfc7e&requirePictures=true", method: .get, parameters: ["q": "\(ingredients.name)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    let json = try? JSON(data: response.data!)
                    
                    guard let recipes = json?["matches"] else {
                        return
                    }
                    for (index, _) in recipes.enumerated() {
                        guard let recipeName = json?["matches"][index]["recipeName"].description, let ingredients = json?["matches"][index]["ingredients"].description else {
                            return
                        }
                        let onlyIngredients = ingredients.replacingOccurrences(of: "[\n  \"", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n ", with: "").replacingOccurrences(of: "\n]", with: "")
                        let recipesFound = RecipesFound(name: recipeName, ingredients: onlyIngredients)
                        callback(true, recipesFound)
                    }
                case .failure:
                    callback(false, nil)
                }
        }
    }
}
