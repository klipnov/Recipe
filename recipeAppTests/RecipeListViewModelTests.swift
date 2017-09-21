//
//  RecipeListViewModelTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp

class RecipeListViewModelTests: XCTestCase {
    
    func testRecipeListViewModelHasArrayOfRecipes() {
        let viewModel = RecipeListViewModel()
        XCTAssertTrue((viewModel.recipes as Any) is [Recipe])
    }
    
}
