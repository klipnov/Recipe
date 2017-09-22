//
//  CoreDataManagerTests.swift
//  recipeAppTests
//
//  Created by Shah Qays on 22/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import XCTest
@testable import recipeApp
class CoreDataManagerTests: XCTestCase {
    
    func testCoreDataMananagerIsASingleton() {
            let coreDataManager = CoreDataManager.shared
        
            XCTAssertNotNil(coreDataManager)
    }
    
    func testCoreDataHasTheRightContainerNameAndCanReturnViewContext() {
        let coreDataManager = CoreDataManager.shared
        
        let containerName = coreDataManager.persistentContainer.name
        let managedObjectContext = coreDataManager.persistentContainer.viewContext
        
        XCTAssertEqual(containerName, "recipeApp")
        XCTAssertNotNil(managedObjectContext)
    }
    
}
