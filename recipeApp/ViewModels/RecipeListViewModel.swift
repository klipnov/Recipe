//
//  RecipeListViewModel.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import CoreData

class RecipeListViewModel {
    
    var recipes = [Recipe]()
    var recipeEntityName = "Recipe"
    
    func fetchRecipes() {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let recipesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: recipeEntityName)
        
        do {
            let fetchedRecipes = try viewContext.fetch(recipesFetch) as! [Recipe]
            recipes = fetchedRecipes
        } catch {
            print("Error: \(error)")
        }
        
    }
    
}
