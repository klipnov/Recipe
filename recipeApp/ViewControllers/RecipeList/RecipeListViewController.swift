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

