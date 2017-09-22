//
//  RecipeDetailViewModel.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit
import DTModelStorage

class RecipeDetailViewModel {
    
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    var recipe: Recipe?
    var sectionNames = ["", "Ingredients", "Steps"]
    var rowData = MemoryStorage()
    var didTogglePickerView: ((Bool, IndexPath)->Void)?
    var didSelectPickerString: ((IndexPath)->Void)?
    
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
                          recipeType],
                         toSection: 0)
        
        let ingredientsString = recipe?.ingredients
        let recipeIngredients = TableViewRowData(rowName: "List ingredients here.",
                                                 data: ingredientsString,
                                                 cellType: .textViewCell)
        
        rowData.addItems([recipeIngredients],
                         toSection: 1)
        
        let stepsString = recipe?.steps
        let recipeSteps = TableViewRowData(rowName: "List steps here.",
                                           data: stepsString,
                                           cellType: .textViewCell)
        
        rowData.addItems([recipeSteps],
                         toSection: 2)
        
    }
    
    func togglePickerRow() {
        
        if let item = rowData.item(at: IndexPath(row: 2, section: 0)) as? TableViewRowData {
            do {
                try rowData.removeItem(item)
                didTogglePickerView?(false, IndexPath(row: 2, section: 0))
            } catch {
                print("error: \(error)")
                return
            }
        } else {
            let recipeType = TableViewRowData(rowName: "Recipe Type",
                                              data: recipe?.type,
                                              cellType: .recipeTypePickerViewCell)
            
            rowData.addItem(recipeType, toSection: 0)
            didTogglePickerView?(true, IndexPath(row: 2, section: 0))
        }        
    }
    
    func updateRecipeType(string: String) {
        
        if let currentRecipeTypeRow = rowData.item(at: IndexPath(row: 1, section: 0)) as? TableViewRowData {
            let newRecipeTypeRow = TableViewRowData(rowName: "Recipe Type", data: string, cellType: .twoLabelCell)
            do {
                try rowData.replaceItem(currentRecipeTypeRow, with: newRecipeTypeRow)
                didSelectPickerString?(IndexPath(row: 1, section: 0))
            } catch {
                print("Error: \(error)")
            }
            
        } else {
            
        }
    }
    
    func validateRecipe() throws {
        guard let recipeName = recipe?.name, recipeName.count > 1 else {
            throw RecipeSaveError.nameIsLessThan2Characters
        }
        
        guard recipe?.type != nil else {
            throw RecipeSaveError.typeIsEmpty
        }
    }
    
    //Mark: - Create, save and delete
    
    func createANewRecipe() {
        initializeRowData()
        let recipe = Recipe(entity: Recipe.entity(), insertInto: viewContext)
        self.recipe = recipe
    }
    
    func saveRecipe() throws {
        
        do {
            try validateRecipe()
        } catch {
            throw error
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
