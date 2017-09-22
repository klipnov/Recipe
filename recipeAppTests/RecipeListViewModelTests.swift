//
//  RecipeListViewModelTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp

class RecipeListViewModelTests: XCTestCase {
    
    func testRecipeListViewModelHasArrayOfRecipes() {
        let viewModel = RecipeListViewModel()
        XCTAssertTrue((viewModel.recipes as Any) is [Recipe])
    }
    
    func testViewModelCanFetchRecipesFromPersistentStorage() {
        //mock recipe data
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let recipe = Recipe(entity: Recipe.entity(), insertInto: managedObjectContext)
        
        recipe.name = "Test Recipe"
        recipe.ingredients = "Cheese"
        recipe.steps = "Melt the cheese"
        recipe.type = "Cheesy"
        
        //start the test
        let viewModel = RecipeListViewModel()
        
        viewModel.fetchRecipes()
        
        let recipes = viewModel.recipes
        
        XCTAssertEqual(recipes[0].name, "Test Recipe")
        XCTAssertEqual(recipes[0].ingredients, "Cheese")
        XCTAssertEqual(recipes[0].steps, "Melt the cheese")
        XCTAssertEqual(recipes[0].type, "Cheesy")
    }
    
}
