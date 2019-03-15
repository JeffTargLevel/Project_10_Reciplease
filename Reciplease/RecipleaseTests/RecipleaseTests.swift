//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Jean-François Santolaria on 31/01/2019.
//  Copyright © 2019 OpenClassroomsFRSantolariaJF. All rights reserved.
//

import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {
    
    func getGoodRecipeRequest() {
        RecipesService.ingredient.name = "cheese"
        let expectation = XCTestExpectation(description: "Wait for queue change")
        RecipesService.getRecipes { (success, recipe) in
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithoutAllergy() {
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithEggAllergy() {
        SettingService.eggAllergy = "397^Egg-Free"
        
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithGlutenAllergy() {
        SettingService.glutenAllergy = "393^Gluten-Free"
        
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithPeanutAllergy() {
        SettingService.peanutAllergy = "394^Peanut-Free"
        
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithoutEggAllergy() {
        SettingService.eggAllergy = ""
        
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithoutGlutenAllergy() {
        SettingService.glutenAllergy = ""
        
        getGoodRecipeRequest()
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithoutPeanutAllergy() {
        SettingService.peanutAllergy = ""
        
        getGoodRecipeRequest()
    }
    
    func testSaveFavoriteRecipeInViewContext() {
        let recipeFake = RecipeFake()
        FavoriteRecipe.saveFavoriteRecipe(name: recipeFake.name, ingredients: recipeFake.ingredients, totalTimeAndRating: recipeFake.totalTimeAndRating, image: recipeFake.recipeImage, ingredientLines: recipeFake.ingredientLines)
    }
    
    func testDeleteFavoriteRecipeInViewContext() {
        let recipeFake = RecipeFake()
        FavoriteRecipe.saveFavoriteRecipe(name: recipeFake.name, ingredients: recipeFake.ingredients, totalTimeAndRating: recipeFake.totalTimeAndRating, image: recipeFake.recipeImage, ingredientLines: recipeFake.ingredientLines)
        let favoriteRecipe = FavoriteRecipe.all[0]
        FavoriteRecipe.remove(favoriteRecipe: favoriteRecipe)
    }
}
