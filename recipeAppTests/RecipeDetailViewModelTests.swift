//
//  RecipeDetailViewModelTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
import CoreData
@testable import recipeApp

class RecipeDetailViewModelTests: XCTestCase {
    
    func mockData() -> Recipe {
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let recipe = Recipe(entity: Recipe.entity(), insertInto: managedObjectContext)
        
        recipe.name = "Test Recipe"
        recipe.ingredients = "Cheese"
        recipe.steps = "Melt the cheese"
        recipe.type = "Cheesy"
        
        return recipe
    }
    
    func testARecipeCanBeInjectedIntoViewModel() {
        
        let viewModel = RecipeDetailViewModel()
        
        //create recipe mock
        let recipe = mockData()
        
        viewModel.recipe = recipe
        
        XCTAssertEqual(viewModel.recipe?.name, "Test Recipe")
        
    }
    
    func testRecipeDetailViewModelCanChangeStateToNewRecipe() {
        
        let viewModel = RecipeDetailViewModel()
        
        viewModel.createANewRecipe()
        
        //Make sure a new recipe is created
        XCTAssertTrue(viewModel.recipe != nil)
        
        //Check if the recipe is empty
        XCTAssertTrue(viewModel.recipe?.name == nil)
    }
    
    func testRecipeDetailViewModelCanDeleteRecipe() {
        
        let recipe = mockData()
        let viewModel = RecipeDetailViewModel()
        
        viewModel.recipe = recipe
        
        viewModel.deleteRecipe()
        
        //Make sure recipe is deleted and nil
        XCTAssertNil(viewModel.recipe)
        
        //Try and fetch recipes and makesure the count is 10
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let recipesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        
        do {
            let fetchedRecipes = try viewContext.fetch(recipesFetch) as! [Recipe]
            
            if fetchedRecipes.count == 0 {
                XCTAssertTrue(true)
            } else {
                XCTAssertTrue(false)
            }
            
        } catch {
            print("Error: \(error)")
        }
    }
    
    func testRecipeRequiresAtleastANameAndTypeBeforeSaving() {
        
        let viewModel = RecipeDetailViewModel()
        
        //create a new recipe
        viewModel.createANewRecipe()
        
        viewModel.recipe?.name = ""
        viewModel.recipe?.type = nil
        
        //check for recipe name
        do {
            try viewModel.saveRecipe()
            //if the program hits AssertTrue then it fails
            XCTAssertTrue(false)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testViewModelHasDefaultRowDataAndSectionNames() {
        
        
        
    }
    
}
