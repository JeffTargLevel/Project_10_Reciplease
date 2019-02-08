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
    var ingredients = Ingredients()
    
    func getRecipes() {
        Alamofire.request("http://api.yummly.com/v1/api/recipes?_app_id=c6c31355&_app_key=aee377896e644dc57412080e345bfc7e&requirePictures=true", method: .get, parameters: ["q": "\(ingredients.name)"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    
                
                    let json = try? JSON(data: response.data!)
                    var index = 0
        
                    
                    var recipeName = [json?["matches"][index]["recipeName"]]
                    
                    
                    
                    
                
                    let ingredients = json!["matches"][0]["ingredients"]
                    
                    
                    print(recipeName)
                  // print(ingredients)
                    
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
        }
    }
}
