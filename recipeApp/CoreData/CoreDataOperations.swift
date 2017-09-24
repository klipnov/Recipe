//
//  CoreDataCRUD.swift
//  recipeApp
//
//  Created by Shah Qays on 24/09/2017.
//  Copyright © 2017 Shah Qays. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataOperations {}

extension CoreDataOperations {
    
    var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }
    
    func createRequest<T: NSManagedObject>(entity: T.Type, sort: [NSSortDescriptor]? = nil, predicate: NSPredicate? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        let request = T.fetchRequest()
        request.sortDescriptors = sort
        request.predicate = predicate
        
        return request
    }
    
    func fetchEntity<T: NSManagedObject>(entity: T.Type, sort: [NSSortDescriptor]? = nil, predicate: NSPredicate? = nil, viewContext: NSManagedObjectContext) -> [T] {
        let request = createRequest(entity: entity, sort: sort,predicate: predicate)
        
        do {
            let result = try viewContext.fetch(request)
            return result as! [T]
        } catch {
            print("error \(error)")
            return [T]()
        }
    }
    
}
