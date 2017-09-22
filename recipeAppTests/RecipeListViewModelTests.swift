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
    
    func mockData() {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let recipe = Recipe(entity: Recipe.entity(), insertInto: managedObjectContext)
        
        recipe.name = "Test Recipe"
        recipe.ingredients = "Cheese"
        recipe.steps = "Melt the cheese"
        recipe.type = "Cheesy"
    }
    
    func testRecipeListViewModelHasArrayOfRecipes() {
        let viewModel = RecipeListViewModel()
        XCTAssertTrue((viewModel.recipes as Any) is [Recipe])
    }
    
    func testViewModelCanFetchRecipesFromPersistentStorage() {
        //mock recipe data
        mockData()
        
        //start the test
        let viewModel = RecipeListViewModel()
        
        viewModel.fetchRecipes()
        
        let recipes = viewModel.recipes
        
        XCTAssertEqual(recipes[0].name, "Test Recipe")
        XCTAssertEqual(recipes[0].ingredients, "Cheese")
        XCTAssertEqual(recipes[0].steps, "Melt the cheese")
        XCTAssertEqual(recipes[0].type, "Cheesy")
    }
    
    func testdidUpdateRecipeUponSuccessfulFetchUpdateData() {
        
        let expectation = XCTestExpectation(description: "Test if did update is called")
        
        //mock recipe data
        mockData()
        
        //start the test
        let viewModel = RecipeListViewModel()
        
        //true will get called if didUpdate recipe is called before 2 seconds
        viewModel.didUpdateRecipes = {
            expectation.fulfill()
            XCTAssertEqual(viewModel.recipes[0].name, "Test Recipe")
        }
        
        viewModel.fetchRecipes()
        
        wait(for: [expectation], timeout: 2.0)
    }
    
}
