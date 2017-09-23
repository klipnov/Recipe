//
//  TableViewRowData.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation

struct TableViewRowData: Equatable {
    let rowName: RecipeRowNames
    let data: String?
    let cellType: cellType
    
    static func ==(lhs: TableViewRowData, rhs: TableViewRowData) -> Bool {
        return
            lhs.rowName == rhs.rowName &&
            lhs.data == rhs.data &&
            lhs.cellType == rhs.cellType
    }
}
