//
//  RecipeListViewController.swift
//  recipeApp
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = RecipeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "recipeCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        viewModel.didUpdateRecipes = {
            self.tableView.reloadData()
        }
        
        viewModel.fetchRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "editRecipe" {
            
            let recipeDetailTableVC = segue.destination as! RecipeDetailTableViewController
            
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
}

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
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
    
}

