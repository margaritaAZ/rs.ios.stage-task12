//
//  TestCoreDataManager.swift
//  RSSchool_T12Tests
//
//  Created by Маргарита Жучик on 5.11.21.
//

import Foundation
import CoreData
@testable import RSSchool_T12

class TestCoreDataManager: CoreDataManagerProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: "RSSchool_T12")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var contextHasChanges: Bool { managedContext.hasChanges }
    lazy var managedContext: NSManagedObjectContext = { persistentContainer.viewContext }()
    
    func getObject(_ objectId: NSManagedObjectID) -> NSManagedObject? {
        var object: NSManagedObject?
        do {
            object = try managedContext.existingObject(with: objectId)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return object
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func cancelChanges() {
        managedContext.rollback()
    }
    
    func deleteObject(_ object: NSManagedObject) {
        managedContext.delete(object)
        saveContext()
    }
}
