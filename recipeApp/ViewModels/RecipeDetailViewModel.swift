//
//  RecipeDetailViewModel.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import DTModelStorage

class RecipeDetailViewModel {
    
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    var recipe: Recipe?
    var sectionNames = ["", "Ingredients", "Steps"]
    var rowData = MemoryStorage()
    
    init() {

    }
    
    func initializeRowData() {
        let recipeName = TableViewRowData(rowName: "Recipe Name",
                                          data: recipe?.name ?? nil,
                                          cellType: .textFieldCell)
        let recipeType = TableViewRowData(rowName: "Recipe Type",
                                          data: recipe?.type ?? nil,
                                          cellType: .twoLabelCell)
        
        rowData.addItems([recipeName,
                          recipeType], toSection: 0)
        
        let ingredientsString = recipe?.ingredients ?? "List ingredients here."
        let recipeIngredients = TableViewRowData(rowName: "Recipe Ingredients",
                                                 data: ingredientsString,
                                                 cellType: .textViewCell)
        
        rowData.addItems([recipeIngredients],
                         toSection: 1)
        
        let stepsString = recipe?.steps ?? "List steps here."
        let recipeSteps = TableViewRowData(rowName: "Recipe Steps",
                                           data: stepsString,
                                           cellType: .textViewCell)
        
        rowData.addItems([recipeSteps],
                         toSection: 2)
        
    }
    
    //Mark: - Create, save and delete
    
    func createANewRecipe() {
        initializeRowData()
        let recipe = Recipe(entity: Recipe.entity(), insertInto: viewContext)
        self.recipe = recipe
    }
    
    func saveRecipe() throws {
        
        //check for recipe name
        guard let recipeName = recipe?.name, recipeName.count > 1 else {
                throw RecipeSaveError.nameIsLessThan2Characters
        }
        
        //check for recipe type
        guard recipe?.type != nil else {
                throw RecipeSaveError.typeIsEmpty
        }
        
        do {
           try viewContext.save()
        } catch {
            throw RecipeSaveError.saveError(error.localizedDescription)
        }
    }
    
    func deleteRecipe() {
        
        guard let recipe = recipe else {
            return
        }
        
        viewContext.delete(recipe)
        self.recipe = nil
    }
    
}
