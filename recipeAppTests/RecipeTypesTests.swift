//
//  RecipeTypesTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp

class RecipeTypesTests: XCTestCase {
    
    func testRecipeTypesHaveNames() {
        let recipeTypes = RecipeTypes()
        
        XCTAssertTrue((recipeTypes.names as Any) is [String])
    }
    
    func testRecipeTypesCanLoadDataFromXMLFileAndInsertDataIntoNames() {
        let recipeTypes = RecipeTypes()
                
       // XCTAssertTrue(recipeTypes.names[0] == "Vegetarian")
    }
    
}
