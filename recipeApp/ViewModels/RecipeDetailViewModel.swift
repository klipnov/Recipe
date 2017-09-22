//
//  RecipeDetailViewModel.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation

enum RecipeSaveError: Error {
    case nameIsLessThan2Characters
    case typeIsEmpty
    case saveError(String)
}

class RecipeDetailViewModel {
    
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    var recipe: Recipe?
    
    init() {
        
    }
    
    func createANewRecipe() {
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
