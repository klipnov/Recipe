//
//  RecipeDetailViewModelTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp

class RecipeDetailViewModelTests: XCTestCase {
    
    func testViewModelContainsRecipes() {
        let viewModel = RecipeDetailViewModel()
        XCTAssertNotNil(viewModel.recipes)
    }
    
    func testARecipeCanBeInjectedIntoViewModel() {
        
        let viewModel = RecipeDetailViewModel()
        
        //create recipe mock
        //let recipe =
        
    }
    
}
