//
//  RecipeListViewController+TableViewDelegateAndDataSource.swift
//  recipeApp
//
//  Created by Shah Qays on 24/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = viewModel.recipes.count
        
        noResult.isHidden = count != 0
        
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if selectedFilter == "All" {
            return ""
        } else {
            return "Recipes are filtered by \(selectedFilter) type"
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = viewModel.recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OneLabelCell") as! OneLabelTableViewCell
        
        cell.label.text = recipe.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipe = viewModel.recipes[indexPath.row]
        
        performSegue(withIdentifier: "editRecipe", sender: recipe)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let recipe = viewModel.recipes[indexPath.row]
            showConfirmationAlert(title: "Delete \(recipe.name!)?", message: "Recipe deletion cannot be undone", confirmHandler: {
                self.viewModel.deleteRecipe(recipe: recipe, filterBy: self.selectedFilter)
            })
        }
    }
    
}
