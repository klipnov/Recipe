//
//  RecipeDetailViewModelTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
import CoreData
import DTModelStorage
@testable import recipeApp

class RecipeDetailViewModelTests: XCTestCase {
    
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    
    func mockData() -> Recipe {
        let recipe = Recipe(entity: Recipe.entity(), insertInto: viewContext)
        
        recipe.name = "Test Recipe"
        recipe.ingredients = "Cheese"
        recipe.steps = "Melt the cheese"
        recipe.type = "Cheesy"
        
        return recipe
    }
    
    override func tearDown() {
        deleteAllRecipe()
    }
    
    func deleteAllRecipe() {
        let recipesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Recipe")
        
        do {
            let fetchedRecipes = try viewContext.fetch(recipesFetch) as! [Recipe]
            
            for recipe in fetchedRecipes {
                viewContext.delete(recipe)
            }
        } catch {
            print("Error: \(error)")
        }
        
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
        
        //delete all recipes
        
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
        
        let viewModel = RecipeDetailViewModel()
        
        //rowData is not nil
        XCTAssertNotNil(viewModel.rowData)
        
        //rowData is a type of TableViewRowData
        if let data = viewModel.rowData.item(at: IndexPath(row: 0, section: 0)) as? TableViewRowData {
            XCTAssertTrue(true)
            
            //rowData has default data after initialize
            XCTAssertEqual(data.rowName, "Recipe Name")
        } else {
            XCTAssertTrue(false)
        }
    }
    
}
