//
//  RecipeDetailTableViewController.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    let viewModel = RecipeDetailViewModel()
    var presenter: RecipeListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.keyboardDismissMode = .onDrag
    }
    
    func setupViewControllerForNewRecipe() {
        self.title = "New Recipe"
        saveButton.isEnabled = false
        viewModel.createANewRecipe()
    }
    
    func setupViewControllerForEditRecipe() {
        self.title = "Edit Recipe"
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        viewModel.deleteRecipe()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        do {
            try viewModel.saveRecipe()
            dismiss(animated: true, completion: {
                self.presenter?.viewModel.fetchRecipes()
            })
        } catch {
            print("error: \(error)")
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
            
            return cell
        case .twoLabelCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLabelCell") as! TwoLabelTableViewCell
            
            cell.leftLabel.text = rowData.rowName
            cell.rightLabel.text = rowData.data
            
            return cell
        case .textViewCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell") as! TextViewTableViewCell
            
            if let text = rowData.data {
                cell.textView.text = text
            }
            
            return cell
        default:
            return UITableViewCell()
        }
    }

}
