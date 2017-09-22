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
        viewModel.createANewRecipe()
    }
    
    func setupViewControllerForEditRecipe() {
        self.title = "Edit Recipe"
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        
        viewModel.deleteRecipe()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        do {
            try viewModel.saveRecipe()
            self.presenter?.viewModel.fetchRecipes()

            dismiss(animated: true, completion:nil)
        } catch {
            print("error: \(error)")
            showAlert(title: "Unable To Save Recipe", message: "Please insert a recipe name with atleast 2 characters and choose a recipe type")
        }
    }
    
    func enableSaveButton() {
        do {
            try viewModel.validateRecipe()
            saveButton.isEnabled = true
        } catch {
            print("Error: \(error)")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.rowData.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowData.items(inSection: section)?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionNames[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let rowData = viewModel.rowData.item(at: indexPath) as? TableViewRowData else {
            return UITableViewCell()
        }
        
        switch rowData.cellType {
        case .textFieldCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldTableViewCell
            
            if rowData.data == nil {
                cell.textField.placeholder = rowData.rowName
            } else {
                cell.textField.text = rowData.data
            }
            
            cell.didUpdateTextfield = { (string) in
                guard let recipeName = string else {
                    return
                }
                
                self.viewModel.recipe?.name = recipeName
                self.enableSaveButton()
            }
            
            return cell
        case .twoLabelCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelCell") as! TwoLabelTableViewCell
            
            cell.leftLabel.text = rowData.rowName
            cell.rightLabel.text = rowData.data ?? "Choose Type"
            
            return cell
        case .textViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell") as! TextViewTableViewCell
            
            if let text = rowData.data {
                cell.textView.text = text
            }
            
            return cell
        case .recipeTypePickerViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTypePickerCell") as! RecipeTypesPickerViewTableViewCell
            
            cell.didSelectRow = { (string) in
                self.viewModel.recipe?.type = string
                self.viewModel.updateRecipeType(string: string)
                self.enableSaveButton()
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let rowData = viewModel.rowData.item(at: indexPath) as? TableViewRowData  else {
            return
        }
        
        switch rowData.rowName {
        case "Recipe Type":
            viewModel.togglePickerRow()
        default:
            break
        }
        
    }

}
