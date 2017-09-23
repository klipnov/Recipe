//
//  RecipeListViewController.swift
//  recipeApp
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, AlertDisplaying {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = RecipeListViewModel()
    @IBOutlet var noResult: UILabel!
    let recipeFilter = RecipeTypeFilterActionSheet()
    var selectedFilter = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recipeCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundView = noResult
        
        viewModel.didUpdateRecipes = {
            self.tableView.reloadData()
        }
        
        recipeFilter.didUpdateFilter = { (string) in
            self.selectedFilter = string
            self.viewModel.fetchRecipes(filterBy: string)
        }
        
        viewModel.fetchRecipes(filterBy: selectedFilter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editRecipe" {
            
            let recipeDetailTableVC = segue.destination as! RecipeDetailTableViewController
            
            guard let recipe = sender as? Recipe else {
                return
            }
            
            recipeDetailTableVC.viewModel.recipe = recipe
            recipeDetailTableVC.setupViewControllerForEditRecipe()
            recipeDetailTableVC.presenter = self
            
        } else if segue.identifier == "newRecipe" {
            
            guard let navigationViewController = segue.destination as? UINavigationController else {
                return
            }
            
            guard let recipeDetailViewController = navigationViewController.viewControllers.first as? RecipeDetailTableViewController else {
                return
            }

            recipeDetailViewController.setupViewControllerForNewRecipe()
            recipeDetailViewController.presenter = self

        }
    }
    
    @IBAction func didTapFilterButton(_ sender: Any) {
        recipeFilter.showRecipeTypesFilter(viewController: self)
    }
    
    func showTip() {
        showAlert(title: "Tip", message: "You can delete recipes by swiping right to left on a recipe")
    }
    
}

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
                    self.viewModel.deleteRecipe(recipe: recipe)
            })
        }
    }
    
}

