//
//  RecipeSaveError.swift
//  recipeApp
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation

enum RecipeSaveError: Error {
    case nameIsLessThan2Characters
    case typeIsEmpty
    case saveError(String)
}
