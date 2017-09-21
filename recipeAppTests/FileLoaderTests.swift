//
//  XMLParserTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 21/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp

class FileLoaderTests: XCTestCase {
    
    func testFileLoaderCanLoadAFile() {
        
        let fileLoader = FileLoader()
        
        var data: Data?
        do {
           data = try fileLoader.load(filename: "recipetypes.xml")
        } catch {
            print("error: \(error)")
        }
        
        XCTAssertNotNil(data)
    }
    
}
