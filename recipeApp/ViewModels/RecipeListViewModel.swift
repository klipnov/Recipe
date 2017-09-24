//
//  RecipeListViewModel.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import CoreData

class RecipeListViewModel: CoreDataOperations {
    
    var recipes = [Recipe]()
    var recipeEntityName = "Recipe"
    var didUpdateRecipes: (()->Void)?
    
    func fetchRecipes(filterBy: String?) {
        
        let predicate: NSPredicate?
        
        if let filterBy = filterBy, filterBy != "All" {
            predicate = NSPredicate(format: "type == %@", filterBy)
        } else {
            predicate = nil
        }
        
        recipes = fetchEntity(entity: Recipe.self, predicate: predicate, viewContext: viewContext)
        didUpdateRecipes?()
    }
    
    func deleteRecipe(recipe: Recipe, filterBy: String) {
        
        viewContext.delete(recipe)
        
        do {
            try viewContext.save()
        } catch {
            print("Error:\(error)")
        }
        
        fetchRecipes(filterBy: filterBy)
    }

    
}
