//
//  RecipeDetailViewController+TableViewDelegateAndDataSource.swift
//  recipeApp
//
//  Created by Shah Qays on 24/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

extension RecipeDetailTableViewController {
    
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
                cell.textField.placeholder = rowData.rowName.rawValue
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
            
            cell.leftLabel.text = rowData.rowName.rawValue
            cell.rightLabel.text = rowData.data ?? "Choose Type"
            
            return cell
        case .textViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell") as! TextViewTableViewCell
            
            cell.updateCellPlaceholder(string: rowData.rowName.rawValue)
            
            if let text = rowData.data {
                cell.textView.text = text
            }
            
            cell.didEndEditing = { (string) in
                if rowData.rowName == .recipeIngredients {
                    self.viewModel.recipe?.ingredients = string
                } else {
                    self.viewModel.recipe?.steps = string
                }
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
        case .deleteCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeleteCell") as! DeleteTableViewCell
            cell.label.text = rowData.rowName.rawValue
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
        case .recipeType:
            viewModel.togglePickerRow()
            viewModel.setDefaultRecipeTypeIfNotSet()
        case .deleteRecipe:
            showConfirmationAlert(title: "Delete \(viewModel.recipe!.name!)?", message: "Recipe deletion cannot be undone", confirmHandler: {
                self.viewModel.deleteRecipe()
                self.presenter?.viewModel.fetchRecipes(filterBy: "All")
                self.navigationController?.popViewController(animated: true)
            })
        default:
            break
        }
    }
}
