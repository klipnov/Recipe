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
    }
}

extension RecipeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = { () -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") else {
                return UITableViewCell(style: .default, reuseIdentifier: "recipeCell")
            }
            return cell
        }()
        return cell
    }
    
}
