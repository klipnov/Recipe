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
    var didUpdateRecipes: (()->Void)?
    let viewContext = CoreDataManager.shared.persistentContainer.viewContext
    
    func fetchRecipes() {
        let recipesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: recipeEntityName)
        
        do {
            let fetchedRecipes = try viewContext.fetch(recipesFetch) as! [Recipe]
            recipes = fetchedRecipes
            didUpdateRecipes?()
        } catch {
            print("Error: \(error)")
        }
        
    }
    
}
