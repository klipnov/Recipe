//
//  RecipeDetailTableViewController.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeDetailTableViewController: UITableViewController, AlertDisplaying {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let viewModel = RecipeDetailViewModel()
    var presenter: RecipeListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.keyboardDismissMode = .onDrag
        
        viewModel.didTogglePickerView = {
            (isInserted,indexPath) in
            if isInserted {
                self.tableView.insertRows(at: [indexPath], with: .automatic)
            } else {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        viewModel.didSelectPickerString = {
            (indexPath) in
            self.tableView.reloadRows(at:[indexPath], with: .none)
        }
    }
    
    func setupViewControllerForNewRecipe() {
        self.title = "New Recipe"
        saveButton.isEnabled = false
        viewModel.createNewRecipe()
    }
    
    func setupViewControllerForEditRecipe() {
        self.title = "Edit Recipe"
        self.navigationItem.leftBarButtonItem = nil
        viewModel.editRecipe()
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        viewModel.deleteRecipe()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        view.endEditing(true)
        do {
            try viewModel.saveRecipe()
            
            //update the presenter to relect new changes
            self.presenter?.viewModel.fetchRecipes(filterBy: "All")
            
            //if user is editing recipe pop viewcontroller
            if self.title == "Edit Recipe" {
                navigationController?.popViewController(animated: true)
            } else {
                
                //else user is added a new recipe and dismiss viewcontroller
                dismiss(animated: true) {
                    let showDeleteTip = UserDefaults().bool(forKey: "ShowDeleteTip")

                    if !showDeleteTip {
                        UserDefaults().set(true, forKey: "ShowDeleteTip")
                        self.presenter?.showTip()
                    }
                }
            }
        } catch {
            print("error: \(error)")
            showAlert(title: "Unable To Save Recipe", message: "Please insert a recipe name with atleast 2 characters and choose a recipe type")
        }
    }
    
    func enableSaveButton() {
        do {
            try viewModel.validateRecipe()
            saveButton.isEnabled = true
        } catch {}
    }

}
