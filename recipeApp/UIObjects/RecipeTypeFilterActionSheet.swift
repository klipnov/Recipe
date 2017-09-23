//
//  RecipeTypeFilterActionSheet.swift
//  recipeApp
//
//  Created by Shah Qays on 23/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import UIKit

class RecipeTypeFilterActionSheet {
    
    var recipeTypes = [String]()
    var didUpdateFilter: ((String)->Void)?
    
    init() {
        recipeTypes = RecipeTypes().types
    }
}

extension RecipeTypeFilterActionSheet {
    
    func showRecipeTypesFilter(viewController: UIViewController) {
        let alertController = UIAlertController(title: "Filter", message: "Select a recipe type", preferredStyle: .actionSheet)
        
        let allAction = UIAlertAction(title: "All", style: .default) { (alert) in
            self.didUpdateFilter?("All")
        }
        alertController.addAction(allAction)
        
        recipeTypes.forEach { (string) in
            
            let action = UIAlertAction(title: string, style: .default, handler: { (alert) in
                self.didUpdateFilter?(string)
            })
            
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
}
